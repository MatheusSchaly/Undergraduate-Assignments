#include "Lista.h"
#include "Nodo.cpp"

using namespace std;

        Lista::Lista(){
            this->numeroElementos = 0;
            this->inicio = NULL;
        }

        Lista::~Lista(){
            Nodo* nodo;

            while(this->inicio != NULL){
                nodo = this->inicio;
                this->inicio = this->inicio->pegaProximo();
                delete nodo;
            }
            this->numeroElementos = 0;
        }

        bool Lista::ehVazia(){
           return numeroDeElementos() == 0;
        }

        int Lista::numeroDeElementos(){
            return this->numeroElementos;
        }

        bool Lista::existeElemento(int elemento){
            Nodo* nodo = this->inicio;
            while (nodo != NULL){
                if (nodo->pegaElemento() == elemento)
                    return true;
                nodo = nodo->pegaProximo();
            }
            return false;
        }

        int Lista::umElemento(int posicao){
            Nodo* nodo = this->inicio;
            int i = 1;

            while (i != posicao){
                nodo = nodo->pegaProximo();
                i++;
            }
            return nodo->pegaElemento();
        }

        int Lista::posicao(int elemento){
            Nodo* nodo = this->inicio;
            int i = 1;

            while (nodo->pegaElemento() != elemento){
                nodo = nodo->pegaProximo();
                i++;
            }
            return i;
        }

        void Lista::insere(int elemento, int posicao){
            Nodo* nodo = new Nodo(elemento);

            if (this->inicio == NULL)
                this->inicio = nodo;
            else {
                if (posicao == 1){
                    nodo->setaProximo(this->inicio);
                    this->inicio = nodo;
                }
                else {
                    Nodo* nodoAnterior = this->inicio;
                    int i = 1;
                    while (i != posicao - 1){
                        nodoAnterior = nodoAnterior->pegaProximo();
                        i++;
                    }
                    nodo->setaProximo(nodoAnterior->pegaProximo());
                    nodoAnterior->setaProximo(nodo);
                }
            }
            this->numeroElementos++;
        }

        void Lista::retira(int posicao){
            Nodo* nodo = this->inicio;

            if (posicao == 1){
                this->inicio = this->inicio->pegaProximo();
            }
            else {
                Nodo* nodoAnterior = this->inicio;
                int i = 1;
                while (i != posicao - 1){
                    nodoAnterior = nodoAnterior->pegaProximo();
                    i++;
                }
                nodo = nodoAnterior->pegaProximo();
                nodoAnterior->setaProximo(nodo->pegaProximo());
            }
            delete nodo;
            this->numeroElementos--;
        }

        void Lista::mostra(){
            Nodo* nodo = this->inicio;

            while (nodo != NULL){
                cout << nodo->pegaElemento() << " ";
                nodo = nodo->pegaProximo();
            }
        }
