import logging
from typing import NamedTuple
from enum import IntEnum
import boto3
from botocore.exceptions import ClientError
from datetime import datetime
from progress.bar import Bar

# in a big AWS environment, this can take ~1 minute to run with 200-300 IAM users
# Added a progress bar to avoid extra logging + making to clear that script is still in process

# Set environment variables:
#   AWS_PROFILE=default
#   AWS_DEFAULT_REGION=......

# Run from cli:
#   time python3 aws_boto_iam_dormant_users.py


class DormantRules(IntEnum):
    ACTIVE = 60
    INACTIVE = 180


class DormantResults:

    def __init__(self, name: str):
        self.active_users = 0
        self.inactive_users = 0
        self.dormant_users = 0
        self.never_used_users = 0

    def __repr__(self):
        return f'active_users:        {self.active_users!r}\t' \
               f'inactive_users:      {self.inactive_users!r}\t' \
               f'dormant_users:       {self.dormant_users!r}\t' \
               f'never_used_users:    {self.never_used_users!r}'


class AWSKey(NamedTuple):
    """A named tuple to make checking for the date of an AWS Access Key clear vs key[0]"""
    key_id: str
    last_used_date: datetime


class IAMUser:

    def __init__(self, name: str):
        self.username = name
        self.keys = []

    def key_count(self):
        return len(self.keys)

    def get_dormant_status(self):
        """
        Only dormant if both AWS IAM User key IDs have not been used
        Has to check if a user has 1 or 2 access keys
        The "active" status of a Key is not considered
        """
        for key in self.keys:
            # handle case where AWS IAM account has a single key with no Used Date
            if key.last_used_date is None and len(self.keys) == 1:
                return "Never used"
            # handle case where a Key has no Used Date but has multiple keys ( a common case, when 1 key is back-up )
            if key.last_used_date is None and len(self.keys) == 2:
                continue
            days_since_today = datetime.today() - key.last_used_date.replace(tzinfo=None)
            if days_since_today.days < DormantRules.ACTIVE:
                return "Active"
            elif days_since_today.days < DormantRules.INACTIVE:
                return "Inactive"
        return "Dormant"

    def __repr__(self):
        return f'IAM user:       {self.username!r}\t' \
               f'Key count:      {self.key_count()!r}\t' \
               f'Dormant status: {self.get_dormant_status()!r}'


class AccessKey:
    pass


def rm_find_dormant_iam_keys():
    """
        Finds unused credentials similar to CLI commands:
            aws iam list-access-keys
            aws iam get-access-key-last-used
    """
    iam_users = []
    try:
        iam = boto3.client('iam')
        # get list of users from resp dict. Default maxItems is 100.
        resp = iam.list_users(MaxItems=300)
        # get each UserName
        for user_dict in resp['Users']:
            username = user_dict.get('UserName', None)
            # get list of users from resp dict. Default maxItems is 100.
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
                    key_to_add = key_tuple(key_id=access_key_id, last_used_date=last_access_date)
                    user.keys.append(key_to_add)

                iam_users.append(user)
                bar.next()
        bar.finish()
        rm_print_iam_users(iam_users)
        logging.info(f'dormant_users:   ')
        logging.info(f'never used:      ')

    except ClientError as e:
        logging.error(e)
        exit()


def rm_print_iam_users(users: list):
    from texttable import Texttable
    table = Texttable(max_width=200)
    table.set_cols_width([50, 10, 20])
    table.header(['IAM User', 'Keys', 'Status'])
    table.set_deco(table.BORDER | Texttable.HEADER | Texttable.VLINES | Texttable.HLINES)
    for iam_user in users:
        table.add_row([iam_user.username, iam_user.key_count(), iam_user.get_dormant_status()])
    print("\n" + table.draw() + "\n")


if __name__ == '__main__':
    bar = Bar('Processing', max=300)
    logging.getLogger().setLevel(logging.INFO)
    rm_find_dormant_iam_keys()
