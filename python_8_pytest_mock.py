
# pip3 install pytest-mock
# pytest -xv
# won't wait 4 seconds



# main.py
from time import sleep


def is_animal():
    sleep(4)
    return True


def get_animal():
    return 'Fox' if is_animal() else 'Human'

if __name__ == '__main__':
    print("done")




# test_app.py
from main import get_operating_system


def test_get_operating_system(mocker):
    mocker.patch('main.is_animal', return_value=True)
    assert get_animal() == 'Fox'
