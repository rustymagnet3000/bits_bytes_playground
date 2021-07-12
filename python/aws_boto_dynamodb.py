import boto3
from boto3.dynamodb.conditions import Key
from botocore.exceptions import ClientError
import logging
import json
from decimal import Decimal


def rm_fill_seed_data(table_name: str):
    """
    Fill table with seed data
    :type table_name: object
    :return: None
    """
    with open("seed_data.json") as json_file:
        device_list = json.load(json_file, parse_float=Decimal)

    dynamodb = boto3.resource('dynamodb', endpoint_url="http://localhost:8000")
    devices_table = dynamodb.Table(table_name)
    for device in device_list:
        print(f"Loading:{device['device_id']}\t{device['info']['info_timestamp']}")
        devices_table.put_item(Item=device)


def rm_create_devices_table(table_name: str):
    """
    Calls out and queries a dynamodb table name for Items that match the Partition Key
    :type table_name: object
    :return: None
    """
    dynamodb = boto3.resource('dynamodb', endpoint_url="http://localhost:8000")

    table = dynamodb.create_table(
        TableName=table_name,
        KeySchema=[
            {
                'AttributeName': 'device_id',
                'KeyType': 'HASH'  # Partition key
            },
            {
                'AttributeName': 'datacount',
                'KeyType': 'RANGE'  # Sort key
            }
        ],
        AttributeDefinitions=[
            {
                'AttributeName': 'device_id',
                'AttributeType': 'S'
            },
            {
                'AttributeName': 'datacount',
                'AttributeType': 'N'
            },
        ],
        ProvisionedThroughput={
            'ReadCapacityUnits': 10,
            'WriteCapacityUnits': 10
        }
    )
    print("Status:", table.table_status)


def rm_list_items_in_dynamodb_table(table_name: str, param: str):
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
            KeyConditionExpression=Key('device_id').eq(param)
        )
        items = response['Items']
        for item in items:
            print(item)

    except ClientError as e:
        logging.error(e)
        exit()


if __name__ == '__main__':
    table_name = 'DELETEme'
    logging.getLogger().setLevel(logging.INFO)
    # rm_create_devices_table(table_name)
    # rm_fill_seed_data(table_name)
    rm_list_items_in_dynamodb_table(table_name, '10001')
