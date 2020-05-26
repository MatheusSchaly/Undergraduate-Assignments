#include <iostream>
#include "Cliente.h"
#include "Pedido.h"
#include "ItemPedido.h"
#include "Livro.h"

using namespace std;

void encontraCliente (int &clienteIndex, vector <Cliente> clientes) {
    int opcao = 0;
    do {
        cout << "Selecione uma opcao:" << endl << endl;
        cout << "1 - Consultar cliente pelo nome." << endl;
        cout << "2 - Consultar cliente pelo codigo." << endl << endl;
        cin >> opcao;
    } while (opcao < 1 || opcao > 2);

    if (opcao == 1) {
        string nome;
        cout << "Forneca o nome do cliente: ";
        cin.ignore();
        getline(cin, nome);
        cout << endl;
        for (unsigned int i = 0; i < clientes.size(); i++) {
            if (nome.compare(clientes[i].getNome()) == 0) {
                clienteIndex = i;
                break;
            }
        }
        return;
    }
    int codigo;
    cout << "Forneca o codigo do cliente: ";
    cin >> codigo;
    cout << endl;
    for (unsigned int i = 0; i < clientes.size(); i++) {
        if (codigo == clientes[i].getCodigo()) {
            clienteIndex = i;
            break;
        }
    }
    return;
}

int encontraPedidoIndex (int clienteIndex, vector <Cliente> clientes) {
    int numero;
    cout << "Numero do pedido ao qual sera inserido o item pedido: ";
    cin >> numero;
    return clientes[clienteIndex].getPedidoIndex(numero);
}

