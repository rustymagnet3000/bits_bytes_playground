#!/usr/bin/env python3
import dns.resolver
from dns.exception import DNSException
from dns.resolver import NoAnswer

domain_name = 'microsoft.co.uk'

results = []

try:
    result = dns.resolver.resolve(domain_name, 'A')
    for ip_addr in result:
        results.append(f'IP {ip_addr.to_text()}')

    result = dns.resolver.resolve(domain_name, 'MX', raise_on_no_answer=False)
    for email_data in result:
        results.append(f' MX:{email_data.exchange.to_text()}')

    result = dns.resolver.resolve(domain_name, 'CNAME', raise_on_no_answer=True)
    for cname_val in result:
        results.append(f'cname target address:{cname_val.target}')

except NoAnswer as e:
    print(f'[!]{e}')
    pass
finally:
    print(results)
