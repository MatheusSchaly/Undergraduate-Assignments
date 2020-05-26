#ifndef CLIENTE_H_INCLUDED
#define CLIENTE_H_INCLUDED
#include "Pedido.h"
#include <iostream>
#include <vector>
#include <fstream>
#include <cstring>
using namespace std;

class Cliente {
    int codigo;
    char nome[50], telefone[50], email[50];
    vector <Pedido*> pedidos;
public:
    Cliente (int codigo = 0, char *nome = "", char *telefone = "", char *email = "");
    void setCodigo ();
    void setNome ();
    void setTelefone ();
    void setEmail ();
    void addPedido (Pedido *pedido);
    int getCodigo ();
    char* getNome ();
    char* getTelefone ();
    char* getEmail ();
    void getPedidos ();
    int getPedidoIndex (int numero);
    Pedido getPedido (int index);
    int getQuantidade ();
    void mostra ();
    void mostraClientePuro ();
    friend ostream& operator << (ofstream& out, Cliente &cliente);
    friend istream& operator >> (ifstream& in, Cliente &cliente);
    void grava (ofstream&);
    void recupera (ifstream&);
};


#endif // CLIENTE_H_INCLUDED
