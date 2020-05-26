#ifndef NODO_H_INCLUDED
#define NODO_H_INCLUDED

template<class T> class ABB; //encaminha a declaracao da classe ABB

template<class T>
class Nodo
{
    friend class ABB<T>; // ABB eh friend class de Nodo
public:
    Nodo(T elemento);
    T retornaElemento();
    Nodo<T>* retornaSubArvoreEsquerda();
    Nodo<T>* retornaSubArvoreDireita();
    void setaSubArvoreEsquerda(Nodo<T>* subArvoreEsquerda);
    void setaSubArvoreDireita(Nodo<T>* subArvoreDireita);
private:
    T elemento;
    Nodo<T> *subArvoreEsquerda, *subArvoreDireita;
};

#endif // NODO_H_INCLUDED
