#include "Nodo.h"

        Nodo::Nodo(int elemento){
            this->elemento = elemento;
            this->proximo = NULL;
        }

        void Nodo::setaElemento(int elemento){
            this->elemento = elemento;
        }

        void Nodo::setaProximo(Nodo* nodo){
            this->proximo = nodo;
        }

        int Nodo::pegaElemento(){
            return this->elemento;
        }

        Nodo* Nodo::pegaProximo(){
            return this->proximo;
        }
