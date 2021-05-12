from dateutil.parser import parse

# AWS Response
# 1   Dict            ( a Dictionary that contains a Dict and List )
# 2        \--->Dict['ResponseMetadata']
# 3        \--->List['Findings']
# 4            \--->Dict

big_dict = {'ResponseMetadata': {'RequestId': 'xxxxxx-04e9-4594-98c9-xxxxxx',
                                 'HTTPStatusCode': 200,
                                 'HTTPHeaders': {'date': 'Mon, 10 May 2021 11:08:42 GMT',
                                                 'content-type': 'application/json',
                                                 'content-length': '7175',
                                                 'connection': 'keep-alive',
                                                 'x-amzn-requestid': 'xxxxxx-04e9-4594-98c9-xxxxxx',
                                                 'x-amz-apigw-id': 'fHAZLEG0joEFbOg=',
                                                 'x-amzn-trace-id': 'Root=1-xxxxxx;Sampled=0'
                                                 },
                                 'RetryAttempts': 0},

            'Findings': [{'AccountId': 'FFFFFFFFFFFF',
                          'Arn': 'arn:aws:guardduty:eu-west-1:FFFFFFFFFFFF:detector/xx/finding/yy',
                          'CreatedAt': '2021-05-06T13:15:21.786Z',
                          'Description': 'APIs commonly used in InitialAccess tactics were invoked by user AssumedRole : my-iam-role, under anomalous circumstances. Such activity is not typically seen from this user.',
                          'Id': 'xxxxxx', 'Partition': 'aws', 'Region': 'eu-west-1',
                          'Resource': {'AccessKeyDetails': {'AccessKeyId': 'ZZZZZZZZZZZZZZZZZ',
                                                            'PrincipalId': 'XXXXXXX:foobar@gmail.com',
                                                            'UserName': 'my-iam-role',
                                                            'UserType': 'AssumedRole'}, 'ResourceType': 'AccessKey'},
                          'SchemaVersion': '2.0', 'Service': {'Action': {'ActionType': 'AWS_API_CALL',
                                                                         'AwsApiCallAction': {'Api': 'StartSession',
                                                                                              'CallerType': 'Remote IP',
                                                                                              'RemoteIpDetails': {
                                                                                                  'City': {
                                                                                                      'CityName': ''},
                                                                                                  'Country': {
                                                                                                      'CountryName': 'England'},
                                                                                                  'GeoLocation': {
                                                                                                      'Lat': 21.0,
                                                                                                      'Lon': 20.0},
                                                                                                  'IpAddressV4': '8.8.8.8',
                                                                                                  'Organization': {
                                                                                                      'Asn': 'xxxxx',
                                                                                                      'AsnOrg': 'Foobar Ltd',
                                                                                                      'Isp': 'Foobar LTD',
                                                                                                      'Org': 'Foobar LTD'}},
                                                                                              'ServiceName': 'ssm.amazonaws.com'}},
                                                              'Archived': False, 'Count': 1,
                                                              'DetectorId': 'xx',
                                                              'EventFirstSeen': '2021-05-06T12:59:07Z',
                                                              'EventLastSeen': '2021-05-06T12:59:07Z',
                                                              'ResourceRole': 'TARGET', 'ServiceName': 'guardduty'},
                          'Severity': 5,
                          'Title': 'User AssumedRole : my-iam-role is anomalously invoking APIs commonly used in InitialAccess tactics.',
                          'Type': 'InitialAccess:IAMUser/AnomalousBehavior', 'UpdatedAt': '2021-05-06T13:15:21.786Z'}]}


def validate_date_return_pretty(date_text):
    cleaned_date = parse(date_text)
    return f'{cleaned_date:%d-%m-%Y\t%H:%M%p}'


print(f'[*]Top level:, {type(big_dict)}, \tlength: {len(big_dict)}')
print(big_dict.keys())
print(f'[*]Child 1:, {type(big_dict["Findings"])}, \tlength:{len(big_dict["Findings"])}')
print(f'[*]Child 2:, {type(big_dict["ResponseMetadata"])}, \tlength:{len(big_dict["ResponseMetadata"])}')

# Regular list print and list print with Sushi syntax
print(big_dict['Findings'][::1])

# 1 Get two child data structures from initial Dict
for key, value in big_dict.items():

    # 3 Only handle the list, as this has the useful info
    if isinstance(value, list):

        # 4 get the Findings Dict out of the List
        dict_of_findings = value[0]

        if dict_of_findings['CreatedAt']:
            print(f'[*]Date:           \t{validate_date_return_pretty(dict_of_findings["CreatedAt"])}')

        # 5 get Resource Dict out of the Findings Dict (4)
        # Don't do this! Use .get() to avoid KeyErrors!
        if dict_of_findings['Resource']:
            print(f'[*]Access Key:     \t{dict_of_findings["Resource"]["AccessKeyDetails"]["AccessKeyId"]}')
            print(f'[*]ID:             \t{dict_of_findings["Resource"]["AccessKeyDetails"]["PrincipalId"]}')
            print(f'[*]AWS username:   \t{dict_of_findings["Resource"]["AccessKeyDetails"]["UserName"]}')

        if dict_of_findings['Description']:
            print(f'\tDescription:{dict_of_findings["Description"]}')
        if dict_of_findings['Region']:
            print(f'\tRegion:{dict_of_findings["Region"]}')
