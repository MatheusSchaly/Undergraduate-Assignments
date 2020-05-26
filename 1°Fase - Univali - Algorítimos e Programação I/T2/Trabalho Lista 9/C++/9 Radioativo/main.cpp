#include <iostream>

using namespace std;

int main()

{
    int tempo, meiaVida;
    float massaIni, massaFin;

    meiaVida = 50;
    tempo = 0;
    massaIni = 0;
    massaFin = 0;

    do
    {
    cout << "Forneca a massa em kg: ";
    cin >> massaIni;
    massaIni = massaIni * 1000;
    }
    while (massaIni <= 0);

    cout << "Massa inicial: " << massaIni << " gramas." <<  endl;

    while (massaIni >= 0.5)
    {
        tempo = tempo + 50;
        massaIni = massaIni / 2;
    }

    cout << "Massa final: " << massaIni << " gramas." << endl;
    cout << "Tempo: " << tempo << " segundos." << endl;

}
