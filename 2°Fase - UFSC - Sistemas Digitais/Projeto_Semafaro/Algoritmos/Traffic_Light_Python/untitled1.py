# -*- coding: utf-8 -*-
"""
Created on Sat Sep  8 19:24:03 2018

@author: HsMatheus
"""

print(14 % 7)

a = 1
b = 1

while (True):
    em1 = False
    em2 = False
    a += 2
    b += 1
    print("a: ", a)
    print("b: ", b)
    print("a - b:", a-b)
    if ((a-b) % 7  == 0):
        print("1 DIVIDIU!")
        em1 = True
    if (((a**2)-(b**2)) % 7 == 0):
        print("2 DIVIDIU!")
        em2 = True
    if (em1 == True and em2 == False):
        break