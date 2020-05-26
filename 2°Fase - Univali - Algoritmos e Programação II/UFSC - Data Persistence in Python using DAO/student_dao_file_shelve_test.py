# -*- coding: utf-8 -*-
"""
Created on Thu Jun 28 17:12:14 2018

@author: Matheus Schaly
"""


from student_dao_file_shelve import Student_DAO_File_Shelve
from student import Student


# TESTING PERSISTENCE USING SHELVE
print("\n\nTESTING PERSISTENCE USING SHELVE:\n")
                
student_DAO_file_shelve = Student_DAO_File_Shelve()

# Testing create_student
student_DAO_file_shelve.create_student(Student(1, "Matheus"))
student_DAO_file_shelve.create_student(Student(2, "Henrique"))
student_DAO_file_shelve.create_student(Student(3, "Schaly"))
student_DAO_file_shelve.create_student("apple")

# Testing get_all_students
students = student_DAO_file_shelve.get_all_students()

for student in students:
    print(student)
print()

# Testing get_student_by_ID
student1 = student_DAO_file_shelve.get_student_by_ID(1)
student2 = student_DAO_file_shelve.get_student_by_ID(2)
student = student_DAO_file_shelve.get_student_by_ID("orange")

print(student1)
print(student2)
print()

# Testing delete_student
student_DAO_file_shelve.delete_student(student1)
student_DAO_file_shelve.delete_student(student2)
student_DAO_file_shelve.delete_student("grape")
student_DAO_file_shelve.delete_student(Student(4, "Nonexistent"))

students = student_DAO_file_shelve.get_all_students()
for student in students:
    print(student)
print()

# Testing delete_storage
# student_DAO_file_shelve.delete_storage() # Unncomment to delete the storage

students = student_DAO_file_shelve.get_all_students()

try:
    for student in students:
        print(student)
    print()
except TypeError:
    print("students is of type", type(students).__name__)
    
student = student_DAO_file_shelve.get_student_by_ID("orange")