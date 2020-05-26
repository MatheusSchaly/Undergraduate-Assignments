#include <iostream>

using namespace std;

int main()

{
    float B[9], s;
    int i, c;

    s = 0;

    do
    {
        cout << "Forneca n, positivo e par: " << endl;
        cin >> c;
    } while ((c % 2 != 0) || (c < 1));

    cout << "Forneca os valores:" << endl;

    for (i=0 ; i <= (c-1) ; i++)
    {
        cout << i+1 << "° valor: ";
        cin >> B[i];
    }

     for (i = 0 ; i<= (c / 2-1) ; i++)
     {
         s = B[i] - B[c-1-i] + s;
     }

     cout << endl << "A soma e: " << s << endl;

    return 0;

}