int main()
{
    vector <Cliente> clientes;
    vector <Livro> livros;
    vector <ItemPedido> itensPedidos;
    vector <Pedido> pedidos;

    // DESCOMENTAR PARA TESTAR:

//    Cliente cliente1(10, "aa", "9999", "matheusmhs");
//    Cliente cliente2(20, "bb", "1010", "blackboard");
//    Cliente cliente3(30, "Criptonita Girafense", "1111", "Cambodja");
//    clientes.push_back(cliente1);
//    clientes.push_back(cliente2);
//
//    Pedido pedido1(cliente1, 11, "06/05/1994");
//    Pedido pedido2(cliente1, 22, "05/06/1994");
//    ItemPedido itemPedido1(pedido1, 10.0, 20);
//    ItemPedido itemPedido2(pedido2, 20.0, 40);
//    pedido1.addItemPedido(itemPedido1);
//    pedido2.addItemPedido(itemPedido2);
//    Livro livro1("4040", "Meu Primeiro Titulo", "Meu Primeiro Autor", 50.50);
//    Livro livro2("5050", "Meu Segundo Titulo", "Meu Segundo Autor", 60.60);
//    Livro livro3("6060", "Meu Terceiro Titulo", "Meu Terceiro Autor", 70.70);
//    livros.push_back(livro1);
//    livros.push_back(livro2);
//    livros.push_back(livro3);
//    itemPedido1.addLivro(livros[0]);
//    itemPedido1.addLivro(livros[1]);
//    itemPedido2.addLivro(livros[2]);
//
//    clientes[0].addPedido(&pedido1);
//    clientes[0].addPedido(&pedido2);

    for (unsigned int i = 0; i < clientes.size(); i++) {
        cout << "Cliente " << i + 1 << ":" << endl;
        clientes[i].mostra();
    }

    int opcao = 0;

    do {
        do  {
            cout << "Selecione uma opcao:" << endl << endl;
            cout << "Cliente:" << endl;
            cout << "1 - Adicionar cliente." << endl;
            cout << "2 - Consultar um cliente." << endl;
            cout << "3 - Relatorio clientes." << endl << endl;
            cout << "Pedido:" << endl;
            cout << "4 - Adicionar pedido." << endl;
            cout << "5 - Relatorio pedidos." << endl << endl;
            cout << "Item Pedido:" << endl;
            cout << "6 - Adicionar item pedido e livro." << endl << endl;
            cout << "Livro:" << endl;
            cout << "7 - Adicionar livro ao acervo." << endl;
            cout << "8 - Relatorio livros." << endl << endl;
            cout << "9 - Recuperar arquivo de clientes." << endl;
            cout << "10 - Gravar arquivo de clientes." << endl;
            cout << "11 - Recuperar arquivo de livros." << endl;
            cout << "12 - Gravar arquivo de livros." << endl;
            cout << "13 - Sair." << endl << endl;
            cin >> opcao;
        } while (opcao < 1 || opcao > 13);

        int clienteIndex = -1;

        switch (opcao) {
            case 1:
                {
                    Cliente novoCliente;
                    novoCliente.setCodigo();
                    novoCliente.setNome();
                    novoCliente.setTelefone();
                    novoCliente.setEmail();
                    clientes.push_back(novoCliente);
                }
            break;
            case 2:
                {
                    encontraCliente(clienteIndex, clientes);

                    if (clienteIndex != -1) {
                        cout << "Cliente existente." << endl;
                        clientes[clienteIndex].mostra();
                    }
                    else {
                        cout << "Cliente inexistente." << endl << endl;
                    }
                }
            break;
            case 3:
                for (unsigned int i = 0; i < clientes.size(); i++) {
                    cout << "Cliente " << i + 1 << ":" << endl << endl;
                    clientes[i].mostra();
                }
            break;
            case 4:
                {
                    encontraCliente(clienteIndex, clientes);
                    if (clienteIndex != -1) {
                        Pedido novoPedido(clientes[clienteIndex]);
                        novoPedido.setNumero();
                        novoPedido.setData();
                        pedidos.push_back(novoPedido);
                    }
                    else {
                        cout << "Cliente inexistente." << endl << endl;
                    }
                }
            break;
            case 5:
                {
                    encontraCliente(clienteIndex, clientes);
                    if (clienteIndex != -1) {
                        clientes[clienteIndex].getPedidos();
                    }
                    else {
                        cout << "Cliente inexistente." << endl << endl;
                    }

                }
            break;
            case 6:
                {

                    encontraCliente(clienteIndex, clientes);
                    int pedidoIndex;

                    if (clienteIndex != -1 ) {
                        pedidoIndex = encontraPedidoIndex(clienteIndex, clientes);
                    }
                    else {
                        cout << endl << "Cliente inexistente." << endl << endl;
                        break;
                    }

                    int livroEscolhido;
                    /*
                    int pedidoIndex;

                    if (pedidos.size() == 0) {
                        cout << "Nao ha pedidos registrados." << endl;
                        break;
                    }

                    do {
                        cout << "Pedidos: " << endl;
                        for (int i = 0; i < pedidos.size(); i++) {
                            cout << "Pedido " << i << ": " << endl;
                            pedidos[i].mostra();
                        }
                        cout << "Selecione um pedido: ";
                        cin >> pedidoIndex;
                        cout << endl;
                    } while (pedidoIndex < 0 || pedidoIndex > pedidos.size() - 1);

                    int livroEscolhido;
                    */
                    if (pedidoIndex != -1) {
                        ItemPedido novoItemPedido(pedidos[pedidoIndex]); // Isso n linka o pedido?
                        // ItemPedido novoItemPedido(clientes[clienteIndex].getPedido(pedidoIndex)); // Isso n linka o pedido?
                        do {
                            inicio:
                            cout << "Escolha livros com disponibilidade 0 (0 para sair):" << endl;
                            for (unsigned int i = 0; i < livros.size(); i++) {
                                cout << "Livro " << i + 1 << ": " << endl;
                                livros[i].mostra();
                            }
                            cout << "Escolha o livro: ";
                            cin >> livroEscolhido;
                            livroEscolhido--;
                            cin.ignore();
                            if (livroEscolhido == -1) {
                                break;
                            }
                            if (livroEscolhido >= livros.size() || livroEscolhido < 0 || livros[livroEscolhido].getJaPedido() == true) {
                                cout << endl << "Livro inexistente." << endl << endl;
                                goto inicio;
                            }
                            cout << endl << "Livro escolhido: " << livroEscolhido + 1;
                            livros[livroEscolhido].mostra();
                            novoItemPedido.addLivro(livros[livroEscolhido]);
                            clientes[clienteIndex].getPedido(pedidoIndex).addItemPedido(novoItemPedido); // Isso n linka o pedido?
                            cout << "Livro comprado com sucesso." << endl << endl;
                        } while (livroEscolhido != -1);

                        itensPedidos.push_back(novoItemPedido);
                        cout << endl << "Seu item pedido final:" << endl;
                        itensPedidos[itensPedidos.size() - 1].mostra();
                        cout << endl << endl;

                    }
                    else {
                        cout << endl << "Pedido inexistente." << endl << endl;
                    }
                }
            break;
            case 7:
                {
                    Livro novoLivro;
                    novoLivro.setISBN();
                    novoLivro.setAutor();
                    novoLivro.setTitulo();
                    novoLivro.setPreco();
                    livros.push_back(novoLivro);
                }
            break;
            case 8:
                for (unsigned int i = 0; i < livros.size(); i++) {
                    cout << "Livro " << i + 1 << ":" << endl;
                    livros[i].mostra();
                }
            break;
            case 9:
                {
                    ifstream in;
                    char nomeArquivo[50];
                    unsigned int quantidadeClientes;
                    Cliente novoCliente;

                    cout << "Nome do arquivo a ser recuperado: ";
                    cin.ignore();
                    gets(nomeArquivo);
                    in.open(nomeArquivo, ios::binary);

                    if (!in) {
                        cout << "Arquivo inexistente." << endl;
                        break;
                    }

                    in.read((char*)&quantidadeClientes, sizeof(quantidadeClientes));

                    if (quantidadeClientes > 0) {
                        cout << "Seu arquivo possui " << quantidadeClientes << " objetos do tipo Cliente: " << endl << endl;
                        for (int i = 0; i < quantidadeClientes; i++) {
                            in >> novoCliente;
                            // novoCliente.recupera(in);
                            clientes.push_back(novoCliente);
                        }
                    }
                    else {
                        cout << "Arquivo nao possui clientes cadastrados." << endl;
                        break;
                    }
                    cout << endl;
                    in.close();
                }
            break;
            case 10:
                {
                    ofstream out;
                    char nomeArquivo[50];
                    unsigned int quantidadeClientes = clientes.size();

                    cout << "Nome do arquivo a ser criado: ";
                    cin.ignore();
                    gets(nomeArquivo);
                    out.open(nomeArquivo, ios::binary);

                    if (!out) {
                        cout << "Nao foi possivel criar seu arquivo." << endl;
                        break;
                    }

                    out.write((char*)&quantidadeClientes, sizeof(quantidadeClientes));
                    for (int i = 0; i < quantidadeClientes; i++) {
                        out << clientes[i];
                    }

                    cout << "Seu arquivo foi criado." << endl;
                    out.close();
                }
                break;
            case 11:
                {
                    ifstream in;
                    char nomeArquivo[50];
                    unsigned int quantidadeLivros;
                    Livro novoLivro;

                    cout << "Nome do arquivo a ser recuperado: ";
                    cin.ignore();
                    gets(nomeArquivo);
                    in.open(nomeArquivo, ios::binary);

                    if (!in) {
                        cout << "Arquivo inexistente." << endl;
                        break;
                    }

                    in.read((char*)&quantidadeLivros, sizeof(quantidadeLivros));

                    if (quantidadeLivros > 0) {
                        cout << "Seu arquivo recuperado " << quantidadeLivros << " objetos do tipo Livro." << endl << endl;
                        for (int i = 0; i < quantidadeLivros; i++) {
                            in >> novoLivro;
                            // novoLivro.recupera(in);
                            livros.push_back(novoLivro);
                        }
                    }
                    else {
                        cout << "Arquivo nao possui livros cadastrados." << endl;
                        break;
                    }
                    cout << endl;
                    in.close();
                }
            break;
            case 12:
                {
                    ofstream out;
                    char nomeArquivo[50];
                    unsigned int quantidadeLivros = livros.size();

                    cout << "Nome do arquivo a ser criado: ";
                    cin.ignore();
                    gets(nomeArquivo);
                    out.open(nomeArquivo, ios::binary);

                    if (!out) {
                        cout << "Nao foi possivel criar seu arquivo." << endl;
                        break;
                    }

                    out.write((char*)&quantidadeLivros, sizeof(quantidadeLivros));
                    for (int i = 0; i < quantidadeLivros; i++) {
                        out << livros[i];
                    }

                    cout << "Seu arquivo foi criado." << endl;
                    out.close();
                }
            break;
        }

    } while (opcao != 13);

    return 0;

}
