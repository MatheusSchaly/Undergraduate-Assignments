import numpy as np

# a =
# 2 1 0 0 0
# 1 2 1 0 0
# 0 1 2 1 0
# 0 0 1 2 1
# 0 0 0 1 2

# Entrada
r = np.array([2, 2, 2, 2, 2], dtype=float)
t = np.array([0, 1, 1, 1, 1], dtype=float)
d = np.array([1, 1, 1, 1, 0], dtype=float)
b = np.array([4, 4, 0, 0, 2], dtype=float)

n = len(b)
x = np.empty(n)

# Resolvendo o sistema tridiagonal
for k in range(1, n):
	m = t[k] / r[k-1]
	r[k] -= (m * d[k-1])
	b[k] -= (m * b[k-1])

x[n-1] = b[n-1] / r[n-1]

for i in range(n-2, -1, -1):
	x[i] = (b[i] - d[i] * x[i+1]) / r[i]

# Output
print('\nResultado final:')
print(f'\nVetor x (Solucao):\n{x}')
