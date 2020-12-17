# Matheus Henrique Schaly
# Simulado 3 - Algoritmo de Strassen

# Numpy arrays are faster than lists
import numpy as np

# Algoritmo de Strassen
def strassen(X, Y):
	n = X.shape[0]
	n_2 = n // 2
	if n == 1: # Base Case
		return X * Y
	else: # Recursive Case
		A = X[0:n_2, 0:n_2]
		B = X[0:n_2, n_2:n]
		C = X[n_2:n, 0:n_2]
		D = X[n_2:n, n_2:n]
		E = Y[0:n_2, 0:n_2]
		F = Y[0:n_2, n_2:n]
		G = Y[n_2:n, 0:n_2]
		H = Y[n_2:n, n_2:n]
		M1 = strassen(A, (F - H))
		M2 = strassen((A + B), (H))
		M3 = strassen((C + D), (E))
		M4 = strassen(D, (G - E))
		M5 = strassen((A + D), (E + H))
		M6 = strassen((B - D), (G + H))
		M7 = strassen((A - C), (E + F))
		Z11 = M5 + M4 - M2 + M6
		Z12 = M1 + M2
		Z21 = M3 + M4
		Z22 = M1 + M5 - M3 - M7
		return np.vstack((np.hstack((Z11, Z12)), np.hstack((Z21, Z22))))

# Matrix size
n = int(input())

# Fill matrix A
X = np.empty(shape=(n, n))
for j in range(n):
	row = [int(x) for x in input().split()]
	X[j, :] = row

# Fill matrix B
Y = np.empty(shape=(n, n))
for j in range(n):
	row = [int(x) for x in input().split()]
	Y[j, :] = row

print(strassen(X, Y)) # Call Strassen and print answer
