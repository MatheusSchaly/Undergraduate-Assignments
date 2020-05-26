/*
 * 6.cpp
 *
 * Author:      Matheus Schaly
 * Created on:  Aug 5, 2017 
 * Description: Escreva uma função recursiva que calcule o valor do polinômio
pn(x) = anx^n + an-1x^n-1 + an-2x^n-2 + ... + a1x + a0
7.
 */

#include <iostream>
#include <math.h>

using namespace std;

int cont = 0;

int polinomialSum (int degree, int x, int *values) {
	if (degree == 0) {
		return values[degree];
	}
	return polinomialSum (degree - 1, x, values) + values[degree] * pow (x, degree);
}

int main(int argc, char **argv) {
	int degree = 2;
	int x = 2;
	int values[3] = {1, 2, 3};
	cout << polinomialSum (degree, x, values) << endl;
}



