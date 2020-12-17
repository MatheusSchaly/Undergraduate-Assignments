from math import sin, cos, e

# Entradas
def f(x):
    return e**x * sin(x) - 1
a = 0
b = 1
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
print('Raiz (solucao):', xm)
print('Precisao:', abs(fxm))
