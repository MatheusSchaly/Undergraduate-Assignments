#include <iostream>
#include <stdlib.h>
#include "Fila.cpp"

using namespace std;

int main()
{
    Fila<int> filaA, filaB, filaC;
    int n, processosA = 0, processosB = 0, processosC = 0;

    srand(time(NULL));

    for (int i = 0; i < 100; i++) {
        n = rand() % 101;
        if (n <= 49) {
            if (n <= 25 && filaA.ehVazia()) {
                processosA++;
                filaA.insere(i);
            }
            else if (n <= 39 && filaB.ehVazia()) {
                processosB++;
                filaB.insere(i);
            }
            else {
                if (filaC.ehVazia()) {
                    processosC++;
                    filaC.insere(i);
                }
            }
        }
        else {
            if (n <= 75) {
                filaA.retira();
            }
            else if (n <= 89) {
                filaB.retira();
            }
            else {
                filaC.retira();
            }
        }
        if (i % 5 == 0) {
            if (filaA.ehVazia()) {
                cout << "Fila \"a\" esta disponivel, ou seja, nao possui processos.\n";
            }
            else {
                cout << "Fila \"a\" nao esta disponivel, ou seja, possui processos.\n";
            }
            if (filaB.ehVazia()) {
                cout << "Fila \"b\" esta disponivel, ou seja, nao possui processos.\n";
            }
            else {
                cout << "Fila \"b\" nao esta disponivel, ou seja, possui processos.\n";
            }
            if (filaC.ehVazia()) {
                cout << "Fila \"c\" esta disponivel, ou seja, nao possui processos.\n";
            }
            else {
                cout << "Fila \"c\" nao esta disponivel, ou seja, possui processos.\n";
            }
            cout << "Processos executados por \"a\": " << processosA << endl;
            cout << "Processos executados por \"b\": " << processosB << endl;
            cout << "Processos executados por \"c\": " << processosC << "\n\n";
        }
    }
}
