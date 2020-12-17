import numpy as np

# Intregração numérica pela regra de Simpson

# Entrada
a = 0 # Limite inferior
b = 1 # Limite superior
erro = 10 ** -6

n = 2 # Número de intervalos * 2 (deve ser par no Simpson) (se usar n=2, tens 1 intervalo)
k = 0
Sc_curr = 0
Sc_prev = 0
dif = 1

while dif > erro:
	h = (b-a) / n # Altura
	n_aux = n + 1
	k += 1

	# Tabela
	x = np.linspace(a, b, n_aux) # Vetor x
	y = np.empty(n_aux) # Vetor y
	# for i in range(n):
		# y[i] = x[i] ** 3 # Entrada: Função na qual a integral será calculada
	y = np.exp(x) # Entrada: Função na qual a integral será calculada
	# (nesse caso usando a func exp do numpy para calcular a função e^x)

	# Simpson composto
	Sc_curr = (h/3) * (y[0] + (4 * sum(y[1::2])) + (2 * sum(y[2:-1:2])) + y[-1])

	dif = abs(Sc_curr-Sc_prev)
	Sc_prev = Sc_curr
	n += 2 # Aumentando o número de trapézios

print(f'\nLimite inferior:\n{a}')
print(f'\nLimite Superior:\n{b}')
print(f'\nVetor x inserido na função:\n{x}')
print(f'\nVetor y calculado a partir de x e da função:\n{y}')
print(f'\nNúmero de iterações:\n{k}')
print(f'\nAltura:\n{h}')
print(f'\nÁrea calculada pelo regra de Simpson:\n{Sc_curr}')
