#include <iostream>
#include "Associacao.cpp"
#include "Dicionario.cpp"
#include <time.h>
#include <cstdlib>

using namespace std;

int h1(int chave)
{
    return chave % 10;
}

int h2(int chave)
{
    return chave % 4;
}

int main()
{
    Dicionario<int, string> dicionarioString(10, h1);

    int chave;
    string informacao;

    cin >> chave;
    while (chave != -1)
    {
        if (!dicionarioString.existeElemento(chave))
        {
            cin >> informacao;
            dicionarioString.insere(chave, informacao);
            cout << "Dicionario " << endl;
            dicionarioString.mostra();
        }
        else
            cout << "Chave ja esta no dicionario" << endl;
        cin >> chave;
    }

    cout << "Chave da associacao a ser excluida = ";
    cin >> chave;
    if (!dicionarioString.existeElemento(chave))
        cout << "Chave nao esta no dicionario";
    else
        dicionarioString.retira(chave);

    cout << endl;

    dicionarioString.mostra();

    cout << endl;

    srand(time(NULL));

    Dicionario<int, char> dicionarioChar(4, h2);

    for (int i = 1; i <= 20; i++)
    {
        chave = rand() % 100 + 1;
        if (!dicionarioChar.existeElemento(chave))
            dicionarioChar.insere(chave, (char) (rand() % 26 + 65));
    }

    dicionarioChar.mostra();

    return 0;
}
