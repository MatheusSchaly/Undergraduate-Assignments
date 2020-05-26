algoritmo "4"

// Autor : Matheus Henrique Schaly
// Data : 03/12/2016

var

   n: inteiro

funcao numRegular (n: inteiro): inteiro

var

   regularidade: inteiro

inicio

   enquanto n mod 2 = 0 faca
      n <- n div 2
   fimenquanto

   enquanto n mod 3 = 0 faca
      n <- n div 3
   fimenquanto
   
   enquanto n mod 5 = 0 faca
      n <- n div 5
   fimenquanto
   
   se n = 1 entao
      retorne 1
   senao
      retorne 0
   fimse
   
fimfuncao

inicio

   escreval ("Forneça um número:")
   leia (n)
   
   se numRegular(n) = 1 entao
      escreval ("Regular.")
   senao
      escreval ("Não regular.")
   fimse

fimalgoritmo
