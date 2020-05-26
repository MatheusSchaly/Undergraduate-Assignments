#include <iostream>
#include <stdlib.h>
#include "Fila.cpp"

using namespace std;

int main()
{
    Fila<int> caixa1, caixa2, caixa3, caixa4;
    int produtos, menorFila;

    for (int i = 0; i < 4; i++) {
        caixa1.insere(0);
        caixa4.insere(0);
    }
    for (int i = 0; i < 3; i++) {
        caixa2.insere(0);
    }
    for (int i = 0; i < 2; i++) {
        caixa3.insere(0);
    }

    srand(time(NULL));

    cout << "INICIO";

    for (int i = 0; i < 5 * 60; i++) {
        produtos = rand() % 50 + 1;
        menorFila = caixa1.numeroDeElementos();
        if (caixa2.numeroDeElementos() < menorFila) {
            menorFila = caixa2.numeroDeElementos();
        }
        if (caixa3.numeroDeElementos() < menorFila) {
            menorFila = caixa3.numeroDeElementos();
        }
        if (caixa4.numeroDeElementos() < menorFila && produtos <= 6) {
            caixa4.insere(0);
        }
        else if (caixa1.numeroDeElementos() == menorFila) {
            caixa1.insere(0);
        }
        else if (caixa2.numeroDeElementos() == menorFila) {
            caixa2.insere(0);
        }
        else {
            caixa3.insere(0);
        }


        if (i % 2 == 0 && !caixa4.ehVazia()) {
            caixa4.retira();
        }
        if (i % 4 == 0 && !caixa1.ehVazia()) {
            caixa1.retira();
        }
        if (i % 5 == 0 && !caixa2.ehVazia()) {
            caixa2.retira();
        }
        if (i % 7 == 0 && !caixa3.ehVazia()) {
            caixa3.retira();
        }

        if (i % 5 == 0) {
            cout << "\n\nCaixa 1: ";
            caixa1.mostra();
            cout << "\nCaixa 2: ";
            caixa2.mostra();
            cout << "\nCaixa 3: ";
            caixa3.mostra();
            cout << "\nCaixa 4: ";
            caixa4.mostra();
        }
    }

}
