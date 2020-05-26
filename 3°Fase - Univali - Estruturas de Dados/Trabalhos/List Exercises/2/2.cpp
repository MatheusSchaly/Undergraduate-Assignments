/*
 * 2.cpp
 *
 * Author:      Matheus Schaly
 * Created on:  Aug 29, 2017
 * Description: Elabore uma rotina que substitua todas as ocorrências de um
determinado elemento por outro elemento em uma lista simplesmente
encadeada de inteiros.
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

void replace(Node *node, int dataToBeReplaced, int dataToReplace) {
	if (node == NULL) {
		return;
	}
	if (node -> data == dataToBeReplaced) {
		node -> data = dataToReplace;
	}
	replace(node -> next, dataToBeReplaced, dataToReplace);
}

int main(int argc, char **argv) {
	pushFront(2);
	for (int i = 0; i < 8; i++) {
		pushFront(i);
	}
	for (int i = 0; i < 3; i++) {
		pushFront(2);
	}
	Node *temp = head;
	while (temp != NULL) {
		cout << temp -> data;
		temp = temp -> next;
	}
	cout << endl;
	temp = head;
	replace(head, 2, 4);
	while (temp != NULL) {
		cout << temp -> data;
		temp = temp -> next;
	}
}



