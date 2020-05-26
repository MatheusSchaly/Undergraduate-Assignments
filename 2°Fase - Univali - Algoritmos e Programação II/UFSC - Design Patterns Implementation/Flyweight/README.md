# Flyweight

•	Improves memory usage and speed by enabling (not enforcing) the sharing of objects’ intrinsic state (3) and changing only its extrinsic state (1, 2, 4) instead of creating new one. So, if a black color is already created, send it and let the user change its extrinsic state x, y and radius.
1.	Flyweight Factory: Shape_Factory
2.	Flyweight: Shape
3.	Concrete Flyweight: Color
4.	Unshared Concrete Flyweight: Circle
