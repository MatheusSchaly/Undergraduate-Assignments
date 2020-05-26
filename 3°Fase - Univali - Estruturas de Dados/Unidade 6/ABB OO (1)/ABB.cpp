#include "Nodo.cpp"
#include "ABB.h"

using namespace std;

template<class T>
ABB<T>::ABB()
{
    this->raiz = NULL;
}

template<class T>
ABB<T>::~ABB()
{
    destroi(this->raiz);
}

template<class T>
void ABB<T>::destroi(Nodo<T>* raiz)
{
    if (raiz != NULL)
    {
        destroi(raiz->retornaSubArvoreEsquerda());
        destroi(raiz->retornaSubArvoreDireita());
        delete raiz;
        raiz = NULL;
    }
}

template<class T>
bool ABB<T>::ehVazia()
{
    return this->raiz == NULL;
}

template<class T>
bool ABB<T>::existeElemento(T elemento)
{
    Nodo<T>* nodo = this->raiz;
    while (nodo != NULL)
        if (nodo->retornaElemento() == elemento)
            return true;
        else
        {
            if (elemento < nodo->retornaElemento())
                nodo = nodo->retornaSubArvoreEsquerda();
            else
                nodo = nodo->retornaSubArvoreDireita();
        }
    return false;
}

template<class T>
void ABB<T>::insere(T elemento)
{

    Nodo<T>* novoNodo = new Nodo<T>(elemento);

    if (this->raiz == NULL)
        this->raiz = novoNodo;
    else
    {
        Nodo<T>* nodoAnterior;
        Nodo<T>* nodoAtual = this->raiz;
        while (nodoAtual != NULL)
        {
            nodoAnterior = nodoAtual;
            if (elemento < nodoAtual->retornaElemento())
            {
                nodoAtual = nodoAtual->retornaSubArvoreEsquerda();
                if (nodoAtual == NULL)
                {
                    nodoAnterior->setaSubArvoreEsquerda(novoNodo);
                    return;
                }
            }
            else
            {
                nodoAtual = nodoAtual->retornaSubArvoreDireita();
                if (nodoAtual == NULL)
                {
                    nodoAnterior->setaSubArvoreDireita(novoNodo);
                    return;
                }
            }
        }
    }
}

template<class T>
void ABB<T>::retira(T elemento)
{
    retira(this->raiz, elemento);
}

template<class T>
void ABB<T>::retira(Nodo<T>* raiz, T elemento)
{
    // IMPLEMENTAR
}

template<class T>
void ABB<T>::mostra()
{
    mostra(this->raiz);
}

template<class T>
void ABB<T>::mostra(Nodo<T>* raiz)
{
    if (raiz != NULL)
    {
        mostra(raiz->retornaSubArvoreEsquerda());
        cout << raiz->retornaElemento() << "  ";
        mostra(raiz->retornaSubArvoreDireita());
    }
}
