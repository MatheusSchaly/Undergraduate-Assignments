/*
 * 8.cpp
 *
 * Author:      Matheus Schaly
 * Created on:  Aug 5, 2017 
 * Description: Faça uma função recursiva que, a partir de uma cadeia de caracteres qualquer, retorne a
cadeia de caracteres na ordem inversa dos caracteres que a compõem.
 */

#include <iostream>
#include <vector>

using namespace std;

vector<char> reverseCharacters (vector<char> sequence, unsigned int i = 0) {
	if (i != sequence.size()) {
		char myChar = sequence[i];
		int aux = sequence.size() - 1 - i;
		sequence = reverseCharacters(sequence, i + 1);
		sequence[aux] = myChar;
	}
	return sequence;
}

int main(int argc, char **argv) {
	vector<char> sequence;
	sequence.push_back('a');
	sequence.push_back('b');
	sequence.push_back('c');
	sequence.push_back('d');
	sequence.push_back('e');
	vector<char> reversed = reverseCharacters(sequence);
	for (vector<char>::iterator it = reversed.begin(); it != reversed.end(); it++) {
		cout << *it << " ";
	}
}



