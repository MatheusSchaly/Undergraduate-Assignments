"""
Created on Thu Jun 14 15:56:40 2018

@author: Matheus Schaly
"""


from abc import ABC, abstractmethod


# Abstraction
class Shape(ABC):
    
    def __init__(self, color):
        self.color = color

    @abstractmethod
    def color_it(self):
        pass


# Refined Abstraction 1
class Rectangle(Shape):

    def color_it(self):
        print("Rectangle filled with: ", end="")
        self.color.fill_color()


# Refined Abstraction 2
class Circle(Shape):

    def color_it(self):
        print("Circle filled with: ", end="")
        self.color.fill_color()
        
        
# Implementor
class Color(ABC):
    
    @abstractmethod
    def fill_color(self):
        pass


# Concrete Implementor 1
class RedColor(Color):
    
    def fill_color(self):
        print("red color")


# Concrete Implementor 2
class BlueColor(Color):
    
    def fill_color(self):
        print("blue color")
        

s1 = Rectangle(RedColor())
s1.color_it()

s2 = Circle(BlueColor())
s2.color_it()