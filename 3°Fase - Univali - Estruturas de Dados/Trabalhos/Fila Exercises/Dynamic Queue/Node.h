#ifndef NODE_H_INCLUDED
#define NODE_H_INCLUDED

#include <iostream>

using namespace std;

class Node {
    int data;
    Node *next;
public:
    Node(int data);
    void setData(int data);
    int getData();
    void setNext(Node *node);
    Node* getNext();
};


#endif // NODE_H_INCLUDED
