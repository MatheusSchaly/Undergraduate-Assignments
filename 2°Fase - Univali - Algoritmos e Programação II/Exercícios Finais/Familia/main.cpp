#include <iostream>
#include "Familia.h"
#include "Pessoa.h"

using namespace std;

int main()
{
    Pessoa p;
    Familia f;
    f.setMembro(p);
    f.mostra();

    return 0;
}
