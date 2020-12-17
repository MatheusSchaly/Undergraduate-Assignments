# 2.4.3
import numpy as np

# Reading input
# 8
# 1 2 5 6
# 2 3 4 5
# Where first line is the weight,
# second is the items' profits
# and third is the items' weights

w = int(input())
Ps = [int(p) for p in input().split()]
Ws = [int(w) for w in input().split()]
n = len(Ps)

# To make the code more readable
Ps.insert(0, 0)
Ws.insert(0, 0)

# To make the code faster
Ps = np.array(Ps)
Ws = np.array(Ws)

T = np.zeros((n+1, w+1))

# Build matrix T
for i in range(n+1):
	for j in range(w+1):
		if i == 0 or w == 0:
			T[i, j] = 0
		# If it's worth to add one more item or to
		# leave the itens we had before
		elif Ws[i] <= j:
			T[i, j] = max(Ps[i] + T[i-1, j-Ws[i]], T[i-1, j])
		# Keep the item we had before
		else:
			T[i, j] = T[i-1, j]

# Output example:
# 8.0
# Where 8.0 is the optimal knapsack value given the inputs
print(T[-1][-1])
