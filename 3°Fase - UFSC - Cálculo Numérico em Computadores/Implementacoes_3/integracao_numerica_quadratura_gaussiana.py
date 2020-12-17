import numpy as np
import math

# Intregração numérica pela quadratura gaussiana

# Entrada
a = 1 # Limite inferior
b = 3 # Limite superior
n = 3 # Número de intervalos * 2 (deve ser par no Simpson) (se usar n=2, tens 1 intervalo)

t = np.empty(n)
A = np.empty(n)
x = np.empty(n)
F = np.empty(n)

# Entrada, é uma tabela, tem pro n=2, n=3, n=4...
if n == 3:
	t[0] = -0.7745966692414834
	t[1] = 0.7745966692414834
	t[2] = 0
	A[0] = 5/9
	A[1] = 5/9
	A[2] = 8/9

for i in range(n):
	x[i] = (b-a)/2*t[i] + (b+a)/2
dx = (b-a)/2
for i in range(n):
	F[i] = (np.log(2*x[i]) + x[i] ** 2) * dx # Entrada: Função (* dx é padrão)
I = A.dot(F)

print(f'\nLimite inferior:\n{a}')
print(f'\nLimite Superior:\n{b}')
print(f'\nNúmero de subintervalos:\n{n}')
print(f'\nÁrea calculada pelo regra de Simpson:\n{I}')
