import itertools

# Entrada
# coefs_0 = [2, -3, -4, 0, 1, 1]
# coefs_0 = [1, -1, 8, -16, 7, -14]
coefs_0 = [1, -9, 27, -31, 12]

# Positivas
coefs_pos = [e for e in coefs_0 if e != 0]
pos = 0
for i in range(1, len(coefs_pos)):
    if (coefs_pos[i-1] > 0 and coefs_pos[i] < 0) or (coefs_pos[i-1] < 0 and coefs_pos[i] > 0):
        pos += 1
poss_pos = []
while pos >= 0:
    poss_pos.append(pos)
    pos -= 2
print('Positive coefficients:', coefs_pos)
print('Positive possibilities:', poss_pos)
print()

# Negativas
coefs_neg = []
for i in range(len(coefs_0)):
    if i % 2 == 0:
        coefs_neg.append(-coefs_0[i])
    else:
        coefs_neg.append(coefs_0[i])
coefs_neg = [e for e in coefs_neg if e != 0]
neg = 0
for i in range(1, len(coefs_neg)):
    if (coefs_neg[i-1] > 0 and coefs_neg[i] < 0) or (coefs_neg[i-1] < 0 and coefs_neg[i] > 0):
        neg += 1
poss_neg = []
while neg >= 0:
    poss_neg.append(neg)
    neg -= 2
print('Negative coefficients:', coefs_neg)
print('Negative possibilities:', poss_neg)
print()

# Nula
nula = [0]
if coefs_0[-1] == 0:
    nula = [1]
print('Nula:', nula)
print()

# Complexas
total_roots = len(coefs_0) - 1
poss = [poss_pos, poss_neg, nula]
poss = list(itertools.product(*poss))
poss = [list(p) for p in poss]
print('Possibilities without complex:', poss)
poss_com = []
for p in poss:
    com = total_roots - sum(p)
    temp = p
    temp.append(com)
    poss_com.append(temp)
print('\nResultado final:')
print('Possibilities with complexa:', poss_com)
