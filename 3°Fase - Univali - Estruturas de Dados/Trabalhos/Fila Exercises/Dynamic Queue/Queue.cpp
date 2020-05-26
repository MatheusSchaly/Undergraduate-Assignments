#include "Queue.h"

Queue::Queue() {
    head = NULL;
    tail = NULL;
    queueSize = 0;
}

Queue::~Queue() {
    Node *temp;
    while (head != NULL) {
        temp = head -> getNext();
        delete head;
        head = temp;
    }
}

bool Queue::isEmpty() {
    return head == NULL;
}

int Queue::getSize() {
    return queueSize;
}

bool Queue::dataExistence(int data) {
    Node *temp = head;
    while (temp != NULL) {
        if (temp -> getData() == data) {
            return true;
        }
        temp = temp -> getNext();
    }
    return false;
}

int Queue::getData(int index) {
    Node *temp = head;
    for (int i = 0; i < index; i++) {
        temp = temp -> getNext();
    }
    return temp -> getData();
}

int Queue::getIndex(int data) {
    Node *temp = head;
    for (int i = 0; i < queueSize; i++) {
        if (temp -> getData() == data) {
            return i;
        }
        temp = temp -> getNext();
    }
    return -1;
}

int Queue::getFirst() {
    return head -> getData();
}

int Queue::getLast() {
    return tail -> getData();
}

void Queue::push(int data) {
    queueSize++;
    Node *newNode = new Node(data);
    if (head == NULL) {
        head = newNode;
        tail = newNode;
        return;
    }
    tail -> setNext(newNode);
    tail = newNode;
}

void Queue::pop() {
    queueSize--;
    Node *temp = head;
    if (head == tail) {
        head = NULL;
        tail = NULL;
        delete temp;
        return;
    }
    head = head -> getNext();
    delete temp;
}

void Queue::print() {
    Node *temp = head;
    cout << endl;
    while (temp != NULL) {
        cout << temp -> getData() << " ";
        temp = temp -> getNext();
    }
}
