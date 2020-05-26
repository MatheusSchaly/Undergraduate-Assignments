"""
Created on Thu Jun 21 09:38:06 2018

@author: Matheus Schaly
"""


from abc import ABC, abstractmethod


# Abstract Product A
class Button(ABC):
    
    @abstractmethod
    def paint(self):
        pass


# Abstract Product A1
class Linux_Button(Button):
    
    def paint(self):
        return "Render a Linux style button"
    

# Abstract Product A2
class Windows_Button(Button):
    
    def paint(self):
        return "Render a Windows style button"
    

# Abstract Product B
class Window(ABC):
    
    @abstractmethod
    def paint(self):
        pass
    

# Abstract Product B1
class Windows_Window(Window):
    
    def paint(self):
        return "Render a Window style window"


# Abstract Product B2
class Linux_Window(Window):
    
    def paint(self):
        return "Render a Linux style window"


# Abstract Factory
class GUI_Factory(ABC):
    
    @abstractmethod 
    def create_button(self): # Factory Method
        pass
    
    @abstractmethod 
    def create_window(self): # Factory Method
        pass
    

# Concrete Factory 1
class Linux_Factory(GUI_Factory):
    
    def create_button(self):
        return Linux_Button()
    
    def create_window(self):
        return Linux_Window()


# Concrete Factory 2
class Windows_Factory(GUI_Factory):
    
    def create_button(self):
        return Windows_Button()

    def create_window(self):
        return Windows_Window()
    

factory = Linux_Factory()
button = factory.create_button()
window = factory.create_window()
print(button.paint())
print(window.paint())


factory = Windows_Factory()
button = factory.create_button()
window = factory.create_window()
print(button.paint())
print(window.paint())

