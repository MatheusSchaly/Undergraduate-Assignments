from math import exp, sin, cos, e

# Entradas
def f(x):
    return 5*x**5 - 4*x**4 + x**3 - x + 1
def d(x):
    return 25*x**4 - 16*x**3 + 3*x**2 - 1
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
