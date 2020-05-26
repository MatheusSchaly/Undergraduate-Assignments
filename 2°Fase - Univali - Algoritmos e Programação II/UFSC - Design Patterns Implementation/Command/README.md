# Command

•	Encapsulates a request (1) as an object (5) letting you stack commands (2, 3, 4) and calling the execute method to execute all the commands given, at once. May support undoable operations.
1.	Receiver: Stock_Trade
2.	Command: Order
3.	Concrete Command 1: Buy_Stock_Order
4.	Concrete Command 2: Sell_Stock_Order
5.	Invoker: Agent
