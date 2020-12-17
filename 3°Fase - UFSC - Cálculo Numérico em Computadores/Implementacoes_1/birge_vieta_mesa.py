# Entradas
a = [1, 2, -1, -2]
x0 = 2
erro = 10**-6

n = len(a)
b = [0] * n
c = [0] * (n-1)
b[0] = a[0]
c[0] = b[0]
R = 1
k = 0
while (abs(R) > erro):
    print(f'K: {k}'.ljust(8, ' '), end='')
    k += 1
    for i in range(1, n-1):
        b[i] = b[i-1] * x0 + a[i]
        c[i] = c[i-1] * x0 + b[i]
    b[i+1] = b[i] * x0 + a[i+1]
    R = b[-1]
    R1 = c[-1]
    xk = x0 - (R/R1)
    x0 = xk
    print(f'b: {[round(b_aux, 3) for b_aux in b]}'.ljust(30, ' '), end='')
    print(f'c: {[round(c_aux, 3) for c_aux in c]}'.ljust(25, ' '), end='')
    print(f'R: {round(R, 20)}'.ljust(27, ' '), end='')
    print(f'R1: {round(R1, 20)}'.ljust(27, ' '), end='')
    print(f'xk: {round(xk, 20)}'.ljust(27, ' '), end='')
    print(f'x0: {round(x0, 20)}'.ljust(27, ' '))

print('Repeticoes:', k)
print('Raiz (solucao):', xk)
print('Precisao:', abs(R))
