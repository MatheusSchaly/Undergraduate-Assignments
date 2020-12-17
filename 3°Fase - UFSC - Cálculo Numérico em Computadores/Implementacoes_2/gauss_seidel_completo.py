import numpy as np

# Entrada
a = np.array([[3, -1, -1], [1, 3, 1], [2, -2, 4]], dtype=float)
b = np.array([1, 5, 4], dtype=float)
x0 = np.array([0, 0, 0], dtype=float)
xk = np.array([0, 0, 0], dtype=float)
erro = 10 ** -6

D = np.linalg.det(a)
if D < 0.01:
	print('Determinante', D, 'é menor que 0.01, portanto o sistema é mal condicionado')
else:
	print('Determinante', D, 'é maior ou igual a que 0.01, portanto o sistema não é mal condicionado')
n = len(b)
k = 0
dif_1 = 1
w = 0.85 # < 1 sub-relaxação, > 1 sobre-relaxação, = 1 sem relaxação

# Resolvendo o sistema
while dif_1 > erro:
	k += 1
	for i in range(n):
		soma = 0
		for j in range(n):
			if j != i:
				soma += a[i, j] * x0[j]
		x0[i] = (1-w) * x0[i] + w * (b[i] - soma) / a[i, i]
	dif_1 = sum(abs(xk-x0)) # Opcao 1
	dif_2 = max(abs(xk-x0)) # Opcao 2
	print('\nVetor x0:\n', xk)
	print('Dif_1:\n', dif_1)
	print('Dif_2:\n', dif_2)
	xk = np.copy(x0)

# Output final
print('\n\n\nResultado final:')
print('\nIteracoes:\n', k)
print('\nVetor x0 (Solucao):\n', x0)
print('\nDif_1:\n', dif_1)
print('\nDif_2:\n', dif_2)
