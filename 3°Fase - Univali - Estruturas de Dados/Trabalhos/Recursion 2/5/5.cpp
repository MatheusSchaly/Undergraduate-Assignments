/*
 * 5.cpp
 *
 * Author:      Matheus Schaly
 * Created on:  Aug 10, 2017 
 * Description: A	Torre	de	Hanói	é	um	jogo	com	base	histórica	citado	em	um	ritual	praticado	por	sacerdotes
Brâmanes	para	predizer	o	fim	do	mundo.	O	jogo	inicia	com	uma	série	de	anéis	de	ouro	de
tamanhos	decrescentes	empilhados	em	uma	haste.	O	objetivo	é	empilhar	todos	os	anéis	em
uma	segunda	haste	em	ordem	decrescente	de	tamanho.	Antes	que	isto	possa	ser	feito,	o	fim
do	 mundo	 chegará.	 Uma	 terceira	 haste	 está	 disponível	 para	 uso	 como	 armazenamento
intermediário.

	 O	movimento	dos	anéis	é	limitado	pelas	seguintes	regras	:
• somente	um	anel	pode	ser	movido	de	cada	vez;
• um	anel	pode	ser	movido	de	qualquer	haste	para	qualquer	haste;
• um	anel	maior	nunca	pode	ficar	sobre	um	anel	menor.

Elabore	um	procedimento	recursivo	para	solucionar	o	problema	da	Torre	de	Hanói.
 */

#include <iostream>

using namespace std;

void ToH(int dskToMv, int cLocation, int tmpLocation, int fLocation)
{
    if( dskToMv != 0 )
    {
        ToH( dskToMv-1, cLocation, fLocation, tmpLocation );
        cout << cLocation << "->" << fLocation << endl;
        ToH( dskToMv-1, tmpLocation, cLocation, fLocation );
    }
}

int main()
{
    int x;
    cout << "Enter number of disks: ";
    cin >> x;
    ToH(x, 1, 2, 3);
    return 0;
}


