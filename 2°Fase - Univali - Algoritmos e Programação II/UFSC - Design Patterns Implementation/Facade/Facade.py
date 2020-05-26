"""
Created on Tue Jun 19 08:43:41 2018

@author: Matheus Schaly
"""


# Facade
class Event_Manager:
    
    def marriage(self):
        florist = Florist()
        florist.arrange_flowers()
        
        musician = Musician()
        musician.arrange_songs()
        
        carrier = Carrier()
        carrier.arrange_transport()


# Class 1
class Florist:
    
    def arrange_flowers(self):
        print("Roses")
    
    
# Class 2
class Musician:
    
    def arrange_songs(self):
        print("Guns N' Roses")


# Class 3
class Carrier:
    
    def arrange_transport(self):
        print("Trucks")


event_manager = Event_Manager()
event_manager.marriage()