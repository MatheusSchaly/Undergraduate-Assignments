# -*- coding: utf-8 -*-
"""
Created on Fri Jun 29 13:46:26 2018

@author: Matheus Schaly
"""


from student_dao_postgres import Student_DAO_Postgres
from student import Student


# TESTING PERSISTENCE USING SHELVE
print("\n\nTESTING PERSISTENCE USING POSTGRES:\n")
          
student_DAO_postgres = Student_DAO_Postgres()

# Testing create_student
student_DAO_postgres.create_student(Student(1, "Matheus"))
student_DAO_postgres.create_student(Student(2, "Henrique"))
student_DAO_postgres.create_student(Student(3, "Schaly"))
#student_DAO_postgres.create_student("apple")

# Testing get_all_students
students = student_DAO_postgres.get_all_students()

for student in students:
    print(student)
print()
        
# Testing get_student_by_ID
student1 = student_DAO_postgres.get_student_by_ID(1)
student2 = student_DAO_postgres.get_student_by_ID(2)
student = student_DAO_postgres.get_student_by_ID("orange")
student = student_DAO_postgres.get_student_by_ID(10000)

print(student1)
print(student2)
print()

# Testing delete_student
student_DAO_postgres.delete_student(student1)
student_DAO_postgres.delete_student(student2)
student_DAO_postgres.delete_student("grape")
student_DAO_postgres.delete_student(Student(4, "Nonexistent"))

students = student_DAO_postgres.get_all_students()
for student in students:
    print(student)
print()

# Testing delete_storage
# student_DAO_postgres.delete_storage() # Unncomment to delete the storage

students = student_DAO_postgres.get_all_students()

try:
    for student in students:
        print(student)
    print()
except TypeError:
    print("students is of type", type(students).__name__)
    
student = student_DAO_postgres.get_student_by_ID("orange")