from datetime import datetime, timedelta
from time import strptime, mktime


def parse_datetime_str_check_against_time_delta(date_str):
    parsed_dt = strptime(date_str, '%Y-%m-%dT%H:%M:%S.%f')
    parsed_dt_epoch = datetime.fromtimestamp(mktime(parsed_dt)).timestamp()
    last_day_epoch = (datetime.now() - timedelta(hours=24)).timestamp()
    if parsed_dt_epoch > last_day_epoch:
        return True
    return False


if __name__ == '__main__':

    print(parse_datetime_str_check_against_time_delta('2021-02-22T02:00:00.017'))

