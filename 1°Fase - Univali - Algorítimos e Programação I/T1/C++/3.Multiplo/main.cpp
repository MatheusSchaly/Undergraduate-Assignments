#include <iostream>

using namespace std;

// Autor : Matheus Henrique Schaly

int main()

{

    int numero;

    cout << "Forneca um numero inteiro entre 1000 e 9999" << endl;
    cin >> numero;
    numero = numero / 100;

    if (numero < 10 || numero > 99)
    {
        cout << "Numero invalido." << endl;
    }
    else
    {
        if (numero % 4 == 0)
        {
            cout << numero << ", eh multiplo de 4." << endl;
        }
        else
        {
            cout << numero << ", nao eh multiplo de 4." << endl;
        }
    }

    return 0;

}
