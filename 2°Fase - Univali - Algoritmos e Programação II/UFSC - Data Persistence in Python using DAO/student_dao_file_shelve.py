# -*- coding: utf-8 -*-
"""
Created on Thu Jun 28 17:10:19 2018

@author: Matheus Schaly
"""


from student_dao import Student_DAO
from student import Student
import shelve, os


# Concrete DAO 2
class Student_DAO_File_Shelve(Student_DAO):
    
    def get_all_students(self):
        try:
            with shelve.open("students_shelve", "r") as file:
                students = []
                for key in file.keys():
                    students.append(file[key])
            return students
        except:
            print("File students_pickle.txt doesn't exist")
    
    def get_student_by_ID(self, ID):
        try:
            with shelve.open("students_shelve", "r") as file:
                for key in file.keys():
                    if file[key].ID == ID:
                        return file[key]
                print("Student not found")
        except:
            print("File students_pickle.txt doesn't exist")
            
                
    def create_student(self, student):
        if type(student) is not Student:
            print("You are trying to create", type(student), "which is not a student")
            return
        with shelve.open("students_shelve", "c") as file:
            file[str(student.ID)] = student
    
    def delete_student(self, student):
        if type(student) is not Student:
            print("You are trying to delete", type(student), "which is not a student")
            return
        with shelve.open("students_shelve", "w") as file:
            try:
                del file[str(student.ID)]
            except KeyError:
                print("The student that you want to delete doesn't exist")
                
    def delete_storage(self):
        os.remove("students_shelve.bak")
        os.remove("students_shelve.dat")
        os.remove("students_shelve.dir")