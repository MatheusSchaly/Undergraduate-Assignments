#include "Cliente.h"

Cliente::Cliente (int codigo, char *nome, char *telefone, char *email) {
    this -> codigo = codigo;
    strcpy (this -> nome, nome);
    strcpy (this -> telefone, telefone);
    strcpy (this -> email, email);
}

void Cliente::setCodigo () {
    cout << "Codigo: ";
    cin >> codigo;
    cin.ignore();
}

void Cliente::setNome () {
    cout << "Nome: ";
    gets(nome);
}

void Cliente::setTelefone () {
    cout << "Telefone: ";
    gets(telefone);
}

void Cliente::setEmail () {
    cout << "Email: ";
    gets(email);
}

void Cliente::addPedido (Pedido *pedido) {
    pedidos.push_back(pedido);
}

int Cliente::getCodigo () {
    return codigo;
}

char* Cliente::getNome () {
    return nome;
}

char* Cliente::getTelefone () {
    return telefone;
}

char* Cliente::getEmail () {
    return email;
}

void Cliente::getPedidos () {
    for (unsigned int i = 0; i < pedidos.size(); i++) {
        cout << "Pedido " << i + 1 << ":";
        pedidos[i] -> mostra();
    }
}

int Cliente::getPedidoIndex (int numero) {
    for (unsigned int i = 0; i < pedidos.size(); i++) {
        if (pedidos[i] -> getNumero() == numero) {
            return i;
        }
    }
    return -1;
}

Pedido Cliente::getPedido (int index) {
    return *pedidos[index];
}

void Cliente::mostra () {
    cout << "Codigo: " << codigo << endl;
    cout << "Nome: " << nome << endl;
    cout << "Telefone: " << telefone << endl;
    cout << "Email: " << email << endl << endl;
    cout << "Total pedidos: " << pedidos.size() << endl << endl;
    for (unsigned int i = 0; i < pedidos.size(); i++) {
        cout << "Pedido " << i + 1 << ":";
        pedidos[i] -> mostra();
    }
}

void Cliente::mostraClientePuro () {
    cout << "Codigo: " << codigo << endl;
    cout << "Nome: " << nome << endl;
    cout << "Telefone: " << telefone << endl;
    cout << "Email: " << email << endl << endl;
}

ostream& operator << (ofstream& out, Cliente &cliente) {
    cliente.grava(out);
    return out;
}

istream& operator >> (ifstream& in, Cliente &cliente) {
    cliente.recupera(in);
    return in;
}

void Cliente::grava (ofstream &out) {
    out.write((char*)&nome, sizeof(nome));
    out.write((char*)&codigo, sizeof(codigo));
    out.write((char*)&telefone, sizeof(telefone));
    out.write((char*)&email, sizeof(email));
}

void Cliente::recupera (ifstream &in) {
    in.read((char*)&nome, sizeof(nome));
    in.read((char*)&codigo, sizeof(codigo));
    in.read((char*)&telefone, sizeof(telefone));
    in.read((char*)&email, sizeof(email));
}
