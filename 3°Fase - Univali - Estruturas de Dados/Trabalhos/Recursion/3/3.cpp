/*
 * 3.cpp
 *
 * Author:      Matheus Schaly
 * Created on:  Aug 1, 2017 
 * Description: Escreva uma função recursiva para calcular a soma dos múltiplos de 5 entre 0 e 1000.
 */

#include <iostream>

using namespace std;

int cont = 0;

int somaMultiplos5 (int x) {
	cont++;
	if (x == 0) {
		return x;
	}
	return x + somaMultiplos5(x - 5);
}

int main(int argc, char **argv) {
	cout << "Multiplos: " << somaMultiplos5(15) << endl;
	cout << "Cont: " << cont << endl;
}



