import logging
import boto3


def rm_list_bucket():
    logging.info("[*]Starting")
    s3 = boto3.client('s3')
    response = s3.list_buckets()
    if len(response) > 0:
        for bucket in response['Buckets']:
            logging.info(f'\t{bucket["Name"]}\tCreated: {bucket["CreationDate"]:%d-%m-%Y}')
    else:
        logging.debug("[!]no buckets found")


if __name__ == '__main__':
    logging.getLogger().setLevel(logging.INFO)
    rm_list_bucket()