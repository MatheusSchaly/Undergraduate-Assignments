/*
 * 5.cpp
 *
 * Author:      Matheus Schaly
 * Created on:  Aug 1, 2017 
 * Description: Construa um procedimento recursivo para escrever os n primeiros termos da série
1 4 3 16 5 36 7 64 9 100 ...
 */

#include <iostream>

using namespace std;

void series (int n) {
	if (n == 0) {
		return;
	}
	series(n-1);
	if (n % 2 != 0) {
		cout << n << " ";
	} else {
		cout << n*n << " ";
	}
}

void series2 (int n) {
	if (n != 0) {
		series2(n - 1);
		if (n % 2 == 0) {
			cout << n * n << " ";
		}
		else {
			cout << n << " ";
		}
	}
}

int main(int argc, char **argv) {
	series(10);
	cout << endl;
	series2(10);
}

