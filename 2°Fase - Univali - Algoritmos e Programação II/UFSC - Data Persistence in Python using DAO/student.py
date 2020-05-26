# -*- coding: utf-8 -*-
"""
Created on Thu Jun 28 17:06:32 2018

@author: Matheus Schaly
"""

# Business Object
class Student:
    
    def __init__(self, ID, name):
        self._ID = ID
        self._name = name
        
    @property
    def ID(self):
        return self._ID
    
    @ID.setter
    def ID(self, ID):
        self._ID = ID

    @property
    def name(self):
        return self._name
    
    @name.setter
    def name(self, name):
        self._name = name
        
    def __str__(self):
        return "ID: {}  Name: {}".format(self.ID, self.name)