#ifndef LIVRO_H_INCLUDED
#define LIVRO_H_INCLUDED
#include <iostream>
#include <fstream>
#include <cstring>
using namespace std;

class ItemPedido;

class Livro {
    char ISBN[50], titulo[50], autor[50];
    float preco;
    ItemPedido *itemPedido;
    bool jaPedido = false;
public:
    Livro (char *ISBN = "", char *titulo = "", char *autor = "", float preco = 0, bool jaPedido = false);
    void setISBN ();
    void setTitulo ();
    void setAutor ();
    void setPreco ();
    void setJaPedido (bool jaPedido);
    void setItemPedido (ItemPedido *itemPedido);
    char* getISBN ();
    char* getTitulo ();
    char* getAutor ();
    float getPreco ();
    bool getJaPedido ();
    void mostra ();
    friend ostream& operator << (ofstream& out, Livro &livro);
    friend istream& operator >> (ifstream& in, Livro &livro);
    void grava (ofstream&);
    void recupera (ifstream&);
};


#endif // LIVRO_H_INCLUDED
