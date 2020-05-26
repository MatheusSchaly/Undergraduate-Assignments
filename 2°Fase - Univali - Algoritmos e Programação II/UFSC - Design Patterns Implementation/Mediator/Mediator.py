"""
Created on Wed Jun 20 10:50:04 2018

@author: Matheus Schaly
"""


from abc import ABC, abstractmethod


# Mediator
class Mediator(ABC):
    
    @abstractmethod
    def register_runway(self, runway):
        pass
    
    @abstractmethod
    def register_flight(self, flight):
        pass
    
    @abstractmethod
    def can_land(self):
        pass
    
    @abstractmethod
    def set_landing_status(self, landing):
        pass


# Concrete Mediator
class Tower_Mediator(Mediator):
    
    flight = None
    runway = None
    land = None
    
    def register_runway(self, runway):
        self.runway = runway

    def register_flight(self, flight):
        self.flight = flight
        
    def can_land(self):
        return self.land

    def set_landing_status(self, status):
        self.land = status


# Colleague
class Command(ABC):
    
    @abstractmethod
    def land(self):
        pass

# Concrete Colleague 1
class Flight(Command):
    
    tower_mediator = Tower_Mediator()
    
    def __init__(self, tower_mediator):
        self.tower_mediator = tower_mediator

    def land(self):
        if self.tower_mediator.can_land():
            print("Landed")
            self.tower_mediator.set_landing_status(True)
        else:
            print("Waiting for landing")

    def get_ready(self):
        print("Ready for landing")
        

# Concrete Colleague 2
class Runway(Command):
    
    tower_mediator = Tower_Mediator()

    def __init__(self, tower_mediator):
        self.tower_mediator = tower_mediator
        self.tower_mediator.set_landing_status = True

    def land(self):
        print("Landing permission granted")
        self.tower_mediator.set_landing_Status = True
        

tower_mediator = Tower_Mediator()
sparrow = Flight(tower_mediator)
main_runway = Runway(tower_mediator)

tower_mediator.register_flight(sparrow)
tower_mediator.register_runway(main_runway)

sparrow.get_ready()
main_runway.land()
sparrow.land()

