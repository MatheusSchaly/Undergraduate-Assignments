/*
 * 3.cpp
 *
 * Author:      Matheus Schaly
 * Created on:  Aug 10, 2017 
 * Description: Construa	um	procedimento	recursivo	para	gerar	uma	matriz	quadrada	A	de	ordem	n	(1	≤	n	≤
10),	onde	a ij 	=	i,	∀	1	≤	i,	j	≤	n.
 */

#include <iostream>
#include <vector>

using namespace std;

void matrixGeneratorAux (vector<vector<int> > &A, int n, unsigned int i) {
	if (i == A.size()) {
		return;
	}
	matrixGeneratorAux (A, n, i + 1);
	A[n - 1][i] = n-1;
}

void matrixGenerator (vector<vector<int> > &A, int n, int i = -1) {
	if (n == 0) {
		return;
	}
	matrixGenerator (A, n - 1);
	matrixGeneratorAux (A, n, i + 1);
}

int main(int argc, char **argv) {
	int n = 4;
	vector<vector<int> > A(n, vector<int>(n));
	matrixGenerator(A, A.size());
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < n; j++) {
			cout << A[i][j] << " ";
		}
		cout << endl;
	}
}


