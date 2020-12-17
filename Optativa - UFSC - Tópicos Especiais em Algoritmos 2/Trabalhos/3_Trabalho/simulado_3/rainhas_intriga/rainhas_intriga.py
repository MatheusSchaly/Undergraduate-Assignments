# Matheus Henrique Schaly
# Simulado 3 - Rainhas Amigas com uma Intriga

def queens(A, l):
	global q
	global solucoes
	global l_intriga
	if l == q:
		solucoes.append(A[:])
		if l_intriga != l-1: # para nao resetar a intriga
			A[l-1] = -1
	else:
		for c in range(q): # colunas
			if l_intriga == l: # para não avaliar a linha da intriga
				queens(A, l+1)
				break
			candidata = True
			for i in range(q): # linhas
				if A[i] != -1:
					if A[i] == c: # mesma coluna
						candidata = False
						break
					if A[i]-i == c-l: # mesma diagonal direita
						candidata = False
						break
					if A[i]+i == c+l: # mesma diagonal esquerda
						candidata = False
						break
			if candidata: # para continuar colocando uma rainha nesta linha
				A[l] = c
				queens(A, l+1)
			if c == q-1: # para continuar não colocando uma rainha nesta linha
				queens(A, l+1)
		if l_intriga != l-1: # para nao resetar a intriga
			A[l-1] = -1


q = int(input())
intriga_amigas = []

for l_intriga in range(q):
	for c_intriga in range(q):
		A = [-1] * q
		A[l_intriga] = c_intriga
		solucoes = []
		queens(A, 0)
		intriga_amigas.append((l_intriga+1, c_intriga+1, len(solucoes))) # +1 pois posicao Python

intriga_amigas_min = []
intriga_amigas = sorted(intriga_amigas, key=lambda x: x[2]) # menores para frente
min = intriga_amigas[0][2]
for intriga_amiga in intriga_amigas:
	if intriga_amiga[2] == min:
		intriga_amigas_min.append((intriga_amiga[0], intriga_amiga[1]))

[print(intriga_amiga_min) for intriga_amiga_min in intriga_amigas_min]
