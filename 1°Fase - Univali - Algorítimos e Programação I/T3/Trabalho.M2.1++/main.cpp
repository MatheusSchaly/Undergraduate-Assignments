#include <iostream>
#include <math.h>

using namespace std;

int main()
{
    float resPos, resNeg, resFinal, inf[14], x[14];
    int i, cont;

    resNeg = 0;
    resPos = 0;
    cont = 1;
    inf[0] = 1;

    cout << "Forneca o angulo em graus: ";
    cin >> (x[0]);
    x[0] = (x[0] * 3.1415 / 180);

    for (i = 0; i < 15; i++)
    {
        x[i] = pow(x[0], cont);
        cont = cont + 2;
    }

    for (i = 0; i < 14; i++)
    {
        inf[i+1] = 1;
        inf[i+1] = inf[i] * (i*2) * (i*2+1);
    }

    for (i = 0; i < 15; i = i + 2)
    {
        resPos = resPos + (x[i] / inf[i]);
    }

    for (i = 1; i < 14; i = i + 2)
    {
        resNeg = resNeg + (x[i] / inf[i]);
    }

    resFinal = resPos - resNeg;

    cout << endl << "O valor de seno e: " << resFinal << endl;

}
