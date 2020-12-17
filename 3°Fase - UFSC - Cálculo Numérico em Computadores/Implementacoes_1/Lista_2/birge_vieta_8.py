# Entradas
a = [1, -4, 6, -4, 0.5]
x0 = 0
erro = 10**-6

n = len(a)
b = [0] * n
c = [0] * (n-1)
b[0] = a[0]
c[0] = b[0]
R = 1
k = 0
while (abs(R) > erro):
    k += 1
    for i in range(1, n-1):
        b[i] = b[i-1] * x0 + a[i]
        c[i] = c[i-1] * x0 + b[i]
    b[i+1] = b[i] * x0 + a[i+1]
    R = b[-1]
    R1 = c[-1]
    xk = x0 - (R/R1)
    x0 = xk

print('Repeticoes:', k)
print('Raiz (solucao):', xk)
print('Precisao:', abs(R))
