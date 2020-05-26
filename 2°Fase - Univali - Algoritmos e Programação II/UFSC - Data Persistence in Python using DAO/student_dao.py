# -*- coding: utf-8 -*-
"""
Created on Thu Jun 28 17:07:09 2018

@author: Matheus Schaly
"""


from abc import ABC, abstractmethod


# Abstract DAO
class Student_DAO(ABC):
    
    @abstractmethod
    def get_all_students(self):
        pass
    
    @abstractmethod
    def get_student_by_ID(self, ID):
        pass
    
    @abstractmethod
    def create_student(self, student):
        pass
    
    @abstractmethod
    def delete_student(self, student):
        pass
    
    @abstractmethod
    def delete_storage(self):
        pass