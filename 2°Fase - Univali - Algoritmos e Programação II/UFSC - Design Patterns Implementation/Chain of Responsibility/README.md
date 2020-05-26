# Chain of Responsibility

•	Avoid coupling the sender of a request to its receiver by passing the request to a chain of objects (instead of only one object), until one of the objects (1, 2, 3, 4) solves the problem.
1.	Handler: Chain
2.	Concrete Handler 1: Negative_Processor
3.	Concrete Handler 2: Zero_Processor
4.	Concrete Handler 3: Positive_Processor
