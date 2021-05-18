import boto3
import os
import statsd


# Add your accounts here
AWS_ACCOUNTS = []

# Add programmatic users here
PROGRAMMATIC_ACCESS_ONLY = [
]


def get_client(name):
    access_key = os.environ.get("AWS_ACCESS_KEY_{}".format(name.upper()))
    secret_key = os.environ.get("AWS_SECRET_KEY_{}".format(name.upper()))
    session = boto3.session.Session(aws_access_key_id=access_key, aws_secret_access_key=secret_key)
    return session.client('iam')


def main():
    for account in AWS_ACCOUNTS:
        client = get_client(account)

        all_users = [user['UserName'] for user in client.list_users()['Users']
                     if user['UserName'] not in PROGRAMMATIC_ACCESS_ONLY]

        mfa_enabled_users = []
        for user in all_users:
            device = client.list_mfa_devices(UserName=user)
            if device['MFADevices']:
                mfa_enabled_users.append(user)
        mfa_disabled_users = list(set(all_users) - set(mfa_enabled_users))

        enabled_count = len(mfa_enabled_users)
        not_enabled_count = len(mfa_disabled_users)
        enabled_percentage = (float(enabled_count) / len(all_users) * 100)

        print("Enabled count for {}: {}".format(account, enabled_count))
        print("Enabled percentage for {}: {}".format(account, enabled_percentage))
        print("Disabled users for {}: {}".format(account, mfa_disabled_users))

if __name__ == '__main__':
    main()