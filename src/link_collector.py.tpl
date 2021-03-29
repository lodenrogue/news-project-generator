import requests
from bs4 import BeautifulSoup

from model.link import Link

BASE_URL = "REPLACE URL"

class {CAP_NAME}LinkCollector:

    def collect(self, count):
        response = requests.get(BASE_URL)
        directory_soup = BeautifulSoup(response.content, "html.parser")
        
        urls = self._get_urls(directory_soup)
        titles = self._get_titles(directory_soup)
       
        num_to_collect = min(count, len(urls))
        return [Link(urls[i], titles[i]) for i in range(0, num_to_collect)]


    def _get_titles(self, soup):
        # TODO: Add code here
        return []


    def _get_urls(self, soup):
        # TODO: Add code here
        return []