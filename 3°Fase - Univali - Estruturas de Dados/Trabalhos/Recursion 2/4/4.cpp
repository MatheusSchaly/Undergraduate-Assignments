/*
 * 4.cpp
 *
 * Author:      Matheus Schaly
 * Created on:  Aug 10, 2017 
 * Description: Escreva	um	procedimento	recursivo	que	para	um	determinado	valor	n	(1	≤	n	≤	9),	desenhe
um	losango	como	o	apresentado	abaixo	(neste	exemplo,	n	=	3).
   1
  121
 12321
  121
   1
 */

#include <iostream>
#include <cmath>

using namespace std;

void diamondDraw (int n, int space = 0, int space2 = 1) {
	if (n > 0 && space2 < 2) {
		diamondDraw(n-1, space+1);
		for (int i = 0; i < space; i++) {
			cout << " ";
		}
		for (int i = 1; i < n; i++) {
			cout << i;
		}
		for (int i = n; i > 0; i--) {
			cout << i;
		}
		for (int i = 0; i < space; i++) {
			cout << " ";
		}
		cout << endl;
	}
	if (space == 0) {
		if (n == 1) {
			return;
		}
		n--;
		for (int i = 0; i < space2; i++) {
			cout << " ";
		}
		for (int i = 1; i < n; i++) {
			cout << i;
		}
		for (int i = n; i > 0; i--) {
			cout << i;
		}
		for (int i = 0; i < space2; i++) {
			cout << " ";
		}
		cout << endl;
		diamondDraw(n, 0, space2+1);
	}
}

int main(int argc, char **argv) {
	diamondDraw(2);
}
