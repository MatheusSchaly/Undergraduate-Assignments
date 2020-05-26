"""
Created on Thu Jun 21 08:36:35 2018

@author: Matheus Schaly
"""


from abc import ABC, abstractmethod


# Element
class Car_Element(ABC):
    
    @abstractmethod
    def accept(self, visitor):
        pass
    

# Concrete Element 1
class Body(Car_Element):
    
    def accept(self, visitor):
        visitor.visit_body(self)
        

# Concrete Element 2
class Engine(Car_Element):
    
    def accept(self, visitor):
        visitor.visit_engine(self)
        

# Concrete Element 3
class Wheel(Car_Element):
    
    def __init__(self, name):
        self.name = name
        
    def accept(self, visitor):
        visitor.visit_wheel(self)


# Object Structure ?
class Car(Car_Element):
    
    def __init__(self):
        self.elements = [
            Wheel("front Left"), Wheel("front right"),
            Wheel("back left"), Wheel("back right"),
            Body(), Engine()
        ]
        
    def accept(self, visitor):
        for element in self.elements:
            element.accept(visitor)
        visitor.visit_car(self)
        

# Visitor  
class Car_Element_Visitor(ABC):
    
    @abstractmethod
    def visit_body(self, element):
        pass
    
    @abstractmethod
    def visit_engine(self, element):
        pass
    
    @abstractmethod
    def visit_wheel(self, element):
        pass
    
    @abstractmethod
    def visit_car(self, element):
        pass


# Concrete Visitor 1
class Car_Element_Do_Visitor(Car_Element_Visitor):
    
    def visit_body(self, body):
        print("Moving body")
        
    def visit_car(self, car):
        print("Starting car")
        
    def visit_wheel(self, wheel):
        print("Kicking {} wheel".format(wheel.name))
        
    def visit_engine(self, engine):
        print("Starting engine")
        

# Concrete Visitor 2        
class Car_Element_Print_Visitor(Car_Element_Visitor):
    
    def visit_body(self, body):
        print("Visiting body")
        
    def visit_car(self, car):
        print("Visiting car")
        
    def visit_wheel(self, wheel):
        print("Visiting {} wheel".format(wheel.name))
        
    def visit_engine(self, engine):
        print("Visiting engine")
        
    
car = Car()
car.accept(Car_Element_Print_Visitor())
car.accept(Car_Element_Do_Visitor())