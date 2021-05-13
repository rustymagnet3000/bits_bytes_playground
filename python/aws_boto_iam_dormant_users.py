import logging
from enum import Enum
from dateutil.parser import parse
import boto3
from botocore.exceptions import ClientError

# Set environment variables:
#   AWS_PROFILE=default
#   AWS_DEFAULT_REGION=......


class DormantRules(Enum):
    ACTIVE = 90
    INACTIVE = 180
    DORMANT = 365


class IAMUser:
    def __init__(self, name: str):
        self.username = name
        self.keys = []

    def _key_count(self):
        return len(self.keys)

    def _pretty_keys(self):
        return 'pretty keys'

    def __repr__(self):
        return f'IAM user: {self.username!r}\t' \
               f'Key count:{self._key_count()!r}' \
               f'Key keys:{self.keys!r}'

    def _pretty_date(self):
        cleaned_date = parse(date_text)
        return f'{cleaned_date:%d-%m-%Y\t%H:%M%p}'


def rm_find_dormant_iam_keys():
    """
        Finds unused credentials similar to CLI commands:
            aws iam list-access-keys          / ListAccessKeys
            aws iam get-access-key-last-used  / GetAccessKeyLastUsed
        Has to check if a user has 1 or 2 access keys
        Check each key is "active"
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
                print(user)

    except ClientError as e:
        logging.error(e)
        exit()


if __name__ == '__main__':
    logging.getLogger().setLevel(logging.INFO)
    rm_find_dormant_iam_keys()
