#include <iostream>
#include "Lista.cpp"

using namespace std;

int main()
{
    string mensagem;

    cout << "Entre a mensagem: " << endl;bc
    getline(cin, mensagem);

    Lista *criptoDeque = new Lista();

    for (int i = mensagem.length() - 1; i >= 0; i--) {
        criptoDeque -> insere(mensagem.at(i));
    }

    criptoDeque -> print();


}
