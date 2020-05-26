#include <iostream>

using namespace std;

// Autor : Matheus Henrique Schaly

int main()

{

    float p1, p2, p3, p4, t1, t2, t3, t4, mediaP, mediaT, mediaF;

    cout << "Forneca as 4 notas de prova:" << endl;
    cin >> p1 >> p2 >> p3 >> p4;
    cout << "Forneca as 4 notas de trabalho:" << endl;
    cin >> t1 >> t2 >> t3 >> t4;

    mediaP = (p1 + p2 + p3 + p4) / 4;
    mediaT = (t1 + t2 + t3 + t4) / 4;
    mediaF = mediaP * 0.8 + mediaT * 0.2;

    if (mediaF >= 6.0)
    {
        cout << "Aprovado." << endl;
    }
    else
    {
        cout << "Nao Aprovado." << endl;
    }

    return 0;

}
