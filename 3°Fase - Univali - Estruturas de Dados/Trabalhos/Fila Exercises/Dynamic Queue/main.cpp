#include <iostream>
#include "Queue.h"
#include "Node.h"

using namespace std;

int main()
{
    Queue myQueue;
    myQueue.push(10);
    myQueue.push(20);
    cout << "First: " << myQueue.getFirst() << endl; // 10
    cout << "Last: " << myQueue.getLast() << endl << endl; // 20
    cout << "First index: " << myQueue.getIndex(10) << endl; // 0
    cout << "Second index: " << myQueue.getIndex(20) << endl; // 1
    myQueue.print(); // 10 20
    myQueue.pop();
    myQueue.print(); // 10
    myQueue.pop();
    myQueue.print(); //

}
