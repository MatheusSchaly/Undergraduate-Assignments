/*
 * 7.cpp
 *
 * Author:      Matheus Schaly
 * Created on:  Aug 5, 2017 
 * Description: Escreva uma função recursiva para calcular o produto escalar entre dois vetores quaisquer
X [ x1, x2, ..., xn ] e Y [ y1, y2, ..., yn ], de tamanho n (1 ≤ n ≤ 10).
produto escalar = x1 * y1 + x2 * y2 + ... + xn * yn
 */

#include <iostream>
#include <vector>

using namespace std;

int dotProduct (vector<int> vectorX, vector<int> vectorY, int n) {
	if (n == 0) {
		return vectorX.at(n) * vectorY.at(n);
	}
	return (vectorX.at(n) * vectorY.at(n)) + dotProduct(vectorX, vectorY, n - 1);
}

int main(int argc, char **argv) {
	vector<int> vectorX;
	vector<int> vectorY;

	vectorX.push_back(0);
	vectorX.push_back(1);
	vectorX.push_back(2);
	vectorX.push_back(3);
	vectorX.push_back(10);

	vectorY.push_back(1);
	vectorY.push_back(2);
	vectorY.push_back(3);
	vectorY.push_back(4);
	vectorY.push_back(20);

	cout << dotProduct(vectorX, vectorY, 4);
}



