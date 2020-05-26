"""
Created on Wed Jun 20 07:43:03 2018

@author: Matheus Schaly
"""


from abc import ABC, abstractmethod
 

# Expression
class Expression(ABC):
    
    @abstractmethod
    def interpreter(self, context):
        pass


# Terminal Expression
class Terminal_Expression(Expression):
    
    data = ''
    
    def __init__(self, data):
        self.data = data
    
    def interpreter(self, context):
        if self.data in context:
            return True
        return False


# Non-Terminal Expression 1
class Or_Expression(Expression):
    
    _expr1 = None
    _expr2 = None
    
    def __init__(self, expr1, expr2):
        self._expr1 = expr1
        self._expr2 = expr2
        
    def interpreter(self, context):
        return self._expr1.interpreter(context) or self._expr2.interpreter(context)
    

# Non-Terminal Expression 2
class And_Expression(Expression):
    
    _expr1 = None
    _expr2 = None
    
    def __init__(self, expr1, expr2):
        self._expr1 = expr1
        self._expr2 = expr2
        
    def interpreter(self, context):
        return self._expr1.interpreter(context) and self._expr2.interpreter(context)
    

# Context: is the strings passed
p1 = Terminal_Expression("Kushagra")
p2 = Terminal_Expression("Lokesh")
is_single = Or_Expression(p1, p2)

vikram = Terminal_Expression("Vikram")
commited = Terminal_Expression("Committed")
is_commited = And_Expression(vikram, commited)

print(is_single.interpreter("Kushagra"))
print(is_single.interpreter("Lokesh"))
print(is_single.interpreter("Achint"))

print(is_commited.interpreter("Committed, Vikram"))
print(is_commited.interpreter("Single, Vikram"))
