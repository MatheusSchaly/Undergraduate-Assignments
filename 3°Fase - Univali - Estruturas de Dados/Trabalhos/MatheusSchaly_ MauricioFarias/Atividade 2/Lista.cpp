#include "Lista.h"

template <class T>
Lista<T>::Lista() {
    head = NULL;
    tail = NULL;
    tamanho = 0;
}

template <class T>
Lista<T>::~Lista() {
    Nodo<T> *temp = getHead();
    for (int i = 0; i < getTamanho(); i++) {
        setHead(getHead() -> getNext());
        delete temp;
        temp = getHead();
    }
}

template <class T>
bool Lista<T>::verificaElemento(T elemento) {
    Nodo<T> *temp = getHead();
    for (int i = 0; i < getTamanho(); i++) {
        T aux = temp->getData();
        if (aux == elemento) {
            return true;
        }
        temp = temp -> getNext();
    }
    return false;
}

template <class T>
void Lista<T>::insereElemento(T elemento, int posicao) {
    if (getTamanho() == 0) {
        Nodo<T> *novoNodo = new Nodo<T>(elemento);
        novoNodo -> setNext(novoNodo);
        setTail(novoNodo);
        setHead(novoNodo);
        aumentaTamanho();
        return;
    }
    if (posicao == 1 || posicao == getTamanho() + 1) {
        Nodo<T> *novoNodo = new Nodo<T>(elemento, getHead());
        getTail() -> setNext(novoNodo);
        if (posicao == 1) {
            setHead(novoNodo);
        }
        else {
            setTail(novoNodo);
        }
        aumentaTamanho();
        return;
    }
    Nodo<T> *temp = head;
    for (int i = 0; i < posicao - 2; i++) {
        temp = temp -> getNext();
    }
    Nodo<T> *novoNodo = new Nodo<T>(elemento, temp -> getNext());
    temp -> setNext(novoNodo);
    aumentaTamanho();
}

template <class T>
void Lista<T>::removeElemento(int posicao) {
    if (getTamanho() == 1) {
        delete getHead();
        setHead(NULL);
        setTail(NULL);
        diminuiTamanho();
        return;
    }
    if (posicao == 1) {
        tail -> setNext(getHead() -> getNext());
        delete getHead();
        setHead(getTail() -> getNext());
        diminuiTamanho();
        return;
    }
    Nodo<T> *temp = getHead();
    if (posicao == getTamanho()) {
        for (int i = 0; i < getTamanho() - 2; i++) {
            temp = temp -> getNext();
        }
        temp -> setNext(getHead());
        delete getTail();
        setTail(temp);
        diminuiTamanho();
        return;
    }
    Nodo<T> *prev;
    for (int i = 0; i < posicao - 1; i++) {
        prev = temp;
        temp = temp -> getNext();
    }
    prev -> setNext(temp -> getNext());
    setHead(prev);
    delete temp;
    diminuiTamanho();
}

template <class T>
void Lista<T>::mostraLista() {
    Nodo<T> *temp = getHead();
    for (int i = 0; i < getTamanho(); i++) {
        T test = temp->getData();
        cout << test << " ";
        temp = temp -> getNext();
    }
}

template <class T>
void Lista<T>::aumentaTamanho() {
    tamanho++;
}

template <class T>
void Lista<T>::diminuiTamanho() {
    tamanho--;
}

template <class T>
Nodo<T>* Lista<T>::getHead() {
    return head;
}

template <class T>
void Lista<T>::setHead(Nodo<T>* head) {
    this -> head = head;
}

template <class T>
Nodo<T>* Lista<T>::getTail() {
    return tail;
}

template <class T>
void Lista<T>::setTail(Nodo<T>* tail) {
    this -> tail = tail;
}

template <class T>
int Lista<T>::getTamanho() {
    return tamanho;
}

template <class T>
T Lista<T>::getElemento(int posicao)
{
    Nodo<T>* temp = getHead();
    for (int i=1;i<posicao;i++)
    {
        temp = temp->getNext();
    }
    return temp->getData();
}

//template class Lista<int>;
//template class Lista<float>;
//template class Lista<string>;
//template class Lista<Carta>;
