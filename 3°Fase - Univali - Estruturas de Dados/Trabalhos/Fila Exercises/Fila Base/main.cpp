#include <iostream>
#include <stdlib.h>
#include "Fila.cpp"

using namespace std;

int main()
{
    cout << "Hey" << endl;
    Fila<int> fila1, fila2;
    cout << fila1.elementosIguais(fila2) << endl;
    fila1.insere(1);
    cout << fila1.elementosIguais(fila2) << endl;
    fila1.insere(2);
    fila2.insere(1);
    cout << fila1.elementosIguais(fila2) << endl;
    fila2.insere(2);
    cout << fila1.elementosIguais(fila2) << endl;
}
