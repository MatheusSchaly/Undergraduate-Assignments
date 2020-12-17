from math import sin, cos, e

# Entradas
def f(x):
    return x ** 2 - 5
a = 2
b = 3
erro = 10**-6

fa = f(a)
fb = f(b)
fxm = 1
k = 0
while (abs(fxm) > erro):
    xm = (a + b) / 2
    fxm = f(xm)
    print(f'K: {k}'.ljust(8, ' '), end='')
    print(f'a: {round(a, 10)}'.ljust(20, ' '), end='')
    print(f'xm: {round(xm, 10)}'.ljust(20, ' '), end='')
    print(f'b: {round(b, 10)}'.ljust(20, ' '), end='')
    print(f'fa: {round(fa, 10)}'.ljust(20, ' '), end='')
    print(f'fxm: {round(fxm, 10)}'.ljust(20, ' '), end='')
    print(f'fb: {round(fb, 10)}'.ljust(20, ' '))
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
