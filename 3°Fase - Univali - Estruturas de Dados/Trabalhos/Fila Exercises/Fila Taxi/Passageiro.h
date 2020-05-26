#ifndef PASSAGEIRO_H_INCLUDED
#define PASSAGEIRO_H_INCLUDED

#include <iostream>

using namespace std;

class Passageiro {
    int tempoDeEspera();
public:
    void addOneMin();
    int getTempoDeEspera();
    friend ostream& operator << (ostream &out, Passageiro &passageiro);
};


#endif // PASSAGEIRO_H_INCLUDED
