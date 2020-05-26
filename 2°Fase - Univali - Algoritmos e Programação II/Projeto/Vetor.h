#ifndef VETOR_H_INCLUDED
#define VETOR_H_INCLUDED3
#include <iostream>
#include <algorithm>

using namespace std;

class Vetor {
    int tam; // tamanho
    int *ptr; // ponteiro p/1º elemento do array
public:
    Vetor(int = 2); // construtor padrão, min. 2 elem
    ~Vetor(); // destrutor
    int getTam() const; // tamanho
    void preencheVetor();
    void mostraVetor();
    void ordenaVetor();
    int pesquisaElemento(int elemento); // traz posicao ou -1
    void insereNovoElemento (int elemento); // no fim
    void excluiElemento(int posicao);
};

#endif
