/*
 * 2.cpp
 *
 * Author:      Matheus Schaly
 * Created on:  Aug 1, 2017 
 * Description: Desenvolva uma função recursiva para calcular a soma dos números naturais de 1 a n.
 */

#include <iostream>

using namespace std;

int somaNaturais (int x) {
	if (x == 1) {
		return 1;
	}
	return x + somaNaturais(x - 1);
}

void somaNaturaisReferencia1 (int n, int *resultado) {
	if (n == 1) {
		*resultado = 1;
		return;
	}
	somaNaturaisReferencia1(n - 1, resultado);
	*resultado += n;
}

void somaNaturaisReferencia2 (int n, int &resultado) {
	if (n != 0) {
		somaNaturaisReferencia2(n - 1, resultado);
		resultado += n;
	}
}
int main(int argc, char **argv) {
	int resultado1 = 0, resultado2 = 0;
	cout << "somaNaturais: " << somaNaturais(5) << endl;
	somaNaturaisReferencia1(5 , &resultado1);
	cout << "somaNaturaisReferencia1: " << resultado1 << endl;
	somaNaturaisReferencia2(5, resultado2);
	cout << "somaNaturaisReferencia2: " << resultado2 << endl;

}



