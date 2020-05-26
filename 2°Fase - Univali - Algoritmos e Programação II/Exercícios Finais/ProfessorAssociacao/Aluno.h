#ifndef ALUNO_H_INCLUDED
#define ALUNO_H_INCLUDED
using namespace std;
#include <iostream>
#include <string>

class Orientacao;

class Aluno {
    string nome, curso;
    Orientacao *orientacao;
public:
    Aluno ();
    Aluno(string n, string c);
    void setNome (string n);
    string getNome ();
    void setCurso (string c);
    string getCurso ();
    void setOrientacao (Orientacao &o);
    void mostra ();
};

#endif // ALUNO_H_INCLUDED
