#include <iostream>
#include <stdlib.h>
#include <ctime>
#include "Fila.cpp"

using namespace std;

int main()
{
    Fila<int> filaDePassageiros, filaDeTaxis;
    int tempoChegada, tempoEspera, taxisUsados, passageirosAtendidos;

    srand(time(NULL));

    tempoEspera = 0;
    taxisUsados = 0;
    passageirosAtendidos = 0;

    for (int i = 1; i <= 10 * 60; i++)
    {
        if (i % 3 == 0)
            for (int j = 1; j <= rand() % 3; j++)
                filaDePassageiros.insere(i);

        if (i % 5 == 0)
            for (int j = 1; j <= rand() % 4; j++)
                filaDeTaxis.insere(1);

        if ((!filaDePassageiros.ehVazia()) &&
                (!filaDeTaxis.ehVazia()))
        {
            filaDeTaxis.retira();
            taxisUsados++;
            tempoChegada = filaDePassageiros.primeiro();
            filaDePassageiros.retira();
            passageirosAtendidos++;
            tempoEspera += i - tempoChegada;
        }
    }

    cout << "tempo medio de espera = " << ((float) tempoEspera / (float) passageirosAtendidos) << endl;
    cout << "taxis usados = " << taxisUsados;

    return 0;
}
