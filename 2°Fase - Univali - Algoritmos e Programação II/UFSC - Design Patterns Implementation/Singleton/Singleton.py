"""
Created on Thu Jun 14 10:06:51 2018

@author: Matheus Schaly
"""


# Singleton
class President:
    
    def __new__(cls):
        if not hasattr(cls, '_instance'):
            cls._instance = super().__new__(cls)
        return cls._instance
        

s1 = President()
print(id(s1))
print(type(s1))

s2 = President()
print(id(s2))
print(type(s2))
