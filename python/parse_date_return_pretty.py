from dateutil.parser import parse

def validate_date_return_pretty(date_text):
    cleaned_date = parse(date_text)
    return f'{cleaned_date:%d-%m-%Y\t%H:%M%p}'


date_string = '2021-05-06T13:15:21.786Z'

validate_date_return_pretty(date_string)
'06-05-2021 13:15PM'