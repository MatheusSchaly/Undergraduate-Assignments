#ifndef LISTA_H_INCLUDED
#define LISTA_H_INCLUDED

#include "Nodo.h"

class Lista {
    private:
        int numeroElementos;
        Nodo* inicio;
    public:
        Lista();
        ~Lista();
        bool ehVazia();
        int numeroDeElementos();
        bool existeElemento(int elemento);
        int umElemento(int posicao);
        int posicao(int elemento);
        void insere(int elemento, int posicao);
        void retira(int posicao);
        void mostra();
};

#endif // LISTA_H_INCLUDED
