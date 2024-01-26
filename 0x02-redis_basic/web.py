#!/usr/bin/env python3
"""
web.py - A module for fetching and caching HTML content from URLs
"""

import requests
import redis
from functools import wraps


def cache_results(func):
    """
    Decorator to cache function results with an expiration time and track
    access count.

    Args:
        func (Callable): The function to be decorated.

    Returns:
        Callable: The decorated function.
    """

    @wraps(func)
    def wrapper(url, *args, **kwargs):
        """
        Wrapper function for caching results and tracking access count.

        Args:
            url (str): The URL for which the HTML content is fetched.
            *args: Additional arguments passed to the decorated function.
            **kwargs: Additional keyword arguments passed to the decorated
            function.

        Returns:
            str: The HTML content of the URL.
        """
        # Create a Redis client
        redis_client = redis.StrictRedis(host='localhost', port=6379, db=0)

        # Generate a key for tracking the access count
        count_key = f"count:{url}"

        # Check if the URL is in cache
        cached_result = redis_client.get(url)
        if cached_result:
            # Increment the access count
            redis_client.incr(count_key)
            return cached_result.decode('utf-8')

        # If not in cache, fetch the data
        result = func(url, *args, **kwargs)

        # Cache the result with a 10-second expiration time
        redis_client.setex(url, 10, result)

        # Initialize the access count to 1
        redis_client.set(count_key, 1)

        return result

    return wrapper


@cache_results
def get_page(url: str) -> str:
    """
    Fetch the HTML content of a URL and cache the result.

    Args:
        url (str): The URL for which the HTML content is fetched.

    Returns:
        str: The HTML content of the URL.
    """
    response = requests.get(url)
    return response.text
