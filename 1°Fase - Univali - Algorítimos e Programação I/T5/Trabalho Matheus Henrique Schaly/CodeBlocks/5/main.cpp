#include <iostream>
#include <stdio.h>

int leiaNumDifZero () {

    int n;

    do {
        std::cout << "Forneca um valor diferente de 0: ";
        std::cin >> n;
    } while (n == 0);

    return n;

}

void modDiv (int &a, int &b) {

    int aux1, aux2;

    aux1 = a;
    aux2 = b;
    a = aux1 / aux2;
    b = aux1 % aux2;

}

int main()

{

    int a, b;
    std::cout << "Forneca o valor a: ";
    std::cin >> a;
    b = leiaNumDifZero ();
    modDiv (a, b);

    std::cout << "\nValor da divisao eh: " << a << std::endl;
    std::cout << "Valor do resto: " << b << std::endl;

}
