algoritmo "3"

// Autor : Matheus Henrique Schaly
// Data : 03/12/2016

var

   line, col: inteiro

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

procedimento equacaoLinear (line, col: inteiro)

var

   A: vetor [1..10, 1..10] de real
   X: vetor [1..10] de real
   B: vetor [1..10] de real
   resultado: vetor [1..10] de real
   solucao: logico
   i, j: inteiro
   
inicio

   solucao <- verdadeiro

   escreval
   escreval ("Matriz:")
   para i de 1 ate line faca
      para j de 1 ate col faca
         escreva ("Posicao", i, " ", j, ": ")
         leia (A[i,j])
      fimpara
   fimpara
   
   escreval
   escreval ("X:")
   para i de 1 ate col faca
      escreva ("Valor", i, ": ")
      leia (X[i])
   fimpara
   
   escreval
   escreval ("B: ")
   para i de 1 ate line faca
      escreva ("Valor", i, ": ")
      leia (B[i])
   fimpara
   
   para i de 1 ate line faca
      para j de 1 ate col faca
         resultado[i] <- resultado[i] + A[i,j] * X[j]
      fimpara
   fimpara
   
   para i de 1 ate line faca
      se resultado[i] <> B[i] entao
         solucao <- falso
         i <- line
      fimse
   fimpara
   
   escreval
   
   se solucao entao
      escreval ("X é a solução")
   senao
      escreval ("X não é a solução")
   fimse
   
fimprocedimento

inicio

   line <- leiaNumIntIntervalo (1, 10)
   col <- leiaNumIntIntervalo (1, 10)
   equacaoLinear (line, col)

fimalgoritmo
