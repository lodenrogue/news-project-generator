import unittest
from {LOWER_NAME}_news import {CAP_NAME}News

class {CAP_NAME}NewsTest(unittest.TestCase):

    def test_returns_correct_article_count(self):
        count = 3
        articles = {CAP_NAME}News().get_articles(count)
        self.assertTrue(len(articles) is count, "Articles has correct article count")


    def test_returns_values_for_articles(self):
        articles = {CAP_NAME}News().get_articles(3)
        self.assertTrue(len(articles) > 0, "Article list is not empty")

        for article in articles:
            self.assertIsNotNone(article.url, "Article url is not None")
            self.assertIsNotNone(article.title, "Article title is not None")
            self.assertIsNotNone(article.snippet, "Article snipper is not None")


if __name__ == '__main__':
    unittest.main()
