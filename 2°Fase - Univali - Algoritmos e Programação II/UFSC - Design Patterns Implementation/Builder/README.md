# Builder

•	Separates the construction of a complex object (4) from its representation (car1, car2), so the same construction process (1, 2, 3) can create different representations. Useful when too many arguments need to be passed to the constructor or the object creation contains optional parameters.
1.	Director: Car_Builder_Director
2.	Builder: Builder
3.	Concrete Builder: Car_Builder
4.	Product: Car
