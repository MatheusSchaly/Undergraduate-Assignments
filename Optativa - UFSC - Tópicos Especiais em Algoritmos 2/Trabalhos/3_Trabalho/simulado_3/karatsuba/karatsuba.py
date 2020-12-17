# Matheus Henrique Schaly
# Simulado 3 - Algoritmo de Karatsuba

def karatsuba(n, x, y):
	if n == 1:
		return x * y
	else:
		n2 = n // 2
		xe = x // 10**(n2)
		xd = x % 10**(n2)
		ye = y // 10**(n2)
		yd = y % 10**(n2)

		m1 = karatsuba(n2, xe,ye)
		m2 = karatsuba(n2, xd,yd)
		m3 = karatsuba(n2, (xe+xd),(ye+yd))

		return (10**n * m1) + (10**(n2) * (m3-m1-m2)) + m2

# Python suporta o tipo "bignum" que trabalha com valores arbitrariamente grandes
# Basta realizar operações aritméticas e qualquer número que exceda
# a fronteira de 32-bits será automaticamente convertido para "bignum".
# Exemplo de números com 9543 dígitos:
# x = 9 ** 10000
# y = 9 ** 10000
# n = len(str(x))

n = int(input())
x = int(input())
y = int(input())

print(karatsuba(n, x, y))
