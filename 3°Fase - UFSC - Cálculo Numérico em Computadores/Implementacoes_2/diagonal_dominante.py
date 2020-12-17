import numpy as np

a = np.array([[4, 1, 2],
			  [1, 2, 1],
			  [1, 0.1, 1.1]], dtype=float)

for i in range(len(a)):
	sum = 0
	for j in range(len(a[i])):
		if i != j:
			sum += abs(a[i, j])
	if abs(a[i, i]) < sum:
		print(f'NÃO É DOMINANTE pois na linha de posição {i+1} o valor (absoluto) da diagonal é {a[i,i]} e a soma (absoluta) é {sum}')
