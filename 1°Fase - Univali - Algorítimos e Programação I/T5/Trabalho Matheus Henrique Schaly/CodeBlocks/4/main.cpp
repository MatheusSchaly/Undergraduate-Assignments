#include <iostream>

int numRegular (int n) {

    int regularidade;

    while (n % 2 == 0) {
        n /= 2;
    }
    while (n % 3 == 0) {
        n /= 3;
    }
    while (n % 5 == 0){
        n /= 5;
    }

    if (n == 1) {
        return 1;
    }
    else {
        return 0;
    }

}

int main() {

    int n;

    std::cout << "Forneca um numero:\n";
    std::cin >> n;

    if (numRegular(n) == 1) {
        std::cout << "Regular.\n";
    }
    else {
        std::cout << "Nao regular.\n";
    }

}
