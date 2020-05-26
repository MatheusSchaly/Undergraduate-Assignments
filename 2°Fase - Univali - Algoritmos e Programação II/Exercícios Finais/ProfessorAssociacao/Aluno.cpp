#include "Aluno.h"

Aluno::Aluno() {
    nome = "";
    curso = "";
}

Aluno::Aluno(string n, string c) {
    nome = n;
    curso = c;
}

void Aluno::setNome(string n) {
    nome = n;
}

string Aluno::getNome() {
    return nome;
}

void Aluno::setCurso (string c) {
    curso = c;
}

string Aluno::getCurso () {
    return curso;
}

void Aluno::setOrientacao (Orientacao &o) {
    orientacao = &o;
}

void Aluno::mostra () {
    cout << "Nome aluno: " << nome << endl;
    cout << "Curso aluno: " << curso << endl;
}
