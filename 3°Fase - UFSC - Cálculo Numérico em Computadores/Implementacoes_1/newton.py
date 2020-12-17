from math import sin, cos, e, sqrt, log

# Entradas
def f(x):
    return 3 * x - e ** x
def d(x):
    return 3 - e ** x
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
print('Raiz (solucao):', round(xk, 10))
print('Precisao:', abs(fx))
