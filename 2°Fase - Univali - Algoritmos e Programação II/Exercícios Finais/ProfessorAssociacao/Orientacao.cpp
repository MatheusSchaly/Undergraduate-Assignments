#include "Orientacao.h"

Orientacao::Orientacao (Professor &p, Aluno &a, string titulo) {
    professor = &p;
    aluno = &a;
    tituloTrabalho = titulo;
}

string Orientacao::getTituloTrabalho () {
    return tituloTrabalho;
}

void Orientacao::setTituloTrabalho (string titulo) {
    tituloTrabalho = titulo;
}

Professor Orientacao::getOrientador () {
    return *professor;
}

Aluno Orientacao::getOrientando () {
    return *aluno;
}

void Orientacao::setOrientador (Professor &p) {
    professor = &p;
}

void Orientacao::setOrietando (Aluno &a) {
    aluno = &a;
}

void Orientacao::mostra () {
    cout << "\nTitulo da orientacao: " << tituloTrabalho << endl;
    professor -> mostra();
    aluno -> mostra();
}
