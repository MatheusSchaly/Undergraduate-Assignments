from math import exp, sin, cos, e

# Entradas
def f(x):
    return x*cos(x) + 1.9
a = 2
b = 3
erro = 10**-3

fa = f(a)
fb = f(b)
fxm = 1
k = 0
while (abs(fxm) > erro):
    xm = (a + b) / 2
    fxm = f(xm)
    k += 1
    if fa * fxm < 0:
        b = xm
        fb = fxm
    else:
        a = xm
        fa = fxm

print('Repeticoes:', k)
print('Raiz (solucao):', xm)
print('Precisao:', abs(fxm))
