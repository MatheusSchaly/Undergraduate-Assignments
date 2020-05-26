#include "Pessoa.h"

Pessoa::Pessoa () {
    idade = 0;
    sexo = 'm';
}

void Pessoa::setIdade (int i) {
    idade = i;
}

int Pessoa::getIdade () {
    return idade;
}

void Pessoa::setSexo (char s) {
    sexo = s;
}

char Pessoa::getSexo () {
    return sexo;
}

void Pessoa::mostra () {
    cout << "Idade: " << idade << endl;
    cout << "Sexo: " << sexo << endl;
}
