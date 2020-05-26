algoritmo "Trabalho.M2.5"

// Autor : Matheus Henrique Schaly
// Data : 17/10/2016

var

   j, i, n : inteiro
   A : vetor[0..20] de real
   X, P : vetor[1..5] de real
   
inicio

   repita
      escreva ("Forneça n: ")
      leia (n)
   ate (n < 21) e (n > 0)
   
   escreval
   
   para i de 0 ate n faca
      escreva (i, "° valor: ")
      leia (a[i])
   fimpara
   
   escreval
   
   para i de 1 ate 5 faca
      escreva (i, "° valor de x: ")
      leia (x[i])
   fimpara
   
   para i de 1 ate 5 faca
      p[i] <- 0
      para j de n ate 0 passo -1 faca
         p[i] <- p[i] + a[j] * x [i] ^ j
      fimpara

   escreval
   escreval (i, "° valores:")
   escreval ("P:", p[i])
   escreval ("X:", x[i])
   
   fimpara

fimalgoritmo
