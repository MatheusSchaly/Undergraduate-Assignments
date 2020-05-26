#include "Familia.h"

Familia::Familia () {
    tamanho = 0;
}

void Familia::setMembro (Pessoa &p) {
    if (tamanho < 5) {
        membro[tamanho] = &p;
        tamanho ++;
    }
}

void Familia::mostra () {
    cout << "Tamanho da familia: " << tamanho << endl;
    cout << "\nMembros: " << endl;
    for (int i = 0; i < tamanho; i++) {
        cout << "\nEndereco: " << membro[i] << endl;
        membro[i]->mostra();
    }
}

int Familia::getTamanho () {
    return tamanho;
}
