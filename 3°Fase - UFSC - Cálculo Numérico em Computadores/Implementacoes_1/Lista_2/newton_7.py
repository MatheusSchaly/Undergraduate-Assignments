from math import exp, sin, cos, e

# Entradas
def f(x):
    return sin(x) - x - 1
def d(x):
    return cos(x) - 1
x0 = -2.5
erro = 10**-3

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
print('Raiz (solucao):', xk)
print('Precisao:', abs(fx))
