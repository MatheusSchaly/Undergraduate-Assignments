#include <iostream>

using namespace std;

// Autor: Matheus Henrique Schaly

int main()

{

    float saldoM;
    int valorC;

    cout << "Forneca seu saldo medio:" << endl;
    cin >> saldoM;

    if (saldoM <= 500)
    {
        cout << "Seu saldo medio eh: " << saldoM << " e voce nao recebeu credito." << endl;
    }
    else
    {
        if (saldoM <= 1000)
        {
            valorC = 30;
            saldoM = saldoM * 1.30;
        }
        else
        {
            if (saldoM <= 3000)
            {
                valorC = 40;
                saldoM = saldoM * 1.40;
            }
            else
            {
                valorC = 50;
                saldoM = saldoM * 1.50;
            }
        }

    cout << "Seu saldo medio eh: " << saldoM << " e seu credito eh: " << valorC << " %." << endl;

    }

    return 0;

}
