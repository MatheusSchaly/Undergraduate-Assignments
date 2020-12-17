import numpy as np

a = np.array([[4, 2, 3], [2, -4, -1], [-1, 1, 4]], dtype=float)
b = np.array([7, 1, -5], dtype=float)
n = len(b)

for k in range(n-1):
	for i in range(k+1, n):
		m = (a[i, k]/a[k, k])
		for j in range(k, n):
			a[i, j] = a[i, j] - m * a[k, j]
		b[i] = b[i] - m * b[k]

print(a)
print(b)
