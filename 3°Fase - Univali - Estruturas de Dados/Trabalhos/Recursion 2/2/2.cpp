/*
 * 2.cpp
 *
 * Author:      Matheus Schaly
 * Created on:  Aug 9, 2017 
 * Description: Desenvolva uma função recursiva para contar o número de caracteres iguais que se
encontram em posições consecutivas de uma linha qualquer de uma matriz Anxn (1 ≤ n ≤ 10).
 */

#include <iostream>
#include <vector>

using namespace std;

int consecutiveCharCount (vector<vector<char> > charMatrix, int row, unsigned int i = 0) {
	if (i == charMatrix.size()) {
		return 0;
	}
	int sum = 0;
	if (charMatrix[row][i] == charMatrix[row][i + 1]) {
		sum++;
	}
	return sum + consecutiveCharCount (charMatrix, row, i + 1);
}

int main(int argc, char **argv) {
	vector<vector<char> > charMatrix(6, vector<char>(6));
	charMatrix[0][0] = 'b';
	charMatrix[0][1] = 'a';
	charMatrix[0][2] = 'c';
	charMatrix[0][3] = 'b';
	charMatrix[0][4] = 'b';
	charMatrix[0][5] = 'b';
	charMatrix[1][0] = 'c';
	charMatrix[1][1] = 'c';
	charMatrix[1][2] = 'b';
	charMatrix[1][3] = 'c';
	charMatrix[1][4] = 'c';
	charMatrix[1][5] = 'c';
	charMatrix[2][0] = 'c';
	charMatrix[2][1] = 'd';
	charMatrix[2][2] = 'd';
	charMatrix[2][3] = 'd';
	charMatrix[2][4] = 'c';
	charMatrix[2][5] = 'c';
	for (unsigned int i = 0; i < 3; i++) {
		for (unsigned int j = 0; j < 6; j++) {
			cout << charMatrix[i][j] << " ";
		}
		cout << endl;
	}
	cout << consecutiveCharCount(charMatrix, 2);
}


