algoritmo "Trabalho.M2.2"

// Autor : Matheus Henrique Schaly
// Data : 17/10/2016

var

A, B, rep : vetor [1..100] de real
quantRep : vetor [1..100] de inteiro
c, c2, n, i : inteiro

inicio

   repita
      escreva ("Forneça n: ")
      leia (n)
   ate (n < 101) e (n > 0)
   
   escreval
   escreval ("Forneça valores, crescente:")

   
   repita
      c <- c + 1
      quantRep[c] <- 0
      escreva (c, "° Vetor: ")
   leia(A[c])
   
      se c > 1 entao
         se (c > 1) e (A[c] < A[c - 1]) entao
            escreval ("Valores devem ser crescentes:")
            c <- c - 1
         senao
            se A[c] = A[c - 1] entao
               se c > 2 entao
                  se A[c - 1] > A[c - 2] entao
                     c2 <- c2 + 1
                     rep[c2] <- A[c]
                     quantrep[c2] <- quantrep[c2] + 1
                  senao
                     quantrep[c2] <- quantrep[c2] + 1
                  fimse
               senao
                  c2 <- c2 + 1
                  rep[c2] <- A[c]
                  quantrep[c2] <- quantrep[c2] + 1
               fimse
            fimse
         fimse
      fimse
      
   ate c = n

   escreval

   para i de 1 ate c2 faca
      escreval("Numero:", rep[i], " repetiu-se", quantrep[i], " vezes.")
   fimpara

   B[1] <- A[1]
   c <- 1
   
   para i de 2 ate n faca
      se A[i] <> A[i - 1] entao
         c <- c + 1
         B[c] <- A[i]
      fimse
   fimpara
   
   escreval
   escreval("Vetor B, sem repetições:")
   
   para i de 1 ate c faca
      escreval(i, "° valor: ", B[i])
   fimpara
   
fimalgoritmo
