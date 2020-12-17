# 2.4.1
import numpy as np

# Input format example:
# 103
# 10 100 20 1
# 5 40 15 2
# Where first line is the weight,
# second is the items' profits
# and third is the items' weights

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

# Output example:
# 241.0
# Where 241.0 is the optimal knapsack value given the inputs
print(T[-1])
