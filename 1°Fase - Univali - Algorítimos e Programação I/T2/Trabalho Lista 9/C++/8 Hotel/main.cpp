#include <iostream>

using namespace std;

int main()

{
    float preco, valorDiaria, taxa1, taxa2, taxa3;
    int quantDiarias, contasEncerradas, opcao;
    string nome;

    taxa1 = 5.00;
    taxa2 = 6.50;
    taxa3 = 7.50;
    valorDiaria = 50.00;
    quantDiarias = 0;
    preco = 0;
    contasEncerradas = 0;

    do
    {
        cout << endl;
        cout << "1 - Encerrar a conta de um hospede." << endl;
        cout << "2 - Verificar numero de contas encerradas." << endl;
        cout << "3 - Finalizar a execucao." << endl;
        cin >> opcao;

        if (opcao == 1)
        {
            contasEncerradas = contasEncerradas + 1;
            cout << "Forneca o nome: ";
            cin >> nome;
            do
            {
                cout << "Forneca quantidade de diarias: ";
                cin >> quantDiarias;
            }
            while (quantDiarias <= 0);

            if (quantDiarias < 15)
            {
                preco = quantDiarias * valorDiaria + quantDiarias * taxa1;
            }
            else
            {
                if (quantDiarias > 15)
                {
                    preco = quantDiarias * valorDiaria + quantDiarias * taxa3;
                }
                else
                {
                    preco = quantDiarias * valorDiaria + quantDiarias * taxa2;
                }
            }
        cout << nome << ", custo total de: " << preco << endl;
        }

        if (opcao == 2)
        {
            cout << "A quantidade de contas encerradas eh de: " << contasEncerradas << endl;
        }
    }
    while (opcao != 3);

    return 0;
}
