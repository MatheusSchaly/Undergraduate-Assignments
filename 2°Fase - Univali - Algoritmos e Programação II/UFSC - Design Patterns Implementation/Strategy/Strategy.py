"""
Created on Wed Jun 20 18:33:17 2018

@author: Matheus Schaly
"""


from abc import ABC, abstractmethod
    

# Strategy
class Operation(ABC):
    
    @abstractmethod
    def do_operation(self, num1, num2):
        pass
    
    
# Concrete Strategy 1
class Add_Operation(Operation):
    
    def do_operation(self, num1, num2):
        return num1 + num2


# Concrete Strategy 2
class Subtract_Operation(Operation):
    
    def do_operation(self, num1, num2):
        return num1 - num2


# Concrete Strategy 3
class Multiply_Operation(Operation):
    
    def do_operation(self, num1, num2):
        return num1 * num2
    
    
# Context
class Context:
    
    _strategy = None
    
    def __init__(self, strategy):
        self._strategy = strategy
    
    def execute_strategy(self, num1, num2):
        return self._strategy.do_operation(num1, num2)
    

context = Context(Add_Operation())
print(context.execute_strategy(10, 5))

context = Context(Subtract_Operation())
print(context.execute_strategy(10, 5))

context = Context(Multiply_Operation())
print(context.execute_strategy(10, 5))
