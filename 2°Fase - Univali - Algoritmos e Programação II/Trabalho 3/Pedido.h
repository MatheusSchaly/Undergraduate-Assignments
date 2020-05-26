#ifndef PEDIDO_H_INCLUDED
#define PEDIDO_H_INCLUDED
#include <iostream>
#include <vector>
#include "ItemPedido.h"
#include "Cliente.h"
using namespace std;

class Cliente;

class Pedido {
    int numero;
    string data;
    Cliente *cliente;
    vector <ItemPedido*> itensPedidos;
public:
    Pedido (Cliente& cliente, int numero = 0, char * data = "");
    void setNumero ();
    void setData ();
    void setCliente (Cliente &cliente);
    void addItemPedido (ItemPedido &itemPedido);
    float getPrecoTotal ();
    int getNumero ();
    string getData ();
    ItemPedido getItemPedido (int numeroItemPedido);
    void mostra ();
};


#endif // PEDIDO_H_INCLUDED
