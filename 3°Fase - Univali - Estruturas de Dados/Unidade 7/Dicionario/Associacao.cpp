#include "Associacao.h"

template<class T1, class T2>
Associacao<T1, T2>::Associacao(T1 chave, T2 informacao)
{
    this->chave = chave;
    this->informacao = informacao;
}

template<class T1, class T2>
T1 Associacao<T1, T2>::pegaChave()
{
    return this->chave;
}

template<class T1, class T2>
T2 Associacao<T1, T2>::pegaInformacao()
{
    return this->informacao;
}
