#include "ItemPedido.h"

ItemPedido::ItemPedido (Pedido &pedido, float precoUnitario, int quantidade) {
    this -> pedido = &pedido;
    this -> precoUnitario = precoUnitario;
    this -> quantidade = quantidade;
}

void ItemPedido::setPrecoUnitario (float precoUnitario) {
    this -> precoUnitario = precoUnitario;
}

void ItemPedido::setQuantidade (int quantidade) {
    this -> quantidade = quantidade;
}

void ItemPedido::addLivro (Livro &livro) {
    livros.push_back(&livro);
    livro.setItemPedido(this);
    precoUnitario += livro.getPreco();
    quantidade ++;
    // pedido -> addItemPedido(this); // Isso n linka o pedido?
}

float ItemPedido::getPrecoUnitario () {
    return precoUnitario;
}

int ItemPedido::getQuantidade () {
    return quantidade;
}

void ItemPedido::mostra () {
    cout << endl;
    cout << "Preco unitario: " << precoUnitario << endl;
    cout << "Quantidde: " << quantidade << endl << endl;
    cout << "Total livros pedidos: " << livros.size() << endl << endl;
    for (unsigned int i = 0; i < livros.size(); i++) {
        cout << "Livro " << i + 1 << ":";
        livros[i] -> mostra();
    }
}
