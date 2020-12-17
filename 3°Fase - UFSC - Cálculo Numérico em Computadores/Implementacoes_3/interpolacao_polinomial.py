import numpy as np
from math import sqrt

# Eliminação Gaussiana com pivotamento para resolver o sistema
def eliminacao_gaussiana_com_pivotamento(a, b):
	n = len(b)
	o = list(range(n)) # Ordem das linhas

	# Resolvendo o sistema
	for k in range(n-1):

		# Encontrando a linha que possui o maior valor absoluto na coluna k
		maior = abs(a[o[k], k])
		p = k
		for i in range(k+1, n):
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

	return x

# Interpolação polinomial

# Entrada
# Coordenadas
x = np.array([-1, 0, 1], dtype=float)
y = np.array([4, 1, -1], dtype=float)
xx = 1 # Valor que se quer descobrir xx
# x = np.array([0, 1, 2, 3], dtype=float)
# y = np.array([-3, -2, 4, 0], dtype=float)
# xx = -3

n = len(x) # Quantidade de itens
V = np.zeros((n, n)) # Matriz que considera as coordenadas x

# Montando o sistema
for i in range(n):
	for j in range(n):
		V[i, j] = x[i] ** j

# Vetor de coeficientes finais
a = eliminacao_gaussiana_com_pivotamento(np.copy(V), np.copy(y))

# Vetor de predições considerando os coeficientes da função final c
p = np.zeros(n)
for i in range(n):
	for j in range(n):
		p[i] += a[j] * x[i] ** j

# Residuo (erro) ao quadrado entre o vetor original y e do vetor predição g
residuo = 0
g_bar = np.mean(y)
for i in range(n):
	residuo += (y[i] - p[i]) ** 2 # (MSE - mean squared error) Penaliza mais os outliers
residuo /= n # MSE

# Calcula o valor na função do ponto xx que queremos descobrir
px = 0
for j in range(n):
	px += a[j] * xx ** j


# Output
print(f'\nCoordenadas x:\n{x}')
print(f'\nCoordenadas y:\n{y}')
print(f'\nMatriz V que considera x:\n{V}')
print(f'\nVetor b que é o próprio vetor y:\n{y}')
print(f'\nMatriz a de coeficientes da função final:\n{a}')
print(f'\nVetor p de predições considerando a:\n{p}')
print(f'\nValor xx que queremos desobrir o y:\n{xx}')
print(f'\nValor do polinômio px no ponto xx:\n{px}')
print(f'\nResíduo (erro) (deve ser 0 em interpolacao) ao quadrado entre y e p:\n{residuo}')
