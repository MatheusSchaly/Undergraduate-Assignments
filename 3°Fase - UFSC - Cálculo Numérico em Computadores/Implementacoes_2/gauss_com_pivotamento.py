import numpy as np

# Entrada
a = np.array([[1, 2, 1, 3], [1.5, 1.5, -1, 1], [3, -1, 1, 2], [1, 1, -1, -1]], dtype=float)
a_r = np.copy(a) # Para calcular o resíduo
# b = np.array([4, -3, 1, -1, -1, 0, -1, 1, 3, -2], dtype=float)
b = np.array([8, 1, 1, 3], dtype=float)
b_r = np.copy(b) # Para calcular o resíduo
n = len(b)
o = list(range(n)) # Ordem das linhas

# Resolvendo o sistema
for k in range(n-1):

	# Encontrando a linha que possui o maior valor absoluto na coluna k
	maior = abs(a[o[k], k])
	p = k
	for i in range(k+1, n):
		print(f'Apos {i+k} pivotacoes parciais:\n{a}')
		if abs(a[o[i], k]) > maior:
			maior = a[o[i], k]
			p = i

	# Realizando a troca de linhas
	if p > k:

		o[p], o[k] = o[k], o[p]

	# Zerando as linhas (echelon form) utilizando eliminação Gaussiana
	for i in range(k+1, n):
		m = (a[o[i], k] / a[o[k], k])
		for j in range(k, n):
			a[o[i], j] = a[o[i], j] - m * a[o[k], j]
		b[o[i]] = b[o[i]] - m * b[o[k]]

# Encontrando a solução do sistema utilizando retro-ubstituição
x = np.empty(n)
x[-1] = b[o[-1]] / a[o[-1], -1]
for i in range(n-1, -1, -1):
	soma = 0
	for j in range(i+1, n):
		soma += a[o[i], j] * x[j]
	x[i] = (b[o[i]] - soma) / a[o[i], i]

# Calculando resíduo
b_r_t = b_r.reshape((-1, 1))
x_t = x.reshape((-1, 1))
r = abs(b_r_t - np.dot(a_r, x_t))

# Output
print(f'\nMatriz A (escalonada):\n{a}')
print(f'\nVetor b:\n{b}')
print(f'\nVetor solucao x:\n{x}')
print(f'\nVetor ordenamento, das trocas de linhas:\n{o}')
print(f'\nVetor residuo:\n{r}')
