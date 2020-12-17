import numpy as np

# Equação diferencial ordinária método de Euler

def fxy(x, y):
	return -y+x+2 # Entrada: Função (EDO)

# Entrada
a = 0 # Limite inferior
b = 0.5 # Limite superior
n = 4 # Número de subintervalos

h = 0.1 # Altura

# Tabela
n_aux = n+1
x = np.linspace(a, b, n_aux) # Vetor x
y = np.empty(n_aux) # Vetor y

y[0] = 2 # Entrada. Problema de valor inicial (PVI). É o valor de y quando x=0
for i in range(n):
	k1=h*fxy(x[i], y[i])
	k2=h*fxy(x[i]+h/2, y[i]+k1/2)
	k3=h*fxy(x[i]+h/2, y[i]+k2/2)
	k4=h*fxy(x[i]+h, y[i]+k3)
	y[i+1] = y[i] + (k1+2 * k2+2 *k3+k4) / 6
	print(f'y{i+1} = {y[i]}')

print(f'\nLimite inferior:\n{a}')
print(f'\nLimite Superior:\n{b}')
print(f'\nVetor x inserido na função:\n{x}')
print(f'\nAltura:\n{h}')
print(f'\nVetor y calculado a partir de x e da função:\n{y}')
