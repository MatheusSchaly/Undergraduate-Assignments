Algoritmo "Trabalho.M2.4"

// Autor : Matheus Henrique Schaly
// Data : 17/10/2016

var

   c2, a, j, i, n : inteiro
   x, rep, c : vetor [1..100] de inteiro

inicio

   c[1] <- 0
   
   repita
      escreva("Forneça n: ")
      leia(n)
   ate (n < 101) e (n > 0)

   para i de 1 ate n faca
      escreva(i, "° valor: ")
      leia(x[i])
   fimpara

   para i de 1 ate n faca
      para j de 1 ate n faca
         se x[j] < x[i] entao
            a <- x[j]
            x[j] <- x[i]
            x[i] <- a
         fimse
      fimpara
   fimpara

   i <- 0

   repita
      i <- i + 1
      para j de i + 1 ate n faca
         se x[j] = x[i] entao
            c [c2 + 1] <- c [c2 + 1] + 1
            rep [c2 + 1] <- x[i]
            i <- i + 1
         fimse
      fimpara
         se c[c2 + 1] > 0 entao
            c2 <- c2 + 1
         fimse
   ate i = n

   escreval
   escreval("Vetor decrescente, ordenado:")

   para i de 1 ate n faca
      escreval(i, "° valor: ", x[i])
   fimpara

   escreval
   escreval("Valores repitidos: ")

   para i de 1 ate c2 faca
      escreval("Numero: ", rep[i], " repetiu-se: ", c[i], " vezes.")
   fimpara

fimalgoritmo
