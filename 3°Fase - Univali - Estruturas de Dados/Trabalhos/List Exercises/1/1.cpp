/*
 * 1.cpp
 *
 * Author:      Matheus Schaly
 * Created on:  Aug 29, 2017
 * Description: Faça uma rotina que a partir de uma lista simplesmente encadeada de
inteiros gere outra lista com os elementos armazenados nas posições
pares da referida lista.
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

void evenList(Node *node) {
	if (node -> next == NULL) {
		return;
	}
	else if (node -> next -> next == NULL) {
		node -> next = NULL;
		return;
	}
	node -> next = node -> next -> next;
	evenList(node -> next);
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
	evenList(head);
	temp = head;
	cout << endl;
	while (temp != NULL) {
		cout << temp -> data;
		temp = temp -> next;
	}

}



