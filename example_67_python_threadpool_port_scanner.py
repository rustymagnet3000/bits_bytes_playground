#!/usr/bin/env python3
from queue import Queue
import socket
import time
import concurrent.futures
import logging


# No benefit from increasing the Threads
# This is due to the Global Interpreter Lock ( GIL )
# Excellent video: https://www.youtube.com/watch?v=Obt-vMVdM8s

start_port = 2000
end_port = 4000
target = "127.0.0.1"

queue = Queue()     # FIFO Queue
open_ports = list()
num_threads = 3


def worker(name):
    logging.info("Thread %s: starting", name)
    while not queue.empty():
        port = queue.get()
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        result = sock.connect_ex((target, port))
        if result == 0:
            logging.info("Thread %s: found open port: %d", name, port)
            open_ports.append(port)


if __name__ == "__main__":
    format_msg = "%(asctime)s: %(message)s"
    logging.basicConfig(format=format_msg, level=logging.INFO, datefmt="%H:%M:%S")
    for port in range(start_port, end_port):
        queue.put(port)
    logging.info('Queue filled with {} items'.format(end_port - start_port))
    start_time = time.time()
    with concurrent.futures.ThreadPoolExecutor(max_workers=num_threads) as executor:
        executor.map(worker, range(num_threads))
    end_time = time.time()
    logging.info('[*] {0} threads took: \t{1:.3f}'.format(num_threads, end_time - start_time))
    logging.info('[*] Ports open: {0}'.format(open_ports))




09:59:05: Queue filled with 2000 items
09:59:05: Thread 0: starting
09:59:05: Thread 1: starting
09:59:05: Thread 2: starting
09:59:05: Thread 0: found open port: 2015
09:59:05: Thread 0: found open port: 2222
09:59:15: Thread 0: found open port: 3374
09:59:19: [*] 3 threads took: 	13.647
09:59:19: [*] Ports open: [2015, 2222, 3374]
