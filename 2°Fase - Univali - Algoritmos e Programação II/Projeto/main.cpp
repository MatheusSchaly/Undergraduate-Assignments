#include <iostream>
#include "Vetor.h"

// int pesquisaElemento(int elemento) <

int main()
{
    Vetor myVec(5);
    cout << myVec.getTam();
    myVec.preencheVetor();
    myVec.mostraVetor();
    myVec.ordenaVetor();
    myVec.mostraVetor();
    cout << endl << myVec.pesquisaElemento(4);
}
