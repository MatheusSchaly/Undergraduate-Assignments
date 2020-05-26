#include <iostream>

using namespace std;

int main() {

    int matA[49][49], matB[49][49], matC[49][49], matAux[49][49], i, j, n;
    bool simetria = true;

    do {
        cout << "Forneca a ordem da matriz quadrada: ";
        cin >> n;
    } while ((n < 1) || (n > 50));

    cout << "Matriz A:" << endl;

    n = n + 1;

    for (i=1; i < n; i++) {
        for (j=1; j < n; j++) {
            cout << "Informe o termo " << i << " " << j << ": ";
            cin >> matA[i][j];
        }
    }

    for (i=1; i < n; i++) {
        for (j=1; j < n; j++) {
            cout << matA[i][j] << " ";
        }
        cout << endl;
    }

    cout << endl << "Matriz B:" << endl;

    for (i=1; i < n; i++) {
        for (j=1; j < n; j++) {
            cout << "Informe o termo " << i << " " << j << ": ";
            cin >> matB[i][j];
        }
    }

    for (i=1; i < n; i++) {
        for (j=1; j < n; j++) {
            cout << matB[i][j] << " ";
        }
        cout << endl;
    }

    cout << endl << "Matriz resultante da multiplicacao:" << endl;

    for (i=1; i < n; i++) {
        for (j=1; j < n; j++) {
            matC[i][j] = matA[i][j] * matB[i][j];
            cout << matC[i][j] << " ";
        }
        cout << endl;
    }

    cout << endl << "Matriz transposta de A:" << endl;

    for (i=1; i < n; i++) {
        for (j=1; j < n; j++) {
            matAux[i][j] = matA[j][i];
            cout << matAux[i][j] << " ";
        }
        cout << endl;
    }

    cout << endl << "Matriz transposta de B:" << endl;

    for (i=1; i < n; i++) {
        for (j=1; j < n; j++) {
            matAux[i][j] = matB[j][i];
            cout << matAux[i][j] << " ";
        }
        cout << endl;
    }

    for (i=0; i < n-1; i++) {
        for (j=i+1; j < n; j++) {
            if (matA[i][j] != matA[j][i]) {
                simetria = false;
                break;
            }
        }
    }

    if (simetria) {
        cout << "\nEh simetrica.\n";
    }
    else {
        cout << "\nNao simetrica.\n";
    }

}
