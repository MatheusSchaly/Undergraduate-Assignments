#include <iostream>
#include "Produtos.h"
#include "Estoque.h"

using namespace std;

int main()
{
    int escolha;
    Estoque E, E2;
    Produtos aux;
    string nome;
    ofstream fout("Estoque.txt");

    do{
    do{
        cout << "1. Para adicionar um novo produto\n";
        cout <<"2. Procurar por um produto\n";
        cout <<"3. Para mostrar os produtos disponiveis \n";
        cout <<"4. Ler os arquivos binarios\n";
        cout <<"0. Desligar o programa\n";
        cout <<"Escolha: ";
        cin >>escolha;
        cout << endl;
    }while( escolha < 0 || escolha > 4);

    if (escolha ==1){

        E.incluiProduto(aux);
        E.grava(fout, aux);
        cout << endl;
        }else{
            if(escolha == 2){

                cout <<"Determine o nome do produto: ";
                cin >> nome;
                E.consultaProduto(nome);
            }else{
                if(escolha == 3){
                E.relatorio();
                }else{
                if(escolha == 4){
                    ifstream fin("Estoque.txt");
                    E.recupera(fin, aux);
                    E.relatorio();
                }
            }
        }
        }
    }while(escolha != 0);
    }

