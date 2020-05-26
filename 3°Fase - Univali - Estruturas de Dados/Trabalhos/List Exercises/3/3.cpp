/*
 * 3.cpp
 *
 * Author:      Matheus Schaly
 * Created on:  Aug 29, 2017
 * Description: Escreva uma rotina que elimine todas as ocorrências de um elemento
em uma lista simplesmente encadeada de inteiros.
 */

using namespace std;

#include <iostream>

struct Node {
	int data;
	Node *next;
	Node(int data) {
		this -> data = data;
		next = NULL;
	}
};

Node *head;

void pushFront(int data) {
	Node *newNode = new Node(data);
	if (head == NULL) {
		head = newNode;
		return;
	}
	newNode -> next = head;
	head = newNode;
}

void remove(Node *node, int data) {
	if (node == NULL) {
		return;
	}
	if (node -> data == data) {

	}
}

int main(int argc, char **argv) {
	for (int i = 0; i < 8; i++) {
		pushFront(i);
	}
	Node *temp = head;
	while (temp != NULL) {
		cout << temp -> data;
		temp = temp -> next;
	}
	temp = head;
}
