/*
 * 9.cpp
 *
 * Author:      Matheus Schaly
 * Created on:  Aug 5, 2017 
 * Description: Construa um procedimento recursivo para verificar a existência de determinado valor y
em um vetor X de n (1 ≤ n ≤ 10) elementos inteiros.
 */

#include <iostream>
#include <vector>

using namespace std;

void findX (vector<int> myVector, int y, unsigned int i = 0) {
	if (i == myVector.size()) {
		cout << "Y was not found";
		return;
	}
	if (myVector.at(i) == y) {
		cout << "Y is at index " << i;
		return;
	}
	findX(myVector, y, i + 1);
}

int main(int argc, char **argv) {
	vector<int> myVector;
	myVector.push_back(1);
	myVector.push_back(2);
	myVector.push_back(3);
	myVector.push_back(4);
	findX(myVector, 2);
}

