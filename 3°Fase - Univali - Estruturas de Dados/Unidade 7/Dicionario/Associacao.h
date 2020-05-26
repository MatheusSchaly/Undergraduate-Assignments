#ifndef ASSOCIACAO_H_INCLUDED
#define ASSOCIACAO_H_INCLUDED

template<class T1, class T2>
class Associacao {
public:
    Associacao(T1 chave, T2 informacao);
    T1 pegaChave();
    T2 pegaInformacao();
private:
    T1 chave;
    T2 informacao;
};

#endif // ASSOCIACAO_H_INCLUDED
