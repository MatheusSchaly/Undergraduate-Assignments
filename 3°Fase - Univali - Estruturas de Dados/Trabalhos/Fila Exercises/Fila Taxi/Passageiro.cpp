#include "Passageiro.h"

Passageiro::Passageiro() {
    tempoDeEspera = 0;
}

void addOneMin() {
    tempoDeEspera++;
}

int getTempoDeEspera() {
    return tempoDeEspera;
}

friend ostream& operator << (ostream &out, Passageiro &passageiro) {
    cout << "oie";
    return out;
}
