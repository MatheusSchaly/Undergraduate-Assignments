a = [1, -5, 6]
n = len(a)
x = 3
m = 1
for k in range(1, n-1):
	b = [0] * n
	print(b)
	s = 0
	j = 0
	for i in range(n, 0, -1):
		print(i)
		j += 1
		b[j] = i * a[j]
		s = s + (b[j] * x ** (i - 1))
	a = b
	if s == 0:
		m += 1
print(m)
