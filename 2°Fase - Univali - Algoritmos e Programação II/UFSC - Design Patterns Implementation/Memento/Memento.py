"""
Created on Wed Jun 20 12:16:34 2018

@author: Matheus Schaly
"""


# Originator
class Originator:
    
    _state = ''
    
    @property
    def state(self):
        return self._state
    
    @state.setter
    def state(self, state):
        self._state = state
        
    def save_memento_state(self):
        return Memento(self._state)
    
    def get_memento_state(self, memento):
        self._state = memento.state
    
    
# Memento
class Memento:
    
    _state = ''
    
    def __init__(self, state):
        self._state = state
        
    @property
    def state(self):
        return self._state


# Caretaker
class Care_Taker:
    
    _memento_list = []
    
    def append_state(self, state):
        self._memento_list.append(state)
        
    def get_state(self, index):
        return self._memento_list[index]


originator = Originator()
care_taker = Care_Taker()

originator.state = "State 1"
originator.state = "State 2"
care_taker.append_state(originator.save_memento_state())

originator.state = "State 3"
care_taker.append_state(originator.save_memento_state())

originator.state = "State 4"
print("Current State:", originator.state)

originator.get_memento_state(care_taker.get_state(0))
print("First saved State:", originator.state)
originator.get_memento_state(care_taker.get_state(1))
print("Second saved State:", originator.state)

