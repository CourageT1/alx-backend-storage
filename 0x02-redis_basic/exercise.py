#!/usr/bin/env python3
"""
Cache Class with Count Calls, Call History, and Replay Decorators
"""


import redis
import uuid
from typing import Union, Callable
from functools import wraps


class Cache:
    """
    Cache class for storing and retrieving data with decorators for counting
    calls, tracking call history, and replaying history.
    """

    def __init__(self):
        """
        Initialize the Cache instance with a Redis client and flush the
        database.
        """
        self._redis = redis.Redis()
        self._redis.flushdb()

    @staticmethod
    def count_calls(method: Callable) -> Callable:
        """
        Decorator to count the number of calls to a method and store the count
        in Redis.

        Args:
            method (Callable): The method to be decorated.

        Returns:
            Callable: The decorated method.
        """
        counts = {}

        @wraps(method)
        def wrapper(self, *args, **kwargs):
            """
            Wrapper function for counting calls and updating Redis.

            Args:
                self: The instance of the Cache class.
                *args: Arguments passed to the decorated method.
                **kwargs: Keyword arguments passed to the decorated method.

            Returns:
                Any: The result of the decorated method.
            """
            key = method.__qualname__
            counts[key] = counts.get(key, 0) + 1
            self._redis.set(key, counts[key])
            return method(self, *args, **kwargs)

        return wrapper

    @staticmethod
    def call_history(method: Callable) -> Callable:
        """
        Decorator to store the history of inputs and outputs for a method in
        Redis.

        Args:
            method (Callable): The method to be decorated.

        Returns:
            Callable: The decorated method.
        """

        @wraps(method)
        def wrapper(self, *args, **kwargs):
            """
            Wrapper function for storing call history in Redis.

            Args:
                self: The instance of the Cache class.
                *args: Arguments passed to the decorated method.
                **kwargs: Keyword arguments passed to the decorated method.

            Returns:
                Any: The result of the decorated method.
            """
            input_key = "{}:inputs".format(method.__qualname__)
            output_key = "{}:outputs".format(method.__qualname__)

            # Append input parameters to Redis list
            self._redis.rpush(input_key, str(args))

            # Execute the wrapped function to retrieve the output
            output = method(self, *args, **kwargs)

            # Store the output in the Redis list
            self._redis.rpush(output_key, str(output))

            return output

        return wrapper

    def replay(self, method: Callable) -> None:
        """
        Display the history of calls for a particular function.

        Args:
            method (Callable): The method for which the history should be
            displayed.

        Returns:
            None
        """
        input_key = "{}:inputs".format(method.__qualname__)
        output_key = "{}:outputs".format(method.__qualname__)

        inputs = self._redis.lrange(input_key, 0, -1)
        outputs = self._redis.lrange(output_key, 0, -1)

        print(f"{method.__qualname__} was called {len(inputs)} times:")

        for args, output in zip(inputs, outputs):
            args_str = args.decode("utf-8")
            output_str = output.decode("utf-8")
            print(f"{method.__qualname__}(*{args_str}) -> {output_str}")

    @count_calls
    @call_history
    def store(self, data: Union[str, bytes, int, float]) -> str:
        """
        Store data in Redis with a random key.

        Args:
            data (Union[str, bytes, int, float]): The data to be stored.

        Returns:
            str: The generated key for the stored data.
        """
        key = str(uuid.uuid4())
        self._redis.set(key, data)
        return key

    def get(self, key: str, fn: Callable = None) -> Union[
            str, bytes, int, float, None]:
        """
        Retrieve data from Redis using the given key.

        Args:
            key (str): The key to retrieve data.
            fn (Callable): A function to transform the retrieved data
            (optional).

        Returns:
            Union[str, bytes, int, float, None]: The retrieved data.
        """
        data = self._redis.get(key)
        if data is None:
            return None
        if fn is not None:
            return fn(data)
        return data

    def get_str(self, key: str) -> Union[str, None]:
        """
        Retrieve a string from Redis using the given key.

        Args:
            key (str): The key to retrieve data.

        Returns:
            Union[str, None]: The retrieved string.
        """
        return self.get(key, fn=lambda d: d.decode("utf-8"))

    def get_int(self, key: str) -> Union[int, None]:
        """
        Retrieve an integer from Redis using the given key.

        Args:
            key (str): The key to retrieve data.

        Returns:
            Union[int, None]: The retrieved integer.
        """
        return self.get(key, fn=int)
