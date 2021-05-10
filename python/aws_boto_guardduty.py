import logging
import boto3
from botocore.exceptions import ClientError

# Set environment variables:
#   AWS_PROFILE=default
#   AWS_DEFAULT_REGION=......


def rm_list_guardduty_events():
    logging.info(f'[*]Starting to list GuardDuty events')
    try:
        gd = boto3.client('guardduty')
        detectors = gd.list_detectors(
            MaxResults=10,
            NextToken='string'
        )
        no_of_detectors = len(detectors['DetectorIds'])
        logging.info(f'[*]Detectors:{no_of_detectors}')
        if no_of_detectors > 0:
            for d in detectors['DetectorIds']:
                logging.info(f'Detector ID:\t{d}')
                fc = {'Criterion': {'severity': {'Gte': 4}}}
                findings = gd.list_findings(DetectorId=d, FindingCriteria=fc)
                for finding in findings['FindingIds']:
                    find_detail = gd.get_findings(
                        DetectorId=d,
                        FindingIds=[finding],
                        SortCriteria={
                            'AttributeName': finding,
                            'OrderBy': 'DESC'
                        }
                    )
                    print(f'{find_detail}\n')

    except ClientError as e:
        logging.error(e)
        exit()


if __name__ == '__main__':
    logging.getLogger().setLevel(logging.INFO)
    rm_list_guardduty_events()
