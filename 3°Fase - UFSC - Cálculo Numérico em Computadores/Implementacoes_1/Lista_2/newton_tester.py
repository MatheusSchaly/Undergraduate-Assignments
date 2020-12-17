from math import sin, cos, e, sqrt
import numpy as np

# Entradas
def f(x):
    return 7 * (2 - 0.9 ** x) - 10
def d(x):
    return -7 * (0.9 ** x) * np.log(0.9)
x0 = 6
erro = 10**-6

fx = f(x0)
dfx = d(x0)
k = 0
while (abs(fx) > erro):
    xk = x0 - fx/dfx
    x0 = xk
    k += 1
    fx = f(x0)
    dfx = d(x0)

print('Repeticoes:', k)
print('Raiz (solucao):', round(xk, 8))
print('Precisao:', abs(fx))
