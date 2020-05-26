"""
Created on Wed Jun 20 13:45:56 2018

@author: Matheus Schaly
"""


from abc import ABC, abstractmethod


# Concrete Subject
class News_Publisher:

    def __init__(self):
        self._subscribers = []
        self._recent_news = ''
        
    def append_subscriber(self, subscriber):
        self._subscribers.append(subscriber)
        
    def remove_subscriber(self, subscriber):
        self._subscribers.remove(subscriber)

    def update_news(self, recent_news):
        self._recent_news = recent_news
        self._notify_subscribers()
        
    def _notify_subscribers(self):
        for subscriber in self._subscribers:
            subscriber.update_news(self._recent_news)
            
    @property
    def subscribers(self):
        return self._subscribers


# Observer
class Subscriber(ABC):
    
    @abstractmethod
    def update_news(self, recent_news):
        pass


# Concrete Observer 1
class SMS_Subscriber(Subscriber):
    
    def __init__(self, publisher):
        self._recent_news = ''
        self._publisher = publisher
        self._publisher.append_subscriber(self)
    
    def update_news(self, recent_news):
        self._recent_news = recent_news
        print(self._recent_news)
        

# Concrete Observer 2
class Email_Subscriber(Subscriber):

    def __init__(self, publisher):
        self._recent_news = ''
        self._publisher = publisher
        self._publisher.append_subscriber(self)
    
    def update_news(self, recent_news):
        self._recent_news = recent_news
        print(self._recent_news)
        

news_publisher = News_Publisher()
SMS_Subscriber(news_publisher)
Email_Subscriber(news_publisher)

news_publisher.update_news("First News")
news_publisher.update_news("Second News")

subscribers = news_publisher.subscribers

for subscriber in subscribers:
    print(type(subscriber).__name__)
    
news_publisher.remove_subscriber(news_publisher.subscribers[0])

for subscriber in subscribers:
    print(type(subscriber).__name__)


