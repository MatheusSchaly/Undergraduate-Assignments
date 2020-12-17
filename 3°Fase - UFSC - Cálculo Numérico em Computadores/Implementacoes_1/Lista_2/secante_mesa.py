from math import exp, sin, cos, e

# Entradas
def f(x):
    return x**2 - 5
erro = 10**-6
x0 = 2
x1 = 3

fx0 = f(x0)
fx1 = f(x1)
k = 0
while (abs(fx1) > erro):
    xk = x1 - ((x1-x0)*fx1) / (fx1-fx0)
    print(f'K: {k}'.ljust(8, ' '), end='')
    print(f'a: {round(x0, 3)}'.ljust(11, ' '), end='')
    print(f'xm: {round(xk, 3)}'.ljust(12, ' '), end='')
    print(f'b: {round(x1, 3)}'.ljust(11, ' '), end='')
    print(f'fa: {round(fx0, 3)}'.ljust(12, ' '), end='')
    print(f'fxm: {round(fx1, 3)}'.ljust(13, ' '))
    x0 = x1
    x1 = xk
    k += 1
    fx0 = f(x0)
    fx1 = f(x1)

print('Repeticoes:', k)
print('Raiz (solucao):', xk)
print('Precisao:', abs(fx1))
