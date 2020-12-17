from math import exp, sin, cos, e

# Entradas
def f(x):
    return x - cos(x)
def d(x):
    return 1 + sin(x)
x0 = 1
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
print('Raiz (solucao):', xk)
print('Precisao:', abs(fx))
