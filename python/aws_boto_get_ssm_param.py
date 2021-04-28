import boto3

boto3.setup_default_session(profile_name='rm_profile')
client = boto3.client('ssm')


def get_secret(key):
    resp = client.get_parameter(
        Name=key,
        WithDecryption=False
    )
    return resp['Parameter']['Value']


cmx_username = get_secret('client_id')