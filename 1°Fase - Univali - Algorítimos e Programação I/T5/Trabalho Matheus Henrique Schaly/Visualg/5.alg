algoritmo "5"

// Autor : Matheus Henrique Schaly
// Data : 05/12/2016

var

   a, b: inteiro

funcao leiaNumDifZero (): inteiro

var

   n: inteiro

inicio

   repita
      escreva ("Forneça um valor diferente de 0: ")
      leia (n)
   ate (n <> 0)
   
   retorne n

fimfuncao

procedimento modDiv (var a, b: inteiro)

var

   aux1, aux2: inteiro

inicio

   aux1 <- a
   aux2 <- b
   a <- aux1 div aux2
   b <- aux1 mod aux2

fimprocedimento

inicio

   escreva ("Forneça o valor de a: ")
   leia (a)
   b <- leiaNumDifZero ()
   modDiv (a, b)
   
   escreval
   escreval ("Valor da divisão é:", a)
   escreval ("Valor do resto é:", b)

fimalgoritmo
