import logging
from enum import IntEnum
from texttable import Texttable
import boto3
from botocore.exceptions import ClientError
from datetime import datetime

# Set environment variables:
#   AWS_PROFILE=default
#   AWS_DEFAULT_REGION=......


class DormantRules(IntEnum):
    ACTIVE = 60
    INACTIVE = 180


class IAMUser:
    def __init__(self, name: str):
        self.username = name
        self.keys = []

    def key_count(self):
        return len(self.keys)

    def _get_dormant_status(self):
        """
        Only dormant if both keys have not been used
        Has to check if a user has 1 or 2 access keys
        The "active" status of a Key is not considered
        """
        for key in self.keys:
            days_since_today = datetime.today() - key[1].replace(tzinfo=None)
            if days_since_today.days < DormantRules.ACTIVE:
                return "Active"
            elif days_since_today.days < DormantRules.INACTIVE:
                return "Inactive"
        return "Dormant"

    def __repr__(self):
        return f'IAM user:       {self.username!r}\t' \
               f'Key count:      {self.key_count()!r}\t' \
               f'Dormant status: {self._get_dormant_status()!r}'


def rm_find_dormant_iam_keys():
    """
        Finds unused credentials similar to CLI commands:
            aws iam list-access-keys
            aws iam get-access-key-last-used
    """
    users_and_results = []
    try:
        iam = boto3.client('iam')
        # get list of users from resp dict. Default maxItems is 100.
        resp = iam.list_users(MaxItems=300)
        # get each UserName
        for user_dict in resp['Users']:
            username = user_dict.get('UserName', None)
            if username:
                user = IAMUser(username)
                response = iam.list_access_keys(
                    UserName=username,
                    MaxItems=2   # AWS "You can have a maximum of two access keys (active or inactive) at a time."
                )
                # handle IAM users with 2 keys ( which are returned as a list )
                access_keys = response.get("AccessKeyMetadata", {})
                for keys in access_keys:
                    access_key_id = keys.get("AccessKeyId", {})
                    last_access_date_dict = iam.get_access_key_last_used(AccessKeyId=access_key_id)
                    last_access_date = last_access_date_dict.get('AccessKeyLastUsed', {}).get('LastUsedDate', None)
                    user.keys.append((access_key_id, last_access_date))
                users_and_results.append(user)

        table = Texttable(max_width=200)
        table.set_cols_width([20, 10, 20])
        table.header(['IAM User', 'Keys', 'Status'])
        table.set_deco(table.BORDER | Texttable.HEADER | Texttable.VLINES | Texttable.HLINES)
        for iam_user in users_and_results:
            table.add_row([iam_user.username, iam_user.key_count(), iam_user._get_dormant_status()])

        print("\n" + table.draw() + "\n")

    except ClientError as e:
        logging.error(e)
        exit()


if __name__ == '__main__':
    logging.getLogger().setLevel(logging.INFO)
    rm_find_dormant_iam_keys()
