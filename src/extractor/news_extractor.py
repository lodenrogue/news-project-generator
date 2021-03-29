from model.article import Article

class NewsExtractor:
    
    def __init__(self, link_collector, content_extractor):
        self.link_collector = link_collector
        self.content_extractor = content_extractor


    def extract(self, count):
        links = self.link_collector.collect(count)
        
        articles = []
        for link in links:
            content = self.content_extractor.extract(link.url)
            articles.append(Article(link.title, link.url, content.snippet))

        return articles
