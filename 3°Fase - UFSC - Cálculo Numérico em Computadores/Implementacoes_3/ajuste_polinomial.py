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

# Ajuste de curvas - Ajuste polinomial

# Entrada
# Coordenadas
x = np.array([1.3, 3.4, 5.1, 6.8, 8], dtype=float)
y = np.array([2, 5.2, 3.8, 6.1, 5.8], dtype=float)
M = 1 # Ajuste de grau, 1 para reta, 2 para parábola...

n = len(x) # Quantidade de itens
a = np.zeros((M+1, M+1)) # Matriz que considera as coordenadas x
b = np.zeros(M+1) # Matriz que considera as coordenadas y

# Montando o sistema
for i in range(M+1):
	for j in range(i, M+1):
		for k in range(n):
			a[i, j] += x[k] ** (i+j)
		a[j, i] = a[i, j]
	for k in range(n):
		b[i] += y[k] * x[k] ** i

# Vetor de coeficientes finais
c = eliminacao_gaussiana_com_pivotamento(np.copy(a), np.copy(b))

# Vetor de predições considerando os coeficientes da função final c
g = np.zeros(n)
for i in range(n):
	for k in range(M+1):
		g[i] += c[k] * x[i] ** (k)

# Residuo (erro) ao quadrado entre o vetor original y e do vetor predição g
residuo = 0
# residuo_1 = 0 # R-squared
# residuo_2 = 0 # R-squared
g_bar = np.mean(y)
for i in range(n):
	# Usar o primeiro (ao quadrado) para as questões da disciplina
	residuo += (y[i] - g[i]) ** 2 # (MSE - mean squared error) Penaliza mais os outliers
	# residuo += (y[i] - g[i]) ** 2 # (RMSE - root mean squared error) Mais intepretável que MSE
	# residuo += abs(y[i] - g[i]) # (MAE - mean absolute error) Penaliza menos os outliers
	# residuo_1 += (y[i] - g[i]) ** 2 # (R-squared) Porporção que a variável independente explica a dependente
	# residuo_2 += (y[i] - g_bar) ** 2 # (R-squared)
residuo /= n # MSE e MAE
# residuo = sqrt(residuo) # RSME
# residuo = 1 - (residuo_1 / residuo_2) # R-squared

# Output
print(f'\nCoordenadas x:\n{x}')
print(f'\nCoordenadas y:\n{y}')
print(f'\nMatriz a que considera x:\n{a}')
print(f'\nVetor b que considera y:\n{b}')
print(f'\nMatriz c de coeficientes da função final:\n{c}')
print(f'\nVetor g de predições considerando c:\n{g}')
print(f'\nResíduo (erro) ao quadrado entre y e g:\n{residuo}')
