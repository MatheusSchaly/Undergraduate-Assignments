#ifndef ORIENTACAO_H_INCLUDED
#define ORIENTACAO_H_INCLUDED
#include "Aluno.h"
#include "Professor.h"

class Orientacao {
    string tituloTrabalho;
    Professor *professor;
    Aluno *aluno;
public:
    Orientacao (Professor &p, Aluno &a, string titulo);
    string getTituloTrabalho ();
    void setTituloTrabalho (string titulo);
    Professor getOrientador ();
    Aluno getOrientando ();
    void setOrientador (Professor &p);
    void setOrietando (Aluno &a);
    void mostra ();
};

#endif // ORIENTACAO_H_INCLUDED
