Algoritmo "Trabalho.M2.3"

// Autor : Matheus Henrique Schaly
// Data : 17/10/2016

var

i, n, cont : inteiro
B : vetor [1..10] de real
soma : real

inicio

   repita
      escreva ("Forneça n, positivo e par: ")
      leia (n)
   ate (n > 0) e (n mod 2 = 0)
   
   escreval
   escreval("Forneça os valores:")
   
   para i de 1 ate n faca
      escreva (i, "° valor: ")
      leia (B[i])
   fimpara
   
   para i de 1 ate n div 2 faca
      soma <- soma + (B[i] - B[n-i+1]) ^ 3
   fimpara
   
   escreval
   escreval ("A soma é:", soma)

fimalgoritmo
