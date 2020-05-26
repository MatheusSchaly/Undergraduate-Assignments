#include "Nodo.h"

template <class T>
Nodo<T>::Nodo(T data, Nodo* next) {
    this -> data = data;
    this -> next = next;
}

template <class T>
Nodo<T>* Nodo<T>::getNext() {
    return next;
}

template <class T>
void Nodo<T>::setNext(Nodo<T>* next) {
    this -> next = next;
}

template <class T>
T Nodo<T>::getData() {
    return data;
}

//template class Nodo<float>;
//template class Nodo<string>;
//template class Nodo<int>;
//template class Nodo<Carta>;
