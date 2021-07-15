import time


def yesterday():
    now = time.time()
    yday = time.localtime(now - 86400)
    start = time.struct_time((yday.tm_year, yday.tm_mon, yday.tm_mday, 0, 0, 0, 0, 0, yday.tm_isdst))
    today = time.localtime(now)
    end = time.struct_time((today.tm_year, today.tm_mon, today.tm_mday, 0, 0, 0, 0, 0, today.tm_isdst))
    return int(time.mktime(start)), int(time.mktime(end))


if __name__ == '__main__':
    start_yest, end_yest = yesterday()
    print(f"Start of yesterday:{start_yest}\nEnd of yesterday:{end_yest}")
