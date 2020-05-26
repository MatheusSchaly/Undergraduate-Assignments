#include <iostream>

using namespace std;

int main() {

    float mat[3][6], tempMed[3], tempMax[3], tempMin[3], maisQuente, maisFrio;
    int i, j, diasAcima, diasAbaixo;

    diasAcima = 0;
    diasAbaixo = 0;

    for (i=1; i < 5; i++) {
        tempMed[i] = 0;
        for (j=1; j < 8; j++) {
            cout << "Informe o termo " << i << " " << j << ": ";
            cin >> mat[i][j];
            tempMed[i] += mat[i][j];
            if (j == 1) {
                tempMax[i] = mat[i][1];
                tempMin[i] = mat[i][1];
            }
            if ((i == 1) && (j == 1)) {
                maisQuente = mat[1][1];
                maisFrio = mat[1][1];
            }
            if (mat[i][j] > 25) {
                diasAcima++;
            }
            if (mat[i][j] < 25) {
                diasAbaixo++;
            }
            if (tempMax[i] < mat[i][j]) {
                tempMax[i] = mat[i][j];
            }
            if (tempMin[i] > mat[i][j]) {
                tempMin[i] = mat[i][j];
            }
        }
        if (tempMax[i] > maisQuente) {
            maisQuente = tempMax[i];
        }
        if (tempMin[i] < maisFrio) {
            maisFrio = tempMin[i];
        }
        tempMed[i] /= 7;
        cout << "\nDIAS ACIMA\n" << diasAcima;
        cout << "\nDIAS ABAIXO:\n" << diasAbaixo << endl << endl;

    }

    cout << endl;

    for (i=1; i < 5; i++) {
        cout << "Semana " << i << endl;
        cout << "Media:" << tempMed[i] << endl;
        cout << "Maxima:" << tempMax[i] << endl;
        cout << "Minima:" << tempMin[i] << endl;
        cout << endl;
    }

    cout << "Dia mais quente: " << maisQuente << endl;
    cout << "Dia mais frio: " << maisFrio << endl;
    cout << "Dias acima de 25 graus: " << diasAcima << endl;
    cout << "Dias abaixo de 25 graus: " << diasAbaixo << endl;

}

// int matA[15][25] = {{0}}; só na declaração
// multiplicacao de matriz eh linha de um e coluna da outra
