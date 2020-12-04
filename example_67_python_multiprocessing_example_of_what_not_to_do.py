#!/usr/bin/env python3
import multiprocessing
import socket
import time

start_port = 2000
end_port = 4000
target = "127.0.0.1"
open_ports = []

# scanner without multiprocessing is much quicker
# the entire memory is copied to each processor ( so open ports[] never holds what you expect )

def scan(port_to_scan):
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.connect((target, port_to_scan))
        open_ports.append(port_to_scan)
        print(len(open_ports))
    except:
        return None


if __name__ == '__main__':
    start_time = time.time()
    for port in range(start_port, end_port):
        scan(port)

    end_time = time.time()
    print('[*] Time elapsed for {0} ports: \t{1:.3f}'.format(end_port - start_port, end_time - start_time))
    print('[*] Ports open: {0}'.format(open_ports))

    start_time = time.time()
    for port in range(start_port, end_port):
        p = multiprocessing.Process(target=scan, args=(port,))
        p.start()

    end_time = time.time()
    print('[*] Time elapsed for {0} ports: \t{1:.3f}'.format(end_port - start_port, end_time - start_time))
    print('[*] Ports open: {0}'.format(open_ports))



# Debug output
1
2
3
[*] Time elapsed for 2000 ports: 	13.307
[*] Ports open: [2015, 2222, 3374]
1
1
1
[*] Time elapsed for 2000 ports: 	37.227
[*] Ports open: [2015, 2222, 3374]
