import time
from enum import IntEnum


class TimelineSearch(IntEnum):
    YESTERDAY = 86400
    LAST_30_DAYS = YESTERDAY * 30

    @staticmethod
    def largest_timeline():
        return TimelineSearch.LAST_30_DAYS


def yesterday_in_epoch_format():
    """
    Asks for the largest timeline to send into DynamoDB.
    Time in Epoch time.
    Includes milliseconds, otherwise Between search in DynamoDB does not work as expected.
    :return:   A Tuple of the largest timeline to the start of the present day.
    """
    now = time.time()
    yday = time.localtime(now - TimelineSearch.largest_timeline())
    start = time.struct_time((yday.tm_year, yday.tm_mon, yday.tm_mday, 0, 0, 0, 0, 0, yday.tm_isdst))
    today = time.localtime(now)
    end = time.struct_time((today.tm_year, today.tm_mon, today.tm_mday, 0, 0, 0, 0, 0, today.tm_isdst))
    return round(time.mktime(start) * 1000), round(time.mktime(end) * 1000)


if __name__ == '__main__':
    start_yest, end_yest = yesterday_in_epoch_format()
    print(f"Start of yesterday:{start_yest}\nEnd of yesterday:{end_yest}")
