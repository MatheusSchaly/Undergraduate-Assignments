#include <iostream>

using namespace std;

// Autor : Matheus Henrique Schaly

int main()

{

    int cod1, cod2, cod3;
    float preco1, preco2, preco3, precoF;

    cout << "Informe o codigo 1, 2 e 3:" << endl;
    cin >> cod1 >> cod2 >> cod3;

    if ((cod1<1) || (cod1>4) || (cod2<5) || (cod2>6) || (cod3<7) || (cod3>9))
    {
        cout << "Opcao invalida.";
    }
    else
    {
        switch (cod1)
        {
        case 1 :
            cout << "Hamburger R$ 4,50;" << endl;
            preco1 = 4.50;
            break;
        case 2 :
            cout << "Chessburger R$ 5,50;" << endl;
            preco1 = 5.50;
            break;
        case 3 :
            cout << "Cachorro quente R$ 4,00;" << endl;
            preco1 = 4.00;
            break;
        default :
            cout << "Sanduiche R$ 3,50;" << endl;
            preco1 = 3.50;
        }

        switch (cod2)
        {
        case 5 :
            cout << "Refrigerante R$ 1,00;" << endl;
            preco2 = 1.00;
            break;
        default :
            cout << "Suco de laranja R$ 2,00;" << endl;
            preco2 = 2.00;
        }

        switch (cod3)
        {
        case 7 :
            cout << "Milk shake R$ 1,50." << endl;
            preco3 = 1.50;
            break;
        case 8 :
            cout << "Sundae R$ 3,00." << endl;
            preco3 = 3.00;
            break;
        default :
            cout << "Casquinha R$ 1,00." << endl;
            preco3 = 1.00;
        }

        precoF = preco1 + preco2 + preco3;
        cout << "O valor total eh R$ " << precoF << "." << endl;

    }

    return 0;

}
