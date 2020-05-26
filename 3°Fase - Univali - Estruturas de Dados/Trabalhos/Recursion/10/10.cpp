/*
 * 10.cpp
 *
 * Author:      Matheus Schaly
 * Created on:  Aug 5, 2017 
 * Description: Escreva uma função recursiva para verificar se dois vetores X e Y de n (1 ≤ n ≤ 10)
elementos inteiros são iguais, ou seja, xi = yi, ∀ 1 ≤ i ≤ n.
 */

#include <iostream>
#include <vector>

using namespace std;

bool checkSameVector (vector<int> vecX, vector<int> vecY, unsigned int i = 0) {
	if (vecX.size() == i) {
		return true;
	}
	if (vecX.at(i) != vecY.at(i)) {
		return false;
	}
	return checkSameVector(vecX, vecY, i + 1);
}

int main(int argc, char **argv) {
	vector<int> vecX;
	vector<int> vecY;
	vecX.push_back(1);
	vecX.push_back(2);
	vecX.push_back(4);
	vecY.push_back(1);
	vecY.push_back(2);
	vecY.push_back(4);
	cout << checkSameVector (vecX, vecY);
}






