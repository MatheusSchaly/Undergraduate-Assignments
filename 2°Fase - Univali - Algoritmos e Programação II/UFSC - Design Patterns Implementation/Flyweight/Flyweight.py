"""
Created on Tue Jun 19 10:09:05 2018

@author: Matheus Schaly
"""


from abc import ABC, abstractmethod


# Flyweight Factory
class Shape_Factory:
    
    color_map = {}
    
    @staticmethod
    def get_color(color):
        
        try:
            _color_obj = Shape_Factory.color_map[color]
        except KeyError:
            _color_obj = Color(color)
            Shape_Factory.color_map[color] = _color_obj
            print("Creating color: " + color)
        
        return _color_obj

    
# Flyweight
class Shape(ABC):
    
    def __init__(self, color):
        self._color_obj = Shape_Factory.get_color(color)

    @property
    def color_obj(self):
        return self._color_obj

    @abstractmethod
    def draw(self):
        pass


# Shared Flyweight
class Color:
    
    _color = ''
    
    def __init__(self, color):
        self._color = color
        
    @property
    def color(self):
        return self._color
    
    def __str__(self):
        return self._color

    
# Unshared Concrete Flyweight
class Circle(Shape):
    
    def __init__(self, color, x, y, radius):
        super().__init__(color)
        self._x = x
        self._y = y
        self._radius = radius
    
    @property
    def x(self):
        return self._x

    @property
    def y(self):
        return self._y
        
    @property
    def radius(self):
        return self._radius
        
    def draw(self):
        print("Circle: \ncolor:", self._color_obj, "\nx:", self.x, "\ny:", self.y, "\nradius:", self.radius)
        

my_circles = []

circle = Circle("black", x=10, y=20, radius=30)
circle.draw()
my_circles.append(circle)
print()

circle = Circle("black", x=40, y=50, radius=60)
circle.draw()
my_circles.append(circle)
print()

circle = Circle("red", x=70, y=80, radius=90)
circle.draw()
my_circles.append(circle)

print("\n\nMy circles:\n")
for circle in my_circles:
    circle.draw()
    print()
