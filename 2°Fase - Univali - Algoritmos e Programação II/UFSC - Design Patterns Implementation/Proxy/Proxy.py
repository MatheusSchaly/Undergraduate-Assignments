"""
Created on Tue Jun 19 14:54:10 2018

@author: Matheus Schaly
"""


from abc import ABC, abstractmethod


# Subject
class Car_Interface(ABC):

    @abstractmethod
    def drive(self):
        pass

        
# Proxy
class Car_Proxy(Car_Interface):
    
    def __init__(self, driver_age):
        self.car = Car()
        self.driver_age = driver_age
    
    def drive(self):
        if self.driver_age <= 17:
            print("Too young to drive")
        else:
            self.car.drive()
    

# Real Subject
class Car(Car_Interface):    
    
    def drive(self):
        print("Car has been driven")
    

drive_attempt = Car_Proxy(17)
drive_attempt.drive()

drive_attempt = Car_Proxy(18)
drive_attempt.drive()