import numpy as np
from math import sqrt, pi, sin

# Interpolação lagrange
def lagrange(x, y, n, xx):
	p = 0
	for i in range(n):
		num = 1
		den = 1
		for j in range(n):
			if j != i:
				num *= xx - x[j]
				den *= x[i] - x[j]
		p += y[i] * (num/den)
	return p

# Entrada
# Coordenadas
# x = np.array([-1, 0, 1], dtype=float)
# y = np.array([4, 1, -1], dtype=float)
# xx_array = [1] # Valor que se quer descobrir xx
# x = np.array([0, 1, 2, 3], dtype=float)
# y = np.array([-3, -2, 4, 0], dtype=float)
# xx_array = [1, 2, 3, 4, 5, 6, 7, 8, 9, -1, -2, -3]
x = np.linspace(-pi, pi, 9)
y = np.sin(x)
xx_array = np.linspace(-pi, pi, 18) # Também podemos entrar um vetor de xx que queremos descobrir

n = len(x) # Quantidade de itens

# Calcula o y para cada xx em xx_array
px = []
for xx in xx_array:
	px.append(lagrange(x, y, n, xx))
px = np.array(px)
xx_ground_truth = np.sin(xx_array)

erro = np.abs(px - xx_ground_truth)

# Output
print(f'\nCoordenadas x:\n{x}')
print(f'\nCoordenadas y:\n{y}')
print(f'\nValor(es) xx que queremos descobrir o y:\n{xx_array}')
print(f'\nValor(es) do polinômio px no(s) ponto(s) xx:\n{px}')
print(f'\nValor real da função:\n{xx_ground_truth}')
print(f'\nVetor de erros:\n{erro}')
