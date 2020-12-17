import numpy as np

# Entrada
x = np.array([[1], [5]], dtype=float)
erro = 10 ** -6

n = len(x)
k = 0
J = np.zeros((n, n))
F = np.zeros(n)
d = np.array([1], dtype=float)

# f1 = e^x1 + x2 - 1
# f2 = x1^2 + x2^2 - 4

# J = [[e^x1, 1], [2*x1 + 2*x2]]

# Resolvendo o sistema
while max(abs(d)) > erro: # Poderia ser sum também
	k += 1

	# Entrada
	J[0, 0] = 1			 	# derivada parcial em J[0] de x1
	J[0, 1] = 1				# derivada parcial em J[0] de x2
	J[1, 0] = 2 * x[0]		# derivada parcial em J[1] de x1
	J[1, 1] = 2 * x[1]		# derivada parcial em J[1] de x2
	F[0] = x[0] + x[1] - 3				# f1
	F[1] = x[0] ** 2 + x[1] ** 2 - 9	# f2

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
