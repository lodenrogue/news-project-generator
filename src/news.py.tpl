from extractor.news_extractor import NewsExtractor
from {LOWER_NAME}_link_collector import {CAP_NAME}LinkCollector
from {LOWER_NAME}_content_extractor import {CAP_NAME}ContentExtractor


class {CAP_NAME}News():

    def get_articles(self, count):
        return (NewsExtractor({CAP_NAME}LinkCollector(), {CAP_NAME}ContentExtractor())
                .extract(count))


if __name__ == "__main__":
    articles = {CAP_NAME}News().get_articles(5) 

    for article in articles:
        print("=====================================")
        print("Title:", article.title)
        print(article.snippet)
        print(article.url)
        print("=====================================")
        print()
