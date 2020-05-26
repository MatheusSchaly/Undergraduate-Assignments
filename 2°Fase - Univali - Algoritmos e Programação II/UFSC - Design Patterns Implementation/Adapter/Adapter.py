"""
Created on Thu Jun 14 10:47:34 2018

@author: Matheus Schaly
"""


from abc import ABC, abstractmethod


# Target
class Shape(ABC):
    
    @abstractmethod
    def display(self, x1, y1, x2, y2):
        pass
    

# Adapter
class Rectangle(Shape):
    
    def display(self, x1, y1, x2, y2):
        width = abs(x1 - x2)
        height = abs(y1 - y2)
        Legacy_Rectangle.display(Legacy_Rectangle, x1, y1, width, height)
    
    
# Adaptee
class Legacy_Rectangle:
    
    def display(self, x1, y1, width, height):
        print(x1)
        print(y1)
        print(width)
        print(height)
        
        
user_rectangle = Rectangle()
user_rectangle.display(1, 2, 3, 1)
