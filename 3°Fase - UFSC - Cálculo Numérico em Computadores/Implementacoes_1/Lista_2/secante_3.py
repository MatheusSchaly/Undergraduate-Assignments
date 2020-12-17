from math import exp, sin, cos, e

def f(x):
    return e**x - 2*cos(x)

k = 0
erro = 10**-6
x0 = 0
x1 = 2
fx0 = f(x0)
fx1 = f(x1)

while (abs(fx1) > erro):
    k += 1
    xk = x1 - ((x1-x0)*fx1) / (fx1-fx0)
    x0 = x1
    x1 = xk
    fx0 = f(x0)
    fx1 = f(x1)

print('Repeticoes:', k)
print('Raiz (solucao):', xk)
print('Precisao:', abs(fx1))
