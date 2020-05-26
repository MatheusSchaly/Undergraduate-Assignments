#include "Livro.h"

Livro::Livro (char *ISBN, char *titulo, char *autor, float preco, bool jaPedido) {
    strcpy (this -> ISBN, ISBN);
    strcpy (this -> titulo, titulo);
    strcpy (this -> autor, autor);
    this -> preco = preco;
    this -> jaPedido = jaPedido;
}

void Livro::setISBN () {
    cout << "ISBN: ";
    cin.ignore();
    gets(ISBN);
}

void Livro::setTitulo () {
    cout << "Titulo: ";
    gets(titulo);
}

void Livro::setAutor () {
    cout << "Autor: ";
    gets(autor);
}

void Livro::setPreco () {
    cout << "Preco: ";
    cin >> preco;
    cin.ignore();
}

void Livro::setJaPedido (bool jaPedido) {
    this -> jaPedido = jaPedido;
}

void Livro::setItemPedido (ItemPedido *itemPedido) {
    this -> itemPedido = itemPedido;
    jaPedido = true;
}

char* Livro::getISBN () {
    return ISBN;
}

char* Livro::getTitulo () {
    return titulo;
}

char* Livro::getAutor () {
    return autor;
}

float Livro::getPreco () {
    return preco;
}

bool Livro::getJaPedido () {
    return jaPedido;
}

void Livro::mostra () {
    cout << endl;
    cout << "ISBN: " << ISBN << endl;
    cout << "Titulo: " << titulo << endl;
    cout << "Autor: " << autor << endl;
    cout << "Preco: " << preco << endl;
    cout << "Disponibilidade: " << jaPedido << endl << endl;
}

ostream& operator << (ofstream& out, Livro &livro) {
    livro.grava(out);
    return out;
}

istream& operator >> (ifstream& in, Livro &livro) {
    livro.recupera(in);
    return in;
}

void Livro::grava (ofstream &file) {
    file.write((char*)this, sizeof(Livro));
}

void Livro::recupera (ifstream &file) {
    file.read((char*)this, sizeof(Livro));
    jaPedido = false;
}
