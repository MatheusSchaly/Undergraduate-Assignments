#include <iostream>

int leiaNumIntIntervalo (int inf, int sup) {

    int n;

    do {
        std::cout << "Digite valor no intervalo de " << inf << " a " << sup << ": ";
        std::cin >> n;
        if ((n < inf) || (n > sup)) {
            std::cout << "Valor digitado esta fora do intervalo.\n";
        }
    } while ((n < inf) || (n > sup));

    return n;

}

void numExtenso (int n) {

    int i;

    std::string numExtenso[11] = {"Zero", "Um", "Dois", "Tres",
    "Quatro", "Cinco", "Seis", "Sete", "Oito", "Nove", "Dez"};

    for (i = 0; i < 11; i++) {
        if (n == i) {
            std::cout << n << " = " << numExtenso[i];
        }
    }

}

int main() {

    int n;

    n = leiaNumIntIntervalo (0, 10);
    numExtenso (n);

}
