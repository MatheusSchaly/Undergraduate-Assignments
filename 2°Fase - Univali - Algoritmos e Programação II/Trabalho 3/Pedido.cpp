#include "Pedido.h"

Pedido::Pedido (Cliente &cliente, int numero, char *data) {
    this -> numero = numero;
    this -> data = data;
    this -> cliente = &cliente;
    this -> cliente -> addPedido (this);
}

void Pedido::setNumero () {
    cout << "Numero: ";
    cin >> numero;
}

void Pedido::setData () {
    cout << "Data: ";
    cin >> data;
}

void Pedido::setCliente (Cliente &cliente) {
    this -> cliente = &cliente;
}

void Pedido::addItemPedido (ItemPedido &itemPedido) {
    itensPedidos.push_back(&itemPedido);
}

float Pedido::getPrecoTotal () {
    float valorTotal = 0;
    for (unsigned int i = 0; i < itensPedidos.size(); i++) {
        valorTotal += itensPedidos[i] -> getQuantidade() * itensPedidos[i] -> getPrecoUnitario();
    }
    return valorTotal;
}

int Pedido::getNumero () {
    return numero;
}

string Pedido::getData () {
    return data;
}

ItemPedido Pedido::getItemPedido (int numeroItemPedido) {
    return *itensPedidos[numeroItemPedido];
}

void Pedido::mostra () {
    cout << endl;
    cout << "Numero: " << numero << endl;
    cout << "Data: " << data << endl << endl;
    cout << "Total itens pedidos: " << itensPedidos.size() << endl << endl;
    for (unsigned int i = 0; i < itensPedidos.size(); i++) {
        cout << "Item pedido " << i + 1 << ":";
        itensPedidos[i] -> mostra();
        cout << "Preco total do pedido: " << getPrecoTotal() << endl;
    }
    cout << endl;
}
