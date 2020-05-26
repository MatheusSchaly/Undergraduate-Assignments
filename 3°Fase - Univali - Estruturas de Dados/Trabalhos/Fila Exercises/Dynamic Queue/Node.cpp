#include "Node.h"

Node::Node(int data) {
    this -> data = data;
    next = NULL;
}

void Node::setData(int data) {
    this -> data = data;
}

int Node::getData() {
    return data;
}

void Node::setNext(Node *next) {
    this -> next = next;
}

Node* Node::getNext() {
    return next;
}
