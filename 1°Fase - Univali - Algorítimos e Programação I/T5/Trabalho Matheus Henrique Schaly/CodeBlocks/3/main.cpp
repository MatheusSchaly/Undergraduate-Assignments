#include <iostream>

int leiaNumAcimaDe (int acima) {

    int n;

    do {
        std::cout << "Digite um valor acima de " << acima << ": ";
        std::cin >> n;
    } while (n <= acima);

    return n;

}

void equacaoLinear (int line, int col) {

    float A[line][col], X[col], B[line], resultado[line];
    bool solucao;
    int i, j;

    solucao = true;
    resultado[line] = {};

    std::cout << "\nMatriz:\n";
    for (i = 0; i < line; i++) {
        for (j = 0; j < col; j++) {
            std::cout << "Posicao " << i + 1 << " " << j + 1 << ": ";
            std::cin >> A[i][j];
        }
    }

    std::cout << "\nX:\n";
    for (i = 0; i < col; i++) {
        std::cout << "Valor " << i + 1 << ": ";
        std::cin >> X[i];
    }

    std::cout << "\nB:\n";
    for (i = 0; i < line; i++) {
        std::cout << "Valor " << i + 1 << ": ";
        std::cin >> B[i];
    }

    for (i = 0; i < line; i++) {
        for (j = 0; j < col; j++) {
            resultado[i] += A[i][j] * X[j];
        }
    }

    for (i = 0; i < line; i++) {
        if (resultado[i] != B[i]) {
            solucao = false;
            i = line;
        }
    }

    if (solucao) {
        std::cout << "\nX e a solucao.\n";
    }
    else {
        std::cout << "\nX nao e a solucao.\n";
    }

}

int main() {

    int line, col;

    line = leiaNumAcimaDe (0);
    col = leiaNumAcimaDe (0);
    equacaoLinear (line, col);

}
