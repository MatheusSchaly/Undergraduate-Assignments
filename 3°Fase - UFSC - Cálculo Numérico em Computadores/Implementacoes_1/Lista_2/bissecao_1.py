from math import exp, sin

def f(x):
    # return exp(x) * sin(x) - 1
    return x**2 - 5

a = -98
b = 102
fa = f(a)
fb = f(b)
erro = 10**-6
fxm = 1
k = 0

while (abs(fxm) > erro):
    xm = (a + b) / 2
    fxm = f(xm)
    print(f'k: {round(k, 4)}\ta: {round(a, 4)}\txm: {round(xm, 4)}\tb:\
          {round(b, 4)}\tfa: {round(fa, 4)}\tfxm: {round(fxm, 4)}\tfb: {round(fb, 4)}\n')
    k += 1
    if fa * fxm < 0:
        b = xm
        fb = fxm
    else:
        a = xm
        fa = fxm

print(f'k: {round(k, 4)}\ta: {round(a, 4)}\txm: {round(xm, 4)}\tb:\
      {round(b, 4)}\tfa: {round(fa, 4)}\tfxm: {round(fxm, 4)}\tfb: {round(fb, 4)}\n')

print('Repeticoes:', k)
print('Raiz (solucao):', xm)
print('Precisao:', abs(fxm))
