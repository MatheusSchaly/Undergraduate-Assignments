#include <iostream>
#include <ctype.h>

using namespace std;

// Autor : Matheus Henrique Schaly

int main()

{

    float percurso, gasolina;
    char carro;

    cout << "Forneca seu carro, A, B ou C; e o percurso em quilometros:" << endl;
    cin >> carro >> percurso;
    carro = toupper(carro);

    if ((carro < 'A') || (carro > 'C') || (percurso <= 0))
    {
        cout << "Dados incorretos." << endl;
    }
    else
    {
        switch (carro)
        {
        case 'A' :
            gasolina = 8.0;
            break;
        case 'B' :
            gasolina = 9.0;
            break;
        default :
            gasolina = 12.0;
        }

    cout << "A gasolina necessaria para o seu percurso eh: " << percurso / gasolina << " L." << endl;

    }

    return 0;

}
