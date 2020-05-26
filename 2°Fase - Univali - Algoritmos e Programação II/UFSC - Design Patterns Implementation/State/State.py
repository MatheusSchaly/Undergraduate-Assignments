"""
Created on Wed Jun 20 14:51:07 2018

@author: Matheus Schaly
"""


from abc import ABC, abstractmethod


# Context
class Computer:
    
    _state = None
    
    def __init__(self):
        self._state = Off()

    @property
    def state(self):
        return self._state
    
    @state.setter
    def state(self, state):
        self._state = state
        

# State
class Computer_State(ABC):
    
    @abstractmethod
    def handle(self, state):
        pass


# Concrete State 1
class On(Computer_State):
    
    def handle(self, computer):
        print("Computer is on")
        computer.state = self
        
    def __str__(self):
        return "On state"


# Concrete State 2
class Off(Computer_State):
    def handle(self, computer):
        print("Computer is off")
        computer.state = self
        
    def __str__(self):
        return "Off state"


computer = Computer()
on_state = On()
off_state = Off()

on_state.handle(computer)
print(computer.state)
off_state.handle(computer)
print(computer.state)