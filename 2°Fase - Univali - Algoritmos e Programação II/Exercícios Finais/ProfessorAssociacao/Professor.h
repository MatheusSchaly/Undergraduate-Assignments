#ifndef PROFESSOR_H_INCLUDED
#define PROFESSOR_H_INCLUDED
using namespace std;
#include <iostream>
#include <vector>
#include <string>
#include "Aluno.h"

class Orientacao;

class Professor {
    string nome;
    vector <Orientacao*> orientacoes;
public:
    Professor ();
    Professor (string n);
    void setOrientacao (Orientacao &o);
    void delOrientacao (Aluno &a);
    void setNome (string n);
    string getNome ();
    void mostra ();
};

#endif // PROFESSOR_H_INCLUDED
