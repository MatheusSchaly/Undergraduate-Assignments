algoritmo "2"

// Autor : Matheus Henrique Schaly
// Data : 04/12/2016

var

   n: inteiro

funcao leiaNumIntIntervalo (inf, sup: inteiro): inteiro

var

   n: inteiro

inicio

   repita
      escreva ("Digite valor no intervalo de", inf, " a", sup, ": ")
      leia (n)
      se (n < inf) ou (n > sup) entao
         escreval ("Valor digitado está fora do intervalo.")
      fimse
   ate (n >= inf) e (n <= sup)

   retorne n

fimfuncao

procedimento numExtenso (n: inteiro)

var

   i: inteiro
   numExtenso: vetor [0..10] de caracter
   
inicio

   numExtenso[0] <- "Zero"
   numExtenso[1] <- "Um"
   numExtenso[2] <- "Dois"
   numExtenso[3] <- "Três"
   numExtenso[4] <- "Quatro"
   numExtenso[5] <- "Cinco"
   numExtenso[6] <- "Seis"
   numExtenso[7] <- "Sete"
   numExtenso[8] <- "Oito"
   numExtenso[9] <- "Nove"
   numExtenso[10] <- "Dez"

   para i de 0 ate 10 faca
      se n = i entao
         escreva (n, "= ", numExtenso[i])
      fimse
   fimpara
   
fimprocedimento

inicio

   n <- leiaNumIntIntervalo (0, 10)
   numExtenso (n)
   
fimalgoritmo
