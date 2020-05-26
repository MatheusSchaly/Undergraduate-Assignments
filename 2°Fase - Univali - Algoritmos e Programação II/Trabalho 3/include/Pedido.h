#ifndef PEDIDO_H
#define PEDIDO_H


class Pedido
{
    public:
        Pedido();
        virtual ~Pedido();

        int Getnumero() { return numero; }
        void Setnumero(int val) { numero = val; }
        string Getdata() { return data; }
        void Setdata(string val) { data = val; }

    protected:

    private:
        int numero;
        string data;
};

#endif // PEDIDO_H
