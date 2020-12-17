from math import sin, cos, e, sqrt

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
	print(f'K: {k}'.ljust(8, ' '), end='')
	print(f'x0: {round(x0, 20)}'.ljust(30, ' '), end='')
	print(f'xk: {round(xk, 20)}'.ljust(30, ' '), end='')
	print(f'|xk-x0|: {round(abs(xk-x0), 20)}'.ljust(30, ' '))
	x0 = xk
	k += 1
	fx = f(x0)
	dfx = d(x0)

print('Repeticoes:', k)
print('Raiz (solucao):', xk)
print('Precisao:', abs(fx))
