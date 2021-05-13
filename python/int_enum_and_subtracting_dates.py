from enum import IntEnum
from datetime import datetime
from dateutil.tz import tzutc


class DormantRules(IntEnum):
    ACTIVE = 90
    INACTIVE = 180
    DORMANT = 365


my_date_in_past = datetime(2021, 2, 12, 12, 36, 11, tzinfo=tzutc())

days_since_today = datetime.today() - my_date_in_past.replace(tzinfo=None)
if days_since_today.days < DormantRules.ACTIVE:
    print("Active")
elif days_since_today.days < DormantRules.INACTIVE:
    print("inactive")
else:
    print("Dormant or something else")
