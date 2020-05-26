#ifndef PESSOA_H_INCLUDED
#define PESSOA_H_INCLUDED
#include <iostream>
using namespace std;

class Pessoa {
    int idade;
    char sexo;
public:
    Pessoa();
    void setIdade (int i);
    int getIdade ();
    void setSexo (char s);
    char getSexo ();
    void mostra ();
};

#endif // PESSOA_H_INCLUDED
