import numpy as np

# Entrada
# a = np.array([[4, 2, 3], [2, -4, -1], [-1, 1, 4]], dtype=float)
# b = np.array([7, 1, -5], dtype=float)
a = np.array([[1, 1, 2], [3, -5, 1], [2, 1, -1]], dtype=float)
b = np.array([27, -9, -1], dtype=float)
a_r = np.copy(a) # Para calcular o resíduo
b_r = np.copy(b) # Para calcular o resíduo
n = len(b)
L = np.zeros((n, n))
U = np.eye(n)

# Resolvendo o sistema
for k in range(n):

	# Montando matriz L (Lower)
	for i in range(k, n):
		soma = 0
		for t in range(k):
			soma += L[i, t] * U[t, k]
		L[i, k] = a[i, k] - soma

	# Montando matriz U (Upper)
	for j in range(k+1, n):
		soma = 0
		for t in range(k):
			soma += L[k, t] * U[t, j]
		U[k, j] = (a[k, j] - soma) / L[k, k]

# Encontrando y utilizando substituição direta
y = np.empty(n)
y[0] = b[0] / L[0, 0]
for i in range(1, n):
	soma = 0
	for j in range(i):
		soma += L[i, j] * y[j]
	y[i] = (b[i] - soma) / L[i, i]

# Encontrando x (solução) utilizando retro-substituição
x = np.empty(n)
x[-1] = y[-1] / U[-1, -1]
for i in range(n-1, -1, -1):
	soma = 0
	for j in range(i+1, n):
		soma += U[i, j] * x[j]
	x[i] = (y[i] - soma) / U[i, i]

# Calculando resíduo
b_r_t = b_r.reshape((-1, 1))
x_t = x.reshape((-1, 1))
r = abs(b_r_t - np.dot(a_r, x_t))

# Output
print(f'\na:\n{a}')
print(f'\nb:\n{b}')
print(f'\nL:\n{L}')
print(f'\nU:\n{U}')
print(f'\nr:\n{r}')
print(f'\ny:\n{y}')
print(f'\nx:\n{x}')
