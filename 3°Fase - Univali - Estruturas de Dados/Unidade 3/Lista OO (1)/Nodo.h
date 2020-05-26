#ifndef NODO_H_INCLUDED
#define NODO_H_INCLUDED

class Nodo{
    private:
        int elemento;
        Nodo* proximo;
    public:
        Nodo(int elemento);
        void setaElemento(int elemento);
        void setaProximo(Nodo* nodo);
        int pegaElemento();
        Nodo* pegaProximo();
};

#endif // NODO_H_INCLUDED
