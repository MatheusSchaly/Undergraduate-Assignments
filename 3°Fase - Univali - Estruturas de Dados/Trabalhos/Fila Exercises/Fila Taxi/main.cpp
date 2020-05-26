//Implemente um programa para simular um ponto de táxi durante 10 horas, cujas características são:
//a) a cada 5 minutos chega um número aleatório de táxis (entre 0 e 3 táxis); b) a cada 3 minutos
//chega um número aleatório de passageiros (entre 0 e 2 passageiros); e c) a cada minuto, se
//houverem táxis e passageiros para serem transportados, um passageiro toma um táxi.
//Considere a classe Fila (estrutura estática) para representar as filas de passageiros e de táxis.
//O programa deve informar o número de táxis utilizados (que fizeram o transporte de passageiros) e o
//tempo médio de espera dos passageiros atendidos.

#include <iostream>
#include <stdlib.h>
#include "Fila.cpp"

// N foi implementado o tempo medio de espera dos passageiros atendidos.

using namespace std;

int main()
{
    Fila<int> taxis, passageiros;
    int quantTaxi, quantPassageiros, taxisUtilizados = 0, tempoTotal, totalPessoas;

    srand(time(NULL));

    for (int i = 0; i <= 10 * 60; i++) {
        if (i % 5 == 0) {
            quantTaxi = rand() % 4;
            for (int j = 0; j < quantTaxi; j++) {
                taxis.insere(0);
            }
        }
        if (i % 3 == 0) {
            quantPassageiros = rand() % 3;
            for (int j = 0; j < quantPassageiros; j++) {
                passageiros.insere(i);
            }
        }
        if (!(taxis.ehVazia() && passageiros.ehVazia())) {
            tempoTotal = passageiros.primeiro();
            passageiros.retira();
            taxis.retira();
            taxisUtilizados++;
        }
    }
    cout << "Taxis Utilizados: " << taxisUtilizados << endl;
    totalPessoas = taxisUtilizados + passageiros.numeroDeElementos();
    cout << tempoTotal / totalPessoas;
}
