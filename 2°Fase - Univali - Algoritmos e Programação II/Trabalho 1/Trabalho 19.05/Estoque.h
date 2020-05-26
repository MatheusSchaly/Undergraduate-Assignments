#ifndef ESTOQUE_H_INCLUDED
#define ESTOQUE_H_INCLUDED
#include <iostream>
#include <fstream>
#include "Produtos.h"

using namespace std;

class Estoque {
    Produtos produtos[50];
    int qtdeProdutos;
public:
    Estoque (int qtde = 0){
    qtdeProdutos = qtde;
    }

    void incluiProduto(Produtos p){
    cin >> p;
    if (consultaProduto(p.getNome())){
        cout << "Produto ja existente\n";
    }else{
            produtos[qtdeProdutos]=p;
            qtdeProdutos++;
    }
    cout <<"inclusao confirmada\n";
    }
    bool consultaProduto(string nome){
        int i=0;
        for (i=0; i<qtdeProdutos; i++){
            if (produtos[i].getNome() == nome){
                cout << produtos[i]<<endl;
                return true;
            }
            if (i == qtdeProdutos - 1) {
                cout << "Produto inexistente!!\n";
                return false;
            }
        }

    }
    void relatorio (){
        for (int i=0; i<qtdeProdutos;i++){
            cout << produtos[i]<<endl;
        }
    }
    void grava(ofstream& fout, Produtos p){
        fout.write(reinterpret_cast < const char * > (&p), sizeof(Produtos));
    }
    void recupera(ifstream& fin, Produtos p){
        int i=0;
        while(fin.read(reinterpret_cast <char *> (&p), sizeof(Produtos))){
            i++;
        }
        qtdeProdutos = i;
    }
};

#endif // ESTOQUE_H_INCLUDED
