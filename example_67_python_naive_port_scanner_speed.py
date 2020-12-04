#!/usr/bin/env python3
import socket
import time

start_port = 2000
num_port_checks = 1000
target = "127.0.0.1"
open_ports = []


def portscan(port):
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.connect((target, port))
        return True
    except:
        return False


start_time = time.time()

for port in range(start_port, start_port + 1000):
    result = portscan(port)
    if result:
        open_ports.append(port)

end_time = time.time()

print('[*] Time elapsed for {0} ports: \t{1:.3f}'.format(num_port_checks, end_time - start_time))
print('[*] Ports open: {0}'.format(open_ports))


[*] Time elapsed for 1000 ports: 	5.857
[*] Ports open: [2015, 2222]
