#!/usr/bin/env python3
import logging
import time
import concurrent.futures

# https://realpython.com/intro-to-python-threading/
# Better way to do multiple threads ( so you don't have to manage joins() and takes away O/S randomness )
# But this does NOT solve Race Conditions
# The end of the with block causes the ThreadPoolExecutor to do a .join() on each of the threads in the pool


def thread_function(name):
    logging.info("Thread %s: starting", name)
    time.sleep(2)
    logging.info("Thread %s: finishing", name)


if __name__ == "__main__":
    format_msg = "%(asctime)s: %(message)s"
    logging.basicConfig(format=format_msg, level=logging.INFO,
                        datefmt="%H:%M:%S")

    with concurrent.futures.ThreadPoolExecutor(max_workers=3) as executor:
        executor.map(thread_function, range(3))

# 09:23:25: Thread 0: starting
# 09:23:25: Thread 1: starting
# 09:23:25: Thread 2: starting
# 09:23:27: Thread 0: finishing
# 09:23:27: Thread 2: finishing
# 09:23:27: Thread 1: finishing

