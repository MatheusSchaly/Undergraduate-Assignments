"""
Created on Tue Jun 19 20:24:50 2018

@author: Matheus Schaly
"""


from abc import ABC, abstractmethod


# Receiver
class Stock_Trade:
    
    def buy(self):
        print("Stock bought")
        
    def sell(self):
        print("Stock sold")


# Command
class Order(ABC):
    
    @abstractmethod
    def execute(self):
        pass


# Concrete Command 1
class Buy_Stock_Order(Order):
    
    def __init__(self, stock):
        self.stock = stock
        
    def execute(self):
        self.stock.buy()


# Concrete Command 2
class Sell_Stock_Order(Order):
    
    def __init__(self, stock):
        self.stock = stock
        
    def execute(self):
        self.stock.sell()


# Invoker
class Agent:
    
    def __init__(self):
        self.order_queue = []
        
    def append_order(self, order):
        self.order_queue.append(order)
        
    def execute(self):
        for order in self.order_queue:
            order.execute()
        

stock = Stock_Trade()
buy_stock = Buy_Stock_Order(stock)
sell_stock = Sell_Stock_Order(stock)

agent = Agent()
agent.append_order(buy_stock)
agent.append_order(sell_stock)
agent.append_order(buy_stock)
agent.execute()