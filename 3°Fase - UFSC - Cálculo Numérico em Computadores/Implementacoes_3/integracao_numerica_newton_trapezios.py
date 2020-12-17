import numpy as np

# Intregração numérica pela regra de trapézios

# Entrada
a = 0 # Limite inferior
b = 1 # Limite superior
n = 7 # Número de trapézios

h = (b-a) / n # Altura
n += 1

# Tabela
x = np.linspace(a, b, n) # Vetor x
y = np.empty(n) # Vetor y
for i in range(n):
	y[i] = x[i] ** 3 # Entrada: Função na qual a integral será calculada

# Trapézio composto
Tc = (h/2) * (y[0] + (2 * sum(y[1:-1])) + y[-1])

print(f'\nLimite inferior:\n{a}')
print(f'\nLimite Superior:\n{b}')
print(f'\nVetor x inserido na função:\n{x}')
print(f'\nVetor y calculado a partir de x e da função:\n{y}')
print(f'\nAltura:\n{h}')
print(f'\nÁrea calculada pelo regra de trapézios:\n{Tc}')
