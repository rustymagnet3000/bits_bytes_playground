#!/usr/bin/env python3

from enum import Enum


class RobotType(Enum):
    NORMAL = 0
    SUPER = 1


class Robot:
    def __init__(self, name):
        self.robot_type = RobotType(0)
        self.name = name

    def is_a_super_robot(self):
        if self.robot_type is RobotType.SUPER:
            return True
        else:
            return False


if __name__ == '__main__':
    a = Robot("Rusty")
    assert a.is_a_super_robot(), 'Must be a Super Robot'
    print(f'Hi {a.name}. You must be a Super Robot!')



#  python3 main.py
#  Hi Rusty. You must be a Super Robot!
#  Add environment variable:  PYTHONOPTIMIZE=TRUE
#  Disables the Assert code
#  Reference: "Python Tricks" from Dan Bader
