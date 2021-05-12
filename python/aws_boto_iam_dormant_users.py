import logging
import boto3
from botocore.exceptions import ClientError
from dateutil.parser import parse

# Finding unused credentials
# aws iam list-access-keys          / ListAccessKeys
# aws iam get-access-key-last-used  / GetAccessKeyLastUsed

# Check if two access keys
# Check both last_used_dates

# Set environment variables:
#   AWS_PROFILE=default
#   AWS_DEFAULT_REGION=......


def rm_pretty_date(date_text):
    cleaned_date = parse(date_text)
    return f'{cleaned_date:%d-%m-%Y\t%H:%M%p}'


def rm_list_iam_users():
    logging.info(f'[*]Starting to list IAM users')
    try:
        iam = boto3.client('iam')
        resp = iam.list_users()

        # get list of users from resp dict
        for user in resp['Users']:
            username = user.get('UserName', None)
            if username:
                response = iam.list_access_keys(
                    UserName=username,
                    MaxItems=10
                )
                print(response)

    except ClientError as e:
        logging.error(e)
        exit()


if __name__ == '__main__':
    logging.getLogger().setLevel(logging.INFO)
    rm_list_iam_users()
