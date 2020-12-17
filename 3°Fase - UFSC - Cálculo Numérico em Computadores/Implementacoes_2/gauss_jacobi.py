import numpy as np

# Entrada
a = np.array([[3, -1, -1], [1, 3, 1], [2, -2, 4]], dtype=float)
b = np.array([1, 5, 4], dtype=float)
x0 = np.array([0, 0, 0], dtype=float)
xk = np.array([0, 0, 0], dtype=float)
erro = 10 ** -6

n = len(b)
k = 0
dif_1 = 1

# Resolvendo o sistema
while dif_1 > erro:
	k += 1
	for i in range(n):
		soma = 0
		for j in range(n):
			if j != i:
				soma += a[i, j] * x0[j]
		xk[i] = (b[i] - soma) / a[i, i]
	dif_1 = sum(abs(xk-x0)) # Opcao 1
	dif_2 = max(abs(xk-x0)) # Opcao 2
	print(f'\nVetor xk:\n{xk}')
	print(f'Dif_1:\n{dif_1}')
	print(f'Dif_2:\n{dif_2}')
	x0 = np.copy(xk)

# Output
print('\n\n\nResultado final:')
print(f'\nIteracoes:\n{k}')
print(f'\nVetor xk (Solucao):\n{xk}')
print(f'\nDif_1:\n{dif_1}')
print(f'\nDif_2:\n{dif_2}')
