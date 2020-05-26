/*
 * 1.cpp
 *
 * Author:      Matheus Schaly
 * Created on:  Aug 8, 2017 
 * Description: Escreva uma função recursiva para calcular o valor do co-seno de um ângulo em radianos,
considerando os n primeiros termos da série
co-seno = 1 - x2 + x4 - x6 + x8 - ....
2! 4! 6! 8!
 */

#include <iostream>
#include <math.h>

using namespace std;

int factorial (int n) {
	for (int i = n - 1; i > 1; i--) {
		n *= i;
	}
	return n;
}

double angleToRadians (int n, int x) {
	n--;
	if (n == 0) {
		return 1;
	}
	if (n * 2 % 4 == 0) {
		return pow (x, n * 2) / factorial(n * 2) + angleToRadians (n, x);
	}
	else {
		return -pow (x, n * 2) / factorial(n * 2) + angleToRadians (n, x);
	}
}

int main(int argc, char **argv) {
	cout << angleToRadians(3, 2);
}
