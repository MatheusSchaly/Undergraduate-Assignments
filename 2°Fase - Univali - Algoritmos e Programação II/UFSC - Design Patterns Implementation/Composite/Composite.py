"""
Created on Thu Jun 14 16:57:02 2018

@author: Matheus Schaly
"""


from abc import ABC, abstractmethod


# Component
class Shape(ABC):
    
    @abstractmethod
    def draw(self, color):
        pass


# Leaf 1
class Triangle(Shape):
    
    def draw(self, color):
        print("Drawing Triangle with color " + color)


# Leaf 2
class Circle(Shape):
    
    def draw(self, color):
        print("Drawing Circle with color " + color)


# Composite
class Drawing(Shape):
    
    def __init__(self):
        self.shapes = []

    def draw(self, color):
        for sh in self.shapes:
            sh.draw(color)

    def add(self, sh):
        self.shapes.append(sh)

    def remove(self, sh):
        self.shapes.remove(sh)

    def clear(self):
        print("Clearing all the shapes from drawing")
        self.shapes = []


tri1 = Triangle()
tri2 = Triangle()
cir1 = Circle()
cir2 = Circle()
tri3 = Triangle()

drawing1 = Drawing()
drawing1.add(cir1)
drawing1.add(tri1)

drawing2 = Drawing()
drawing2.add(tri2)
drawing2.add(tri3)
drawing2.add(cir2)
drawing2.add(drawing1)

drawing2.draw("Green")

drawing2.clear()

drawing2.draw("Blue")