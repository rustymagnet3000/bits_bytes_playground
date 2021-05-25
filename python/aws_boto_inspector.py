import logging
import boto3
from botocore.exceptions import ClientError
from datetime import datetime

# Set environment variables:
#   AWS_PROFILE=default
#   AWS_DEFAULT_REGION=......

# https://docs.aws.amazon.com/code-samples/latest/catalog/python-inspector-list_findings.py.html
# More filters required to limit results

max_results = 100
start_date = datetime(2021, 5, 1)
end_date = datetime(2021, 5, 31)
finding_filter = {
    'severities': [
        'High',
        'Medium'
    ],
    'creationTimeRange': {
        'beginDate': start_date,
        'endDate': end_date,
    }
}


def rm_list_inspector_events():
    logging.info(f'[*]Starting to list inspector events')
    try:
        insp = boto3.client('inspector')

        ars = insp.list_assessment_runs()
        paginator = insp.get_paginator('list_findings')
        for findings in paginator.paginate(
                maxResults=max_results,
                assessmentRunArns=ars.get("assessmentRunArns", []),
                filter=finding_filter
        ):
            for finding_arn in findings['findingArns']:
                print(finding_arn)

    except ClientError as e:
        logging.error(e)
        exit()


if __name__ == '__main__':
    logging.getLogger().setLevel(logging.INFO)
    rm_list_inspector_events()
