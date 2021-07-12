import boto3
from boto3.dynamodb.conditions import Key
from botocore.exceptions import ClientError
import logging

# Set environment variables:
#   AWS_PROFILE=default
#   AWS_DEFAULT_REGION=......


def rm_list_items_in_dynamodb_table(table_name: str):
    """
    Calls out and queries a dynamodb table name for Items that match the Partition Key
    :return: None
    """
    logging.info(f'[*]Starting local list of dynamodb tables')
    try:
        dynamodb = boto3.resource('dynamodb', endpoint_url='http://localhost:8000')
        table = dynamodb.Table(table_name)
        logging.info(f'[*]Found {table.item_count} items in table {table_name}')
        response = table.query(
            KeyConditionExpression=Key('Name').eq("Alice")
        )
        items = response['Items']
        for item in items:
            print(item)

    except ClientError as e:
        logging.error(e)
        exit()


if __name__ == '__main__':
    logging.getLogger().setLevel(logging.INFO)
    rm_list_items_in_dynamodb_table('DELETEme')

