import concurrent.futures
import logging
import queue
import random
import threading
import time

# top example from https://realpython.com/intro-to-python-threading/
# uses the Threading.is_set and ThreadPoolExecutor together to solve the burst of Producer Requests
# and the in-built Queue() Data Structure

def producerA(queue, event):
    """Pretend we're getting a number from the network."""
    while not event.is_set():
        message = random.randint(1, 20)
        logging.info("Producer A got message: %s", message)
        queue.put(message)

    logging.info("Producer A received event. Exiting")

def producerB(queue, event):
    """Pretend we're getting a number from the network."""
    while not event.is_set():
        message = random.randint(50, 71)
        logging.info("Producer B got message: %s", message)
        queue.put(message)

    logging.info("Producer B received event. Exiting")

def consumer(queue, event):
    """Pretend we're saving a number in the database."""
    while not event.is_set() or not queue.empty():
        message = queue.get()
        logging.info(
            "Consumer storing message: %s (size=%d)", message, queue.qsize()
        )

    logging.info("Consumer received event. Exiting")

if __name__ == "__main__":
    format = "%(asctime)s: %(message)s"
    logging.basicConfig(format=format, level=logging.INFO,
                        datefmt="%H:%M:%S")

    pipeline = queue.Queue(maxsize=10)
    event = threading.Event()
    with concurrent.futures.ThreadPoolExecutor(max_workers=3) as executor:
        executor.submit(producerA, pipeline, event)      # producer A
        executor.submit(producerB, pipeline, event)      # producer B
        executor.submit(consumer, pipeline, event)      # consumer

        time.sleep(0.1)
        logging.info("Main: about to set event")
        event.set()
        event.is_set()
