algoritmo "LM2ex3"
var
i,cont : inteiro
aux1,aux2 : vetor[1..50] de real
soma : real
inicio
escreval("Forneça os valores a seguir")
para i de 1 ate 50 faca
   escreva(i,"° Valor: ")                        //Primeira metade do vetor
   leia(aux1[i])
fimpara
cont <- 51
i <- 1
para i de 51 ate 100 faca                        //Segunda metade do vetor
   cont <- cont - 1
   escreva(i,"° Valor: ")
   leia(aux2[cont])
fimpara
soma <- 0
para i de 1 ate 50 faca
   soma <- soma + (aux1[i]-aux2[i])              //Soma dos termos
fimpara
escreval("Soma dos termos: ",soma)
fimalgoritmo
