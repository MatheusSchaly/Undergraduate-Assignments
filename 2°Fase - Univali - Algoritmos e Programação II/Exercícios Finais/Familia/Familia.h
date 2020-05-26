#ifndef FAMILIA_H_INCLUDED
#define FAMILIA_H_INCLUDED
#include "Pessoa.h"
#include <iostream>
using namespace std;

class Familia {
    Pessoa *membro[5];
    int tamanho;
public:
    Familia ();
    void setMembro (Pessoa &p);
    void mostra ();
    int getTamanho ();
};

#endif // FAMILIA_H_INCLUDED
