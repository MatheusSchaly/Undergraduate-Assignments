/*
 * 1.cpp
 *
 * Author:      Matheus Schaly
 * Created on:  Aug 1, 2017
 * Description: A série de Fibonacci é 0, 1, 1, 2, 3, 5, 8, 13, 21, ... Os primeiros dois termos são 0 e 1; cada
termo subseqüente é calculado como a soma dos dois últimos termos. Assim, ti = ti-1 + ti-2.
Elabore uma função recursiva para determinar o valor do enésimo termo da série.
 */

#include <iostream>

using namespace std;

int Fibonacci(int x) {
	if (x == 1) {
		return 0;
	}
	if (x == 2) {
		return 1;
	}
	return Fibonacci(x - 1) + Fibonacci(x - 2);
}

int main(int argc, char **argv) {
	cout << "Fibonacci: " << Fibonacci(8) << endl;
}



