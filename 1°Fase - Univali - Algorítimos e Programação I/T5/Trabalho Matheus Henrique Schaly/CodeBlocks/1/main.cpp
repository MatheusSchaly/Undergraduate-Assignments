#include <iostream>
int main()
{
    int n,i,j,cont;

    do {
        std::cout << "Forneca a ordem da matriz: ";
        std::cin >> n;
    } while ((n % 2 == 0) || (n > 10) || (n < 1));

    int matriz[n][n] = {}, aux = n / 2;

    matriz[0][aux] = 1;
    cont = 1;
    i = 0;
    j = aux;

    do {

        i--;
        j++;
        cont++;

        if ((i < 0) || (i > n - 1)) {
            i = n - 1;
        }

        if ((j > n - 1) || (j < 0)) {
            j = 0;
        }

        if (matriz[i][j] != 0) {
            i += 2;
            j--;
            if (i > n - 1) {
                i = (i-n);
            }
            if (j < 0) {
                j = n - 1;
            }
        }
        matriz[i][j] = cont;

    } while (cont != n*n);

    for(i = 0; i < n; i++) {
        for (j = 0; j < n; j++) {
            std::cout << matriz [i][j] << " ";
        }
        std::cout << std::endl;
    }

}
