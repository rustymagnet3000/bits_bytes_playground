>>> import datetime
>>> from dateutil.tz import tzutc

>>> rmdate = datetime.datetime(2021, 3, 8, 12, 36, 11, tzinfo=tzutc())

>>> print(rmdate)
2021-03-08 12:36:11+00:00

>>> f"{rmdate:%Y-%m-%d}"
'2021-03-08'