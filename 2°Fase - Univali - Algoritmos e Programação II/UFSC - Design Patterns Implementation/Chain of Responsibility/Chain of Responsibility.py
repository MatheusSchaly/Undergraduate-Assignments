"""
Created on Tue Jun 19 16:54:33 2018

@author: Matheus Schaly
"""


from abc import ABC, abstractmethod


# Handler
class Chain(ABC):
    
    @property
    def next_in_chain(self):
        pass
    
    @next_in_chain.setter
    @abstractmethod
    def next_in_chain(self, next_in_chain):
        self._next_in_chain = next_in_chain


# Concrete Handler 1
class Negative_Processor(Chain):
    
    _next_in_chain = None
    
    @property
    def next_in_chain(self):
        return self._next_in_chain
    
    @next_in_chain.setter
    def next_in_chain(self, next_in_chain):
        self._next_in_chain = next_in_chain

    def process(self, request):
        if request < 0:
            print("Negative processor: " + str(request))
        else:
            self.next_in_chain.process(request)


# Concrete Handler 2
class Zero_Processor(Chain):
    
    _next_in_chain = None
    
    @property
    def next_in_chain(self):
        return self._next_in_chain
    
    @next_in_chain.setter
    def next_in_chain(self, next_in_chain):
        self._next_in_chain = next_in_chain

    def process(self, request):
        if request == 0:
            print("Zero processor: " + str(request))
        else:
            self.next_in_chain.process(request) 


# Concrete Handler 3
class Positive_Processor(Chain):
    
    _next_in_chain = None
    
    @property
    def next_in_chain(self):
        return self._next_in_chain
    
    @next_in_chain.setter
    def next_in_chain(self, next_in_chain):
        self._next_in_chain = next_in_chain

    def process(self, request):
        if request > 0:
            print("Positive processor: " + str(request))
        else:
            self.next_in_chain.process(request)
            

c1 = Negative_Processor()
c2 = Zero_Processor()
c3 = Positive_Processor()

c1.next_in_chain = c2
c2.next_in_chain = c3

c1.process(10)
c1.process(-15)
c1.process(0)
c1.process(-20)