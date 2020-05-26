"""
Created on Thu Jun 21 07:15:57 2018

@author: Matheus Schaly
"""


from abc import ABC, abstractmethod


# Abstract Class
class Trip(ABC):
    
    @abstractmethod
    def arrival_transportation(self):
        pass
    
    @abstractmethod
    def day1(self):
        pass
    
    @abstractmethod
    def day2(self):
        pass
    
    @abstractmethod
    def departure_transportation(self):
        pass
    
    def itinerary(self): # Template Method
        self.arrival_transportation()
        self.day1()
        self.day2()
        self.departure_transportation()

        
# Concrete Class 1
class Canada(Trip):
    
    def arrival_transportation(self):
        print("Airplain")
        
    def day1(self):
        print("Aurora Borealis")
        
    def day2(self):
        print("Rocky Mountains")
        
    def departure_transportation(self):
        print("Car")
        

# Concrete Class 2
class Egypt(Trip):    
    
    def arrival_transportation(self):
        print("Camel")
        
    def day1(self):
        print("Giza")
        
    def day2(self):
        print("Alexandria")
        
    def departure_transportation(self):
        print("Ship")
        
        
canada = Canada()
canada.itinerary()

egypt = Egypt()
egypt.itinerary()
    
