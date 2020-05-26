#ifndef DICIONARIO_H_INCLUDED
#define DICIONARIO_H_INCLUDED

#include <list>

using namespace std;

template<class T1, class T2>
class Dicionario
{
    typedef int (funcaoHash) (T1 chave);
    typedef list< Associacao<T1, T2> > Lista;
private:
    int numeroElementos;
    int tamanho;
    funcaoHash* hash;
    Lista* tabela;
public:
    Dicionario(int tamanho, funcaoHash* hash);
    ~Dicionario();
    int numeroDeElementos();
    bool ehVazio();
    int posicao(T1 chave);
    bool existeElemento(T1 chave);
    void insere(T1 chave, T2 informacao);
    void retira(T1 chave);
    void mostra();
};

#endif // DICIONARIO_H_INCLUDED
