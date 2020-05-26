# -*- coding: utf-8 -*-
"""
Created on Fri Jun 29 08:33:48 2018

main references: 
https://www.dataquest.io/blog/loading-data-into-postgres/
https://www.safaribooksonline.com/library/view/python-cookbook/0596001673/ch08s08.html

psycopg2: Open source library that implements the Postgres protocol

conn: The connection object creates a client session with the database server 
that instantiates a persistant client to speak with.

cur: Cursor is created by the Connection object and be using the Cursor object 
we  will be able to execute our commands.

@author: Matheus Schaly
"""


from student_dao import Student_DAO
from student import Student
import psycopg2, pickle


# Concrete DAO 3
class Student_DAO_Postgres(Student_DAO):

    def _open_connection(self):
        conn = psycopg2.connect(host="localhost", 
                                user = "postgres", 
                                password = "your_password", 
                                database = "student_dao_postgres")
        cur = conn.cursor()
        return (conn, cur)
    
    def _close_connection(self, conn, cur):
        if cur is not None:   
            cur.close()
        
        if conn is not None:
            conn.close()

    def get_all_students(self):
        students = []
        conn, cur = self._open_connection()
        
        try:
            cur.execute("SELECT * FROM student_postgres;")
        except psycopg2.ProgrammingError:
            print("Table student_postgres doesn't exist")
            return
            
        for _, student in cur.fetchall():
            students.append(pickle.loads(student))
        
        self._close_connection(conn, cur)
        
        return students

    def get_student_by_ID(self, ID):
        conn, cur = self._open_connection()
        
        try:
            cur.execute("SELECT student FROM student_postgres WHERE ID = (%s);",
                        [ID])
            student = pickle.loads(cur.fetchone()[0])
        except TypeError:
            print("Student not found")
            return
        except psycopg2.ProgrammingError:
            print("Table student_postgres doesn't exist")
            return
        except psycopg2.DataError:
            print('Invalid ID input "' + type(ID).__name__ + '" it must be int')
            return
        
        self._close_connection(conn, cur)

        return student
    
    def create_student(self, student):
        if type(student) is not Student:
            print("You are trying to create", type(student), "which is not a student")
            return
        conn, cur = self._open_connection()
        
        cur.execute("""
        CREATE TABLE IF NOT EXISTS student_postgres(
                ID integer PRIMARY KEY,
                student BYTEA
        );
        """)
        try:
            cur.execute("INSERT INTO student_postgres VALUES (%s, %s);",
                        (student.ID, psycopg2.Binary(pickle.dumps(student))))
            conn.commit() 
        except psycopg2.IntegrityError:
            print("Key ID =", (student.ID), "already exists")
            
        self._close_connection(conn, cur)
        
    def delete_student(self, student):
        if type(student) is not Student:
            print("You are trying to delete", type(student), "which is not a student")
            return
        conn, cur = self._open_connection()
        
        cur.execute("DELETE FROM student_postgres WHERE ID = (%s);",
                    [student.ID])
        conn.commit()
        
        self._close_connection(conn, cur)

    def delete_storage(self):
        conn, cur = self._open_connection()
        
        cur.execute("DROP TABLE IF EXISTS student_postgres")
        conn.commit()
        
        self._close_connection(conn, cur)
