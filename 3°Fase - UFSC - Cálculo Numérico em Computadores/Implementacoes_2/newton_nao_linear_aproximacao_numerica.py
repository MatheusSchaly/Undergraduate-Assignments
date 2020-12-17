import numpy as np

#Entrada
def F1(x):
	return x[0] + x[1] - 3 		# f1
def F2(x):
	return x[0] ** 2 + x[1] ** 2 - 9	# f2

# Entrada
x = np.array([[1], [5]], dtype=float)
erro = 10 ** -6

n = len(x)
k = 0
J = np.zeros((n, n))
F = np.zeros(n)
d = np.array([1], dtype=float)
h = 0.001

# f1 = e^x1 + x2 - 1
# f2 = x1^2 + x2^2 - 4

# J = [[e^x1, 1], [2*x1 + 2*x2]]

# Resolvendo o sistema
while max(abs(d)) > erro: # Poderia ser sum também
	k += 1
	F[0] = F1(x)
	F[1] = F2(x)
	# Se fosse um sistema 3x3 teria mais um valor aqui
	J[0, 0] = (F1(np.array([x[0]+h, x[1]], dtype=float)) - F[0]) / h 	# derivada parcial em J[0] de x1
	J[0, 1] = (F1(np.array([x[0], x[1]+h], dtype=float)) - F[0]) / h	# derivada parcial em J[0] de x2
	J[1, 0] = (F2(np.array([x[0]+h, x[1]], dtype=float)) - F[1]) / h 	# derivada parcial em J[1] de x1
	J[1, 1] = (F2(np.array([x[0], x[1]+h], dtype=float)) - F[1]) / h 	# derivada parcial em J[1] de x2
	# Se fosse um sistema 3x3 teria mais dois valores aqui
	print(f'J:\n{J}')
	print(f'F:\n{F}')
	d = np.linalg.solve(J, -F.reshape(-1, 1))
	x += d
	print(f'd:\n{d}')
	print(f'x:\n{x}')
	print()

# Output
print('\n\n\nResultado final:')
print(f'\nIteracoes:\n{k}')
print(f'\nVetor x (Solucao):\n{x}')
print(f'\nd:\n{d}')
