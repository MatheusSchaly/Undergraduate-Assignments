"""
Created on Thu Jun 14 09:49:23 2018

@author: Matheus Schaly
"""


from abc import ABC


# Prototype
class Animal(ABC):
    
    def clone(self):
        return self.copy.deepcopy(self)
    

# Concrete Prototype 1
class Sheep(Animal):
    
    def __str__(self):
        return "Hello, I'm Dolly!"
    
    
# Concrete Prototype 2
class Dog(Animal):
    
    def __str__(self):
        return "Aauuuu!"


sheep = Sheep()
print(sheep)

dog = Dog()
print(dog)