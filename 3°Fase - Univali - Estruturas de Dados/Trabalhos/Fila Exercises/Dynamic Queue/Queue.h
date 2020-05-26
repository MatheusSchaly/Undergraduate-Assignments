#ifndef QUEUE_H_INCLUDED
#define QUEUE_H_INCLUDED

#include "Node.h"

class Queue {
    Node *head, *tail;
    int queueSize;
public:
    Queue();
    ~Queue();
    bool isEmpty();
    int getSize();
    bool dataExistence(int data);
    int getData(int index);
    int getIndex(int data);
    int getFirst();
    int getLast();
    void push(int data);
    void pop();
    void print();
};


#endif // QUEUE_H_INCLUDED
