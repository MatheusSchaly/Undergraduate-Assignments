"""
Created on Wed Jun 20 09:21:33 2018

@author: Matheus Schaly

Summing up an iterator in python:
    
When you call the for loop in an iterable container/aggregate/collection
it will call its method __iter__(), which will return an iterator. 
The created iterator will have a method called 
__next__() which will be called to iterate over the iterator.
    
These are eight "different" ways you can iterate over a iterable container in python:
"""

my_list = [2, 4, 6]
print(type(my_list))

print("\n1 - Using __iter__():")
my_iter = my_list.__iter__() # Creates an iterator from a iterable
print(type(my_iter))

for my_int in my_iter:
    print(my_int)


print("\n2 - Using iter():")
my_iter = iter(my_list) # Same as my_list.__iter__()
print(type(my_iter))

for my_int in my_iter:
    print(my_int)
    
for my_int in my_iter: # Iterator has been exhausted
    print(my_int)


print("\n3 - Using __iter__() and using the iterator's __next__():")
my_iter = my_list.__iter__()
print(type(my_iter))
print(my_iter.__next__())
print(my_iter.__next__())
print(my_iter.__next__())
try:
    print(my_iter.__next__())
except StopIteration:
    print("Iterator has been exhausted")
    
    
print("\n4 - Using iter() and using the iterator's next:")
my_iter = iter(my_list)
print(type(my_iter)) # Same as my_iter.__next__())
print(next(my_iter))
print(next(my_iter))
print(next(my_iter))
try:
    print(next(my_iter))
except StopIteration:
    print("Iterator has been exhausted")


print("\n5 - Explicitaly calling __iter__() on a for loop:")
print(type(my_list.__iter__()))
for my_int in my_list.__iter__():
    print(my_int)
    

print("\n6 - The normal way, hiding the iterators:")
for my_int in my_list:
    print(my_int)
    
    
print("\n7 - This is the actual implementation of the for loop in Python:")
my_iter = iter(my_list)
while True:
    try:
        my_int = next(my_iter)
        print(my_int)
    except StopIteration:
        break


print("\n8 - Using the iterator's __iter__() method, which returns itself:")
my_iter = my_list.__iter__()
my_iter2 = my_iter.__iter__()
print(type(my_iter))
print(type(my_iter2))
print(my_iter.__next__())
print(my_iter2.__next__())
print(my_iter.__next__())
try:
    print(my_iter.__next__())
except StopIteration:
    print("Iterator from my_list has been exhausted")
try:
    print(my_iter2.__next__())
except StopIteration:
    print("Iterator from my_iter has also been exhausted")
    
    
    
print("\n Checking what is an object, list and iterator:")

print("\n\n object:\n", dir(object))
print("Parents:", object.__bases__)
print("Type:", type(object))

print("\n\n list:\n", dir(list))
print("Parents:", list.__bases__)
print("Type:", type(list))

print("\n\n iter:\n", dir(iter))
print("Type:", type(iter))

print("\n\n list_iter:\n", dir(iter([10, 20])))
print("Type:", type(iter([10, 20, 30])))
