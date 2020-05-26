#include <iostream>

using namespace std;

int main()
{

    float A [99], B [99], rep [99];
    int c, c2, i,  n, quantrep [99];
    c = -1;
    c2 = -1;

    do
    {
        cout << "Forneça n: "; << endl;
        cin >> n;
    } while (n > 100 || n < 0);

    cout << "Forneça valores, crescente: " << endl;

    do
    {
        c= c + 1;
        quantrep [c] = 0;
        cout << c+1 << "° Vetor: ";
        cin >> A[c];
        if (c > 0)
        {
            if (A[c] < A[c-1])
            {
                cout << "Valores devem ser crescentes:" << endl;
                c = c -1;
            }
            else
            {
                if (A[c] == A[c-1])
                {
                    if (c > 1)
                    {
                        if (A[c-1] > A[c-2])
                        {
                            c2 = c2 + 1;
                            rep[c2] = A[c];
                            quantrep[c2] = quantrep[c2] + 1;
                        }
                        else
                        {
                            quantrep[c2] = quantrep[c2] + 1;
                        }
                    }
                    else
                    {
                        c2 = c2 + 1;
                        rep[c2] = A[c];
                        quantrep[c2] = quantrep[c2] + 1;
                    }
                }
            }
        }
    } while (c != (n-1));

    cout << endl;

    for (i = 0; i <= c2 ; i ++)
    {
        cout << "Numero: " << rep[i] << " repetiu-se " << quantrep[i] << " vezes." << endl;
    }

    B[0] = A[0];
    c = 0;

    for (i=1; i <= (n-1) ; i++)
    {
        if (A[i] != A[i-1])
        {
            c = c + 1;
            B[c] = A[i];
        }
    }

    cout << endl << "Vetor B, sem repetições:" << endl;

    for (i=0; i <= c ;i++)
    {
        cout << i+1 << " valor: " << B[i] << endl;
    }

    return 1;

}
