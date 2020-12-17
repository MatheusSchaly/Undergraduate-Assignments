from math import exp, sin, cos

def f(x):
    # return exp(x) * sin(x) - 1
    return x**2 - 5

def d(x):
    # return exp(x) * sin(x) + exp(x) * cos(x)
    return 2*x

x0 = 102
erro = 10**-6
k = 0
fx = f(x0)
dfx = d(x0)

while (abs(fx) > erro):
    xk = x0 - fx/dfx
    print(f'k: {round(k, 4)}\tx0: {round(x0, 4)}\txk: {round(xk, 4)}\tb:\
          {round(abs(xk - x0), 4)}\n')
    x0 = xk
    k += 1
    fx = f(x0)
    dfx = d(x0)

print(f'k: {round(k, 4)}\tx0: {round(x0, 4)}\txk: {round(xk, 4)}\tb:\
      {round(abs(xk - x0), 4)}\n')

print('Repeticoes:', k)
print('Raiz (solucao):', xk)
print('Precisao:', abs(fx))
