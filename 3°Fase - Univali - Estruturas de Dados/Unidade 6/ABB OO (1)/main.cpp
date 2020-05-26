#include <iostream>
#include "ABB.cpp"

using namespace std;

int main()
{
    ABB<int> arvoreInt;

    arvoreInt.insere(10);
    arvoreInt.mostra();
    cout << endl;
    arvoreInt.insere(15);
    arvoreInt.mostra();
    cout << endl;
    arvoreInt.insere(5);
    arvoreInt.mostra();
    cout << endl;
    if (arvoreInt.existeElemento(5))
        cout << "Elemento existe" << endl;
    else
        cout << "Elemento nao existe" << endl;

    ABB<char> arvoreChar;

    arvoreChar.insere('A');
    arvoreChar.insere('B');
    arvoreChar.insere('C');
    arvoreChar.insere('D');
    arvoreChar.mostra();

    return 0;
}
