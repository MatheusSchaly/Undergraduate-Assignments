#ifndef PRODUTOS_H_INCLUDED
#define PRODUTOS_H_INCLUDED
#include <iostream>
#include <fstream>
#include <cstring>

using namespace std;
 class Produtos {
     char nome[50];
     int qtde;
     float precoCusto;
public:
    Produtos(char* n="", int q = 0, float p= 0.00){
        strcpy(nome, n);
        qtde = q;
        precoCusto = p;
    }

    void setNome(char* n){
        strcpy(nome, n);
    }
    void setQtde(int q){
        qtde = q;
    }
    void setPrecoCusto(float p){
        precoCusto = p;
    }
    int getQtde(){
        return qtde;
    }
    float getPrecoCusto(){
        return precoCusto;
    }
    string getNome (){
        return nome;
    }
    void mostra(){
        cout <<"Nome : " << nome<<endl;
        cout <<"Quantidade: "<<qtde<<endl;
        cout <<"Preco de custo: "<<precoCusto<<endl;
    }
    friend ostream& operator<<(ostream& out, Produtos& p){
        p.mostra();
        return out;
    }
    friend istream& operator>>(istream& in, Produtos& p){
        in >> p.nome >> p.qtde >> p.precoCusto;
        return in;
    }
    void grava(ofstream& fout, Produtos p[], int qtde){
        for (int i =0; i<qtde ; i++){
            fout.write(reinterpret_cast < const char * > (&p[i]), sizeof(Produtos));
        }
    }
    void recupera(ifstream& fin, Produtos p[], int &qtde){
        int i=0;
        while(fin.read(reinterpret_cast <char * > (&p[i]), sizeof(Produtos))){
            i++;
        }
        qtde = i;
    }
 };


#endif // PRODUTOS_H_INCLUDED
