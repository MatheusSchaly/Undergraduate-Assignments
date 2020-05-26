#include <iostream>
#include "Professor.h"
#include "Aluno.h"
#include "Orientacao.h"

using namespace std;

int main()
{
    Professor p1("Professor1");
    Aluno a1("Aluno1", "CC1"), a2("Aluno2", "CC2");
    Orientacao o1(p1, a1, "Titulo1"), o2(p1, a2, "Titulo2");

    p1.setOrientacao(o1);
    p1.setOrientacao(o2);
    a1.setOrientacao(o1);
    a1.setOrientacao(o2);

    o1.mostra();
    o2.mostra();

    return 0;
}
