#include <iostream>

using namespace std;

int main()
{
    int i, j, n, mat[12][10];
    float custo[9], venda[9], custoT[11], receitaL[11], receitaB[11];

    do {
        cout << "Informe a quantidade de motores: ";
        cin >> n;
    } while ((n < 1) || (n > 10));

    custo[0] = 0;
    receitaB[0] = 0;

    for (i=0; i < 12; i++) {
        for (j=0; j < n-1; j++) {
            do {
                cout << "Mes " << i + 1 << " quantidade de motores " << j + 1 << " : ";
                cin >> mat[i][j];
            } while (mat[i][j] < 0);
        }
    }

    for (i=0; i < n - 1; i++) {
        cout << "Informe o custo do motor " << i + 1 << " : ";
        cin >> custo[i];
        cout << "Informe o preco de venda do motor " << i + 1 << " : ";
        cin >> venda[i];
    }

    for (i=0; i < 12; i++) {
        for (j=0; j < n-1; j++) {
            custoT[i] += custo[j] * mat[i][j];
            receitaB[i] += venda[j] * mat[i][j];
        }
        receitaL[i] = receitaB[i] - custoT[i];
    }

    cout << endl;

    for (i=0; i < 12; i++) {
        cout << "mes " << i + 1 << ":" << endl;
        cout << "Custo total R$" << custoT[i] << endl;
        cout << "Receita bruta R$" << receitaB[i] << endl;
        cout << "Receita liquida R$" << receitaL[i] << endl << endl;
    }
}
