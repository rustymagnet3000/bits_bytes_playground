import datetime
from dateutil.parser import parse
from dateutil.tz import tzutc

# Handling AWS Boto responses which have Dict + List + Dict to unwrap a value
# You have to hand the KeyError risk

# Dict                  - aws_iam_response
# List[0]               - aws_iam_response['AccessKeyMetadata']
# List[0]               - Dict of data

aws_iam_response = {'AccessKeyMetadata': [{
    'UserName': 'foobar',
    'AccessKeyId': 'AKIAV2V7NSN7XXXXXXX',
    'Status': 'Active',
    'CreateDate': datetime.datetime(2021, 2, 13, 7, 2, 8, tzinfo=tzutc())}],
    'IsTruncated': False,
    'ResponseMetadata':
        {'RequestId': '89746588-8eaa-468c-bd6c-ffffffffffff',
         'HTTPStatusCode': 200,
         'HTTPHeaders':
             {'x-amzn-requestid': '89746588-8eaa-468c-bd6c-ffffffffffff',
              'content-type': 'text/xml',
              'content-length': '554',
              'date': 'Wed, 12 May 2021 15:23:30 GMT'},
         'RetryAttempts': 0}}


def validate_date_return_pretty(date_text):
    cleaned_date = parse(date_text)
    return f'{cleaned_date:%d-%m-%Y\t%H:%M%p}'


# Parse response
for key, value in aws_iam_response.items():
    if isinstance(value, list):
        dict_of_active_keyid = value[0]
        access_key_id = dict_of_active_keyid.get('AccessKeyId', None)
        print(access_key_id)

# Direct, without parsing response. High risk of KeyError
print(f'[*]AccessKeyId:     \t{aws_iam_response["AccessKeyMetadata"][0]["AccessKeyId"]}')

# Focused on removing KeyError risk
access_key_id = aws_iam_response.get("AccessKeyMetadata", {})[0].get("AccessKeyId", {})
if access_key_id:
    print(f'[*]AccessKeyId:     \t{access_key_id}')
