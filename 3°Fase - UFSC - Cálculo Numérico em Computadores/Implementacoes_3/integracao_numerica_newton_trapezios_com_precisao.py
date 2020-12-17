import numpy as np

# Intregração numérica pela regra de trapézios

# Entrada
a = 0 # Limite inferior
b = 1 # Limite superior
erro = 10 ** -6

n = 1 # Número de trapézios
k = 0
Tc_curr = 0
Tc_prev = 0
dif = 1

while dif > erro:
	h = (b-a) / n # Altura
	n_aux = n + 1
	k += 1

	# Tabela
	x = np.linspace(a, b, n_aux) # Vetor x
	y = np.empty(n_aux) # Vetor y
	for i in range(n_aux):
		y[i] = x[i] ** 3 # Entrada: Função na qual a integral será calculada

	Tc_curr = (h/2) * (y[0] + (2 * sum(y[1:-1])) + y[-1]) # Trapézio composto (soma dos trapézios)

	dif = abs(Tc_curr-Tc_prev)
	Tc_prev = Tc_curr
	n += 1 # Aumentando o número de trapézios

print(f'\nLimite inferior:\n{a}')
print(f'\nLimite Superior:\n{b}')
print(f'\nVetor x inserido na função:\n{x}')
print(f'\nVetor y calculado a partir de x e da função:\n{y}')
print(f'\nNúmero de iterações:\n{k}')
print(f'\nAltura:\n{h}')
print(f'\nÁrea calculada pelo regra de trapézios:\n{Tc_curr}')
