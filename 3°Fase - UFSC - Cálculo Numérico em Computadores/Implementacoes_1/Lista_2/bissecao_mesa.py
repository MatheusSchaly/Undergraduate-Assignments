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
    xm = (a + b) / 2
    fxm = f(xm)
    print(f'K: {k}'.ljust(8, ' '), end='')
    print(f'a: {round(a, 3)}'.ljust(11, ' '), end='')
    print(f'xm: {round(xm, 3)}'.ljust(12, ' '), end='')
    print(f'b: {round(b, 3)}'.ljust(11, ' '), end='')
    print(f'fa: {round(fa, 3)}'.ljust(12, ' '), end='')
    print(f'fxm: {round(fxm, 3)}'.ljust(13, ' '), end='')
    print(f'fb: {round(fb, 3)}'.ljust(12, ' '))
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
