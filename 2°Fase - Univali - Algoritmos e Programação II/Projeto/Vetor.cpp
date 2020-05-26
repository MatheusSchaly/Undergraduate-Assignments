#include "Vetor.h"

Vetor::Vetor( int T ) {
// valida o VETOR
tam = (T > 0 ? T : 2 ); // 2 elementos no mínimo
    ptr = new int[ tam ]; // aloca espaco de dados
    for (int i = 0; i < tam; i++ )
        ptr[i] = 0; // inicializa o vetor com 0s
}

Vetor::~Vetor( ) {
    delete [] ptr;
}

int Vetor::getTam() const { // tamanho
    return tam;
}

void Vetor::preencheVetor() {
    for (int i = tam - 1; i > -1; i--) {
        int j = i;
        ptr[i] = j;
    }
    ptr[0] = 10;
    ptr[1] = 7;
    ptr[2] = 8;
    ptr[3] = 4;
    ptr[4] = 3;
}

void Vetor::mostraVetor() {
    cout << "\n\nMy vec:\n";
    for (int i = 0; i < tam; i++) {
        cout << ptr[i] << endl;
    }
}

void Vetor::ordenaVetor() {
    sort(ptr, ptr + tam);
}

int Vetor::pesquisaElemento(int elemento) { // traz posicao ou -1
    for (int i = 0; i < tam; i++) {
        cout << "i: " << i;
        cout << "ptr: " << ptr[i] << endl;
        if (ptr[i] = elemento) {
            return i;
        }
    }
    return -1;
}

exclui:
    int *pAux = new int [tam-1]
    j = 0
    for i ...
        delete ptr[]
        ...

//void Vetor::insereNovoElemento (int elemento); // no fim
//void Vetor::excluiElemento(int posicao);
