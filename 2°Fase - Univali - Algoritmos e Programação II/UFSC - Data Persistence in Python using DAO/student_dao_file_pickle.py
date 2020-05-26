# -*- coding: utf-8 -*-
"""
Created on Thu Jun 28 17:08:36 2018

@author: Matheus Schaly
"""


from student_dao import Student_DAO
from student import Student
import pickle, os


# Concrete DAO 1
class Student_DAO_File_Pickle(Student_DAO):
    
    def get_all_students(self):
        try:
            with open("students_pickle.txt", "rb") as file:
                students = []
                while True:
                    try:
                        student = pickle.load(file)
                    except EOFError:
                        break
                    students.append(student)
        except FileNotFoundError:
            print("File students_pickle.txt doesn't exist")
            return
            
        return students
    
    def get_student_by_ID(self, ID):
        try:
            with open("students_pickle.txt", "rb") as file:
                while True:
                    try:
                        student = pickle.load(file)
                        if student.ID == ID:
                            return student
                    except EOFError:
                        print("Student not found")
                        return
        except FileNotFoundError:
            print("File students_pickle.txt doesn't exist")
                
    def create_student(self, student):
        if type(student) is not Student:
            print("You are trying to create", type(student), "which is not a student")
            return
        with open("students_pickle.txt", "ab") as file:
            pickle.dump(student, file)
    
    def delete_student(self, student):
        if type(student) is not Student:
            print("You are trying to delete", type(student), "which is not a student")
            return
        student_found = self.get_student_by_ID(student.ID)
        if not student_found:
            print("The student that you want to delete doesn't exist")
            return
        students = self.get_all_students()
        with open("students_pickle.txt", "wb") as file:
            for student in students:
                if student_found.ID != student.ID:
                    pickle.dump(student, file)
                    
    def delete_storage(self):
        os.remove("students_pickle.txt")