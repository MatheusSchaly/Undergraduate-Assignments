#include "Professor.h"

Professor::Professor() {
    nome = "";
}

Professor::Professor(string n) {
    nome = n;
}

void Professor::setNome(string n) {
    nome = n;
}

string Professor::getNome() {
    return nome;
}

void Professor::setOrientacao (Orientacao &o) {
    orientacoes.push_back(&o);
}

void Professor::delOrientacao (Aluno &a) {

}

void Professor::mostra() {
    cout << "Nome professor: " << nome << endl;
}
