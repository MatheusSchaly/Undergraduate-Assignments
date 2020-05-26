#ifndef ABB_H_INCLUDED
#define ABB_H_INCLUDED

template<class T>
class ABB
{
public:
    ABB();
    ~ABB();
    bool ehVazia();
    bool existeElemento(T elemento);
    void insere(T elemento);
    void retira(T elemento);
    void mostra();
private:
    void destroi(Nodo<T>* raiz);
    void retira(Nodo<T>* raiz, T elemento);
    void mostra(Nodo<T>* raiz);

    Nodo<T>* raiz;
};

#endif // ABB_H_INCLUDED
