from math import exp, sin, cos, e

def f(x):
    return x**3 - 2*e**-x

a = 0.5
b = 1
fa = f(a)
fb = f(b)
erro = 10**-6
fxm = 1
k = 0

while (abs(fxm) > erro):
    k += 1
    xm = (a - (f(a)*(b-a))/(f(b)-f(a)))
    fxm = f(xm)
    if fa * fxm < 0:
        b = xm
        fb = fxm
    else:
        a = xm
        fa = fxm

print('Repeticoes:', k)
print('Raiz (solucao):', xm)
print('Precisao:', abs(fxm))
