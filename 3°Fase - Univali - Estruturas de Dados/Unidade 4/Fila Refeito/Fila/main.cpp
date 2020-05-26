#include <iostream>
#include "Fila.cpp"

using namespace std;

int main()
{
    Fila<int> filaCinema;
    int i, j, numeroDePessoas, pessoasQueVieramAssistirOFilme;

    srand(time(NULL));

    for (i = 1; i <= 12; i++)
        filaCinema.insere(1);

    pessoasQueVieramAssistirOFilme = 12;

    for (i = 1; i <= 45 * 60; i++)
    {
        if (i % 60 == 0)
        {
            numeroDePessoas = rand()%3 + 2;
            pessoasQueVieramAssistirOFilme += numeroDePessoas;

            for (j = 1; j <= numeroDePessoas; j++)
                filaCinema.insere(1);
        }
        if (i % 30 == 0)
            if (!filaCinema.ehVazia())
                filaCinema.retira();
    }

    cout << "pessoas que vieram assistir o filme = " <<
         pessoasQueVieramAssistirOFilme  << endl;
    cout << "quantidade de pessoas na fila quando o filme comecou = " <<
         filaCinema.numeroDeElementos();

    return 0;
}
