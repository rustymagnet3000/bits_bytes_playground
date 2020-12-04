#!/usr/bin/env python3
from queue import Queue
import threading
import socket
import time

start_port = 2000
end_port = 7000
target = "127.0.0.1"
queue = Queue() # FIFO Queue
open_ports = []
num_threads = 30


def worker():
    while not queue.empty():
        port = queue.get()
        if portscan(port):
            open_ports.append(port)


def portscan(port):
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.connect((target, port))

        return True
    except:
        return False


def run_scanner():

    for port in range(start_port, end_port):
        queue.put(port)

    thread_list = []

    for t in range(num_threads):
        thread = threading.Thread(target=worker)
        thread_list.append(thread)

    for thread in thread_list:
        thread.start()

    for thread in thread_list:
        thread.join()


start_time = time.time()
run_scanner()
end_time = time.time()
print('[*] Time elapsed for {0} ports: \t{1:.3f}'.format(end_port - start_port, end_time - start_time))
print('[*] Ports open: {0}'.format(open_ports))


[*] Time elapsed for 5000 ports: 	38.515
[*] Ports open: [2015, 2222, 3374, 6666, 6942]

Process finished with exit code 0

