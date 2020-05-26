algoritmo "1"

// Autor : Matheus Henrique Schaly
// Data : 05/12/2016

var

   matriz: vetor [1..10,1..10] de inteiro
   i, j, cont, n, aux: inteiro

inicio

   repita
      escreva ("Forneça a ordem da matriz: ")
      leia (n)
   ate ((n % 2 <> 0) e (n < 11) e (n > 0))
   
   para i de 1 ate n faca
      para j de 1 ate n faca
         matriz[i,j] <- 0
      fimpara
   fimpara
   
   aux <- n DIV 2 + 1
   matriz[1,aux] <- 1
   cont <- 1
   i <- 1
   j <- aux
   
   repita
   
      i <- i - 1
      j <- j + 1
      cont <- cont + 1
      
      se (i < 1) ou (i > n) entao
         i <- n
      fimse
      
      se (j > n) ou (j < 0) entao
         j <- 1
      fimse
      
      se matriz[i,j] <> 0 entao
         i <- i + 2
         j <- j - 1
         se i > n entao
            i <- i - n
         fimse
         se j < 1 entao
            j <- n
         fimse
      fimse
      
      matriz[i,j] <- cont

   ate cont = n*n
   
   para i de 1 ate n faca
      para j de 1 ate n faca
         escreva (matriz[i,j], "  ")
      fimpara
      escreval
   fimpara

fimalgoritmo
