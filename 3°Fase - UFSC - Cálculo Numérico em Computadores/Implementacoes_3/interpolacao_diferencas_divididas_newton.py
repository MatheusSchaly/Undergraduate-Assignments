import numpy as np
from math import sqrt, pi, sin

# Gera a matriz que é necessária para montar os coeficientes finais
# (note que os coeficientes finais nunca são efetivamente criados no algoritmo)
def gera_tabela(x, y, n):
	a = np.empty((n, n), dtype=float)
	a[:, 0] = y
	for j in range(1, n):
		for i in range(j, n):
			a[i, j] = (a[i, j-1] - a[i-1, j-1]) / (x[i] - x[i-j])
	return a

# Diferenças divididas de Newton
def diferencas_divididas_newton(x, n, xx, a):
	p = 0 # p pode ser um ponto ou um vetor
	for i in range(n):
		m = 1
		for j in range(i):
			m *= (xx - x[j])
		p += a[i, i] * m
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
a = gera_tabela(x, y, n)

# Calcula o y para cada xx em xx_array
px = []
for xx in xx_array:
	px.append(diferencas_divididas_newton(x, n, xx, a))
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
