# 2.4.4
import numpy as np

# Reading input
# Input format example:
# 374
# 60 100 130 10 200 5
# 10 30 20 5 40 20
# Where first line is the profit,
# second is the items' profits
# and third is the items' weights
p = int(input())
Ps = [int(p) for p in input().split()]
Ws = [int(w) for w in input().split()]
n = len(Ps)

# Create p/w ratio
Rs = []
for i in range(n):
	Rs.append(Ps[i] / Ws[i])

# Create tuple structure (item, profit, weight, ratio)
T = []
for i in range(n):
	 T.append([i, Ps[i], Ws[i], Rs[i]])

# Sort by ratio
T = sorted(T, key=lambda x: x[3], reverse=True)
curr_p = 0
items = np.zeros(n)

# Add the highest p/w item ratio taking into account the item profit
# in order to not surpass the desired input value
while curr_p < p:
	for i in range(n):
		item_p = T[i][1]
		if item_p != 0:
			item_p_frac = (p - curr_p) / item_p
			if item_p + curr_p <= p:
				curr_p += item_p
				items[T[i][0]] += 1
				# Item's profit is now 0 so that it's not selected more than once
				T[i][1] = 0
				break
			elif item_p_frac < 1:
				curr_p += item_p_frac * T[i][1]
				items[T[i][0]] += item_p_frac
				break
	else:
		break

# Output example:
# Item 0 was added 1.0 times.
# Item 1 was added 0.0 times.
# Item 2 was added 1.0 times.
# Item 3 was added 0.0 times.
# Item 4 was added 0.92 times.
# Item 5 was added 0.0 times.
for i in range(n):
	print(f'Item {i} was added {items[i]} times.')
