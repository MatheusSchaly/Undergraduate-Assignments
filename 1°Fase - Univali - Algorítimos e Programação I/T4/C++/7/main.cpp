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

    n = n + 1;

    for (i=1; i < n; i++) {
        cout << "Informe o custo do motor " << i << " : ";
        cin >> custo[i];
        cout << "Informe o preco de venda do motor " << i << " : ";
        cin >> venda[i];
    }

    custo[0] = 0;
    receitaB[0] = 0;

    for (i=1; i < 13; i++) {
        for (j=1; j < n; j++) {
            do {
                cout << "Mes " << i << " quantidade de motores " << j << " : ";
                cin >> mat[i][j];
            } while (mat[i][j] < 0);
            custoT[i] += custo[j] * mat[i][j];
            receitaB[i] += venda[j] * mat[i][j];
        }
        receitaL[i] = receitaB[i] - custoT[i];
    }

    cout << endl;

    for (i=1; i < 13; i++) {
        cout << "mes " << i << ":" << endl;
        cout << "Custo total R$" << custoT[i] << endl;
        cout << "Receita bruta R$" << receitaB[i] << endl;
        cout << "Receita liquida R$" << receitaL[i] << endl << endl;
    }
}
