import numpy as np

# Entrada
# a = np.array([[4, 2, 3], [2, -4, -1], [-1, 1, 4]], dtype=float)
a = np.array([[3, 1.5, 4.75], [4.01, 1, 3], [1, 0.5, -0.05]], dtype=float)
a_r = np.copy(a) # Para calcular o resíduo
# b = np.array([7, 1, -5], dtype=float)
b = np.array([8, 7, -1], dtype=float)
b_r = np.copy(b) # Para calcular o resíduo
n = len(b)

# Resolvendo o sistema
for k in range(n-1):

	# Zerando as linhas (echelon form) utilizando eliminação Gaussiana
	for i in range(k+1, n):
		m = (a[i, k]/a[k, k])
		for j in range(k, n):
			a[i, j] = a[i, j] - m * a[k, j]
		b[i] = b[i] - m * b[k]

	# Encontrando a solução do sistema utilizando retro-ubstituição
	x = np.empty(n)
	x[n-1] = b[n-1] / a[n-1, n-1]
	for i in range(n-1, -1, -1):
		soma = 0
		for j in range(i+1, n):
			soma += a[i, j] * x[j]
		x[i] = (b[i] - soma) / a[i, i]

# Calculando resíduo
b_r_t = b_r.reshape((-1, 1))
x_t = x.reshape((-1, 1))
r = abs(b_r_t - np.dot(a_r, x_t))

# Output
print(f'\nMatriz A (escalonada):\n{a}')
print(f'\nVetor b:\n{b}')
print(f'\nVetor solucao x:\n{x}')
print(f'\nVetor residuo:\n{r}')
