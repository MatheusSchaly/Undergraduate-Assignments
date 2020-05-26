/*
 * 4.cpp
 *
 * Author:      Matheus Schaly
 * Created on:  Aug 1, 2017 
 * Description: Elabore um procedimento recursivo que leia uma palavra, caracter por caracter, e escreva
a palavra lida na ordem inversa de seus caracteres. Admita o caracter asterisco como flag
para encerrar a leitura, o qual não deverá ser considerado.
 */

#include <iostream>
#include <ncurses.h>

using namespace std;

string inversao (string palavra) {
	if (palavra.at(palavra.length() - 1) == '*') {
		return "";
	}
	string ultimo(1, palavra[palavra.length() - 1]);
	string invertido = inversao(palavra.substr(0, palavra.length() - 1));
	return ultimo + invertido;
}


void inversao2 () {
	char letra;
	letra = cin.get();
	if (letra != '*') {
		inversao2();
	}
	else {
		return;
	}
	cout << letra;
}

void inversao3 () {
	char letra;
	cin >> letra;
	if (letra != '*') {
		inversao3();
		cout << letra;
	}
}

int main(int argc, char **argv) {
	string palavraInvertida = inversao("*hello");
	cout << "inversao: " << palavraInvertida << endl;
	inversao2();
	inversao3();
}


