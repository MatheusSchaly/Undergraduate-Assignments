#include "Nodo.h"

template<class T>
Nodo<T>::Nodo(T elemento)
{
    this->elemento = elemento;
    this->subArvoreEsquerda = this->subArvoreDireita = NULL;
}

template<class T>
T Nodo<T>::retornaElemento()
{
    return this->elemento;
}

template<class T>
Nodo<T>* Nodo<T>::retornaSubArvoreEsquerda()
{
    return this->subArvoreEsquerda;
}

template<class T>
Nodo<T>* Nodo<T>::retornaSubArvoreDireita()
{
    return this->subArvoreDireita;
}

template<class T>
void Nodo<T>::setaSubArvoreEsquerda(Nodo<T>* subArvoreEsquerda)
{
    this->subArvoreEsquerda = subArvoreEsquerda;
}

template<class T>
void Nodo<T>::setaSubArvoreDireita(Nodo<T>* subArvoreDireita)
{
    this->subArvoreDireita = subArvoreDireita;
}
