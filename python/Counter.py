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
print(type(summary))
print(summary.keys())
print(summary.elements())

enum_list = list(map(str, summary))
print(enum_list)

# A Counter is a dict subclass for counting hashable objects
for key, value in summary.items():
    print(key.value, value)

"""
OUTPUT:
Counter({<DormantState.ACTIVE: 'active'>: 3, <DormantState.DORMANT: 'dormant'>: 2, <DormantState.INACTIVE: 'inactive'>: 1})
<class 'collections.Counter'>
dict_keys([<DormantState.ACTIVE: 'active'>, <DormantState.DORMANT: 'dormant'>, <DormantState.INACTIVE: 'inactive'>])
<itertools.chain object at 0x105b76a00>
['DormantState.ACTIVE', 'DormantState.DORMANT', 'DormantState.INACTIVE']
active 3
dormant 2
inactive 1
"""