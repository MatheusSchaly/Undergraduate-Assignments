# Composite

•	Creates a tree structure that represents a part-whole hierarchy. If designed for uniformity, enables the client to treat individual objects (1, 3, 4) and compositions of objects (1, 2) uniformly. However, if designed for type-safety (as in the example), you guarantee that the client will not use composite methods (1, 2) on leaves (1, 3, 4).
1.	Component: Drawing
2.	Composite: Shape
3.	Leaf 1: Triangle
4.	Leaf 2: Circle
