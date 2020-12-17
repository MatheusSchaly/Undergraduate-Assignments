import numpy as np

# Equação diferencial ordinária método de Euler

def fxy(x, y):
	return -2 * x - y # Entrada: Função (EDO)

# Entrada
a = 0 # Limite inferior
b = 0.5 # Limite superior
n = 50 # Número de subintervalos

h = (b-a) / n # Altura

# Tabela
n_aux = n+1
x = np.linspace(a, b, n_aux) # Vetor x
y = np.empty(n_aux) # Vetor y

y[0] = -1 # Entrada. Problema de valor inicial (PVI). É o valor de y quando x=0
for i in range(n):
	y[i+1] = y[i] + h * fxy(x[i], y[i])

print(f'\nLimite inferior:\n{a}')
print(f'\nLimite Superior:\n{b}')
print(f'\nVetor x inserido na função:\n{x}')
print(f'\nAltura:\n{h}')
print(f'\nVetor y calculado a partir de x e da função:\n{y}')
