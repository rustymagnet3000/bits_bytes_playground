import boto3
from boto3.dynamodb.conditions import Attr
from botocore.exceptions import ClientError
import logging
import time


def rm_list_items_in_dynamodb_table(table_name: str, email: str):
    """
    Calls out to AWS DynamoDB table name. Scans where column email equals passed in email
    Converts an Epoch time to a readable value
    :return: None
    """
    logging.info(f'[*]Starting local list of dynamodb tables')
    try:
        dynamodb = boto3.resource('dynamodb', region_name="eu-west-1")
        table = dynamodb.Table(table_name)
        logging.info(f'[*]Found {table.item_count} items in table {table_name}')

        response = table.scan(
            FilterExpression=Attr("email").eq(email)
        )

        items = response['Items']
        for item in items:
            creation_time_epoch_fmt = int(item.get('creationDate', 0) / 1000)
            readable_time = time.strftime("%d-%m-%Y, %H:%M", time.localtime(creation_time_epoch_fmt))
            print(f"accountName: {item.get('accountName', 'Not found').ljust(50, ' ')}"
                  f"\t\t{readable_time.ljust(25, ' ')}"

    except ClientError as e:
        logging.error(e)
        exit()


if __name__ == '__main__':
    logging.getLogger().setLevel(logging.INFO)
    rm_list_items_in_dynamodb_table('footable', 'foo@email.com')
