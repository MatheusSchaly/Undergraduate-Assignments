from math import sin, cos, e

# Entradas
def f(x):
    return 7 * (2 - 0.9 ** x) - 10
a = 3
b = 7
erro = 10**-6

fa = f(a)
fb = f(b)
fxm = 1
k = 0
while (abs(fxm) > erro):
    xm = (a - (f(a)*(b-a))/(f(b)-f(a)))
    fxm = f(xm)
    k += 1
    if fa * fxm < 0:
        b = xm
        fb = fxm
    else:
        a = xm
        fa = fxm

print('Repeticoes:', k)
print('Raiz (solucao):', round(xm, 8))
print('Precisao:', abs(fxm))
