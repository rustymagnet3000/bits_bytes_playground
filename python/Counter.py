from collections import Counter
from enum import Enum


class DormantState(Enum):
    UNKNOWN = "unknown"
    ACTIVE = "active"
    INACTIVE = "inactive"
    DORMANT = "dormant"
    NEVER_USED = "never used"


a = DormantState.ACTIVE
b = DormantState.ACTIVE
c = DormantState.ACTIVE
d = DormantState.DORMANT
e = DormantState.DORMANT
f = DormantState.INACTIVE

states = [a, b, c, d, e, f]

summary = Counter(states)

print(summary)
print(summary.keys())
print(summary.elements())

enum_list = list(map(str, summary))
print(enum_list)
