import logging
import boto3
from botocore.exceptions import ClientError

# AWS_PROFILE=default   environment variable set


def try_s3_function(s3_command):
    """
    :param s3_command: Accepts a s3 related command.
    A single function that carries out the Exception Handling to avoid code duplication.
    :return: Response from boto3.client request.
    """
    try:
        return s3_command()
    except ClientError as e:
        logging.error(e)
        exit()


def rm_list_bucket():
    s3 = boto3.client('s3')
    logging.info("[*]About to list buckets")
    response = try_s3_function(s3.list_buckets)
    bucket_no = len(response['Buckets'])
    logging.info(f'[*]Buckets:{bucket_no}')
    if bucket_no > 0:
        for bucket in response['Buckets']:
            logging.info(f'\t{bucket["Name"]}\tCreated: {bucket["CreationDate"]:%d-%m-%Y}')


def rm_create_bucket(bucket_name, region='eu-west-2'):
    s3 = boto3.client('s3', region_name=region)
    location = {'LocationConstraint': region}
    response = try_s3_function(lambda: s3.create_bucket(Bucket=bucket_name, CreateBucketConfiguration=location))
    logging.info(f'[*]{response["Location"]}')


def rm_delete_bucket(bucket_name):
    s3 = boto3.client('s3')
    response = try_s3_function(lambda: s3.delete_bucket(Bucket=bucket_name))
    logging.info(f'[*]{response}')


if __name__ == '__main__':
    logging.getLogger().setLevel(logging.INFO)
    name = "george-loves-buckets3"
    # rm_create_bucket(name)
    # rm_delete_bucket(name)
    rm_list_bucket()

