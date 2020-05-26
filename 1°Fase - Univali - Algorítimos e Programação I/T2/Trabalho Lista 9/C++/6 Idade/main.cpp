#include <iostream>

using namespace std;

int main()

{
    int idade, pessoas;
    float medIdade;
    char continuidade;

    pessoas = 0;

    while (continuidade != 'N')
    {
        cout << "Forneca a idade: ";
        cin >> idade;
        while (idade <= 0)
        {
            cout << "Idade deve ser maior que 0: ";
            cin >> idade;
        }
            pessoas = pessoas + 1;
            medIdade = medIdade + idade;

            cout << "Deseja continuar? S/N: ";
            cin >> continuidade;
            continuidade = toupper(continuidade);

            while ((continuidade != 'N') && (continuidade != 'S'))
            {
                cout << "Incorreto, use S ou N: ";
                cin >> continuidade;
                continuidade = toupper(continuidade);
            }
    }

    cout << "Media de idade: " << medIdade / pessoas << endl;

    return 0;
}
