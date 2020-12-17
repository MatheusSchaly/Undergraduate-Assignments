# -*- coding: utf-8 -*-
import numpy as np

# Reading input
w = int(input())
Ps = [int(p) for p in input().split()]
Ws = [int(w) for w in input().split()]
n = len(Ps)

# To make the code faster
Ps = np.array(Ps)
Ws = np.array(Ws)

T = np.zeros(w+1)

# Build vector T
for i in range(w+1):
	for j in range(n):
		# If we can insert the item
		if (Ws[j] <= i):
			# Keep the item with max profit which is either
			# the previous item (with lower weight) or the
			# current item (with heigher weight)
			T[i] = max(T[i], T[i - Ws[j]] + Ps[j])

print(Ps)
print(Ws)
print(T)
print('Max profit:', T[-1])
