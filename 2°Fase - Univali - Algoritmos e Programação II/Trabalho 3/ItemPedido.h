#ifndef ITEMPEDIDO_H_INCLUDED
#define ITEMPEDIDO_H_INCLUDED
#include <iostream>
#include <vector>
#include "Livro.h"
using namespace std;

class Pedido;

class ItemPedido {
    float precoUnitario;
    int quantidade;
    Pedido *pedido;
    vector <Livro*> livros;
public:
    ItemPedido (Pedido& pedido, float precoUnitario = 0, int quantidade = 0);
    void setPrecoUnitario (float precoUnitario);
    void setQuantidade (int quantidade);
    void addLivro (Livro &livro);
    float getPrecoUnitario ();
    int getQuantidade ();
    void mostra ();
};


#endif // ITEMPEDIDO_H_INCLUDED
