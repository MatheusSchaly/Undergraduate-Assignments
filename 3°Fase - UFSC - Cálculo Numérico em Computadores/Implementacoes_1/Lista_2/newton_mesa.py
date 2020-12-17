from math import sin, cos, e, sqrt

# Entradas
def f(x):
    return x**2 - 5
def d(x):
    return 2*x
x0 = 2
erro = 10**-6

fx = f(x0)
dfx = d(x0)
k = 0
while (abs(fx) > erro):
    xk = x0 - fx/dfx
    x0 = xk
    print(f'K: {k}'.ljust(8, ' '), end='')
    print(f'x0: {round(x0, 3)}'.ljust(13, ' '), end='')
    print(f'xk: {round(xk, 3)}'.ljust(13, ' '), end='')
    print(f'|xk-x0|: {round(abs(xk-x0), 3)}'.ljust(11, ' '))
    k += 1
    fx = f(x0)
    dfx = d(x0)

print('Repeticoes:', k)
print('Raiz (solucao):', xk)
print('Precisao:', abs(fx))
