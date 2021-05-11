import logging
import boto3
from botocore.exceptions import ClientError
from dateutil.parser import parse

# Set environment variables:
#   AWS_PROFILE=default
#   AWS_DEFAULT_REGION=......

# AWS Response
# 1   Dict            ( a Dictionary that contains a Dict and List )
# 2        \--->Dict['ResponseMetadata']
# 3        \--->List['Findings']
# 4            \--->Dict


def rm_pretty_date(date_text):
    cleaned_date = parse(date_text)
    return f'{cleaned_date:%d-%m-%Y\t%H:%M%p}'


def rm_list_guardduty_events():
    logging.info(f'[*]Starting to list GuardDuty events')
    try:
        gd = boto3.client('guardduty')
        detectors = gd.list_detectors(MaxResults=10, NextToken='string')
        no_of_detectors = len(detectors['DetectorIds'])
        logging.info(f'[*]Detectors found:{no_of_detectors}')
        if no_of_detectors > 0:
            for d in detectors['DetectorIds']:
                logging.info(f'Detector ID:\t{d}')
                # Select Severity
                fc = {'Criterion': {'severity': {'Gte': 3}}}
                # get finding IDs, and limited severity to avoid too many IDs
                findings = gd.list_findings(DetectorId=d, FindingCriteria=fc)
                # loop through finding IDs to get details of each finding
                for finding in findings['FindingIds']:
                    find_detail = gd.get_findings(DetectorId=d, FindingIds=[finding])
                    for key, value in find_detail.items():
                        # Only use the list from the find_detail Dict
                        if isinstance(value, list):
                            # 4 get the Findings Dict out of the List
                            find_details = value[0]
                            # Handle potential Key Errors as some response parameters are not present
                            print(f'[*]Date:         {rm_pretty_date(find_details.get("CreatedAt", None))}')
                            print(f'[*]Description:  {find_details.get("Description", "No description given")}')
                            print(f'[*]Region:       {find_details.get("Region", "No region found")}')
                            access_keys = find_details.get('Resource', {}).get('AccessKeyDetails', {})
                            print(f'[*]Access Key:   {access_keys.get("AccessKeyId", "[!]No access key found")}')
                            print(f'[*]ID:           {access_keys.get("PrincipalId", "[!]No PrincipalId found")}')
                            print(f'[*]Username:     {access_keys.get("UserName", "[!]No Username found")}\n')

    except ClientError as e:
        logging.error(e)
        exit()


if __name__ == '__main__':
    logging.getLogger().setLevel(logging.INFO)
    rm_list_guardduty_events()
