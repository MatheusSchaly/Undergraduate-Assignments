algoritmo "Trabalho.M2.1"

// Autor : Matheus Henrique Schaly
// Data : 14/10/2016

var

   inf, x : vetor [1..15] de real
   i, cont : inteiro
   resPos, resNeg, resFinal : real

inicio

   cont <- 1
   inf[1] <- 1

   escreva ("Forneça o ângulo em graus: ")
   leia (x[1])
   x[1] <- (x[1] * pi / 180)
   
   para i de 1 ate 15 faca
      x[i] <- x[1] ^ cont
      cont <- cont + 2
   fimpara

   para i de 1 ate 14 faca
      inf[i+1] <- inf[i] * (i*2) * (i*2+1)
   fimpara
   
   para i de 1 ate 15 passo 2 faca
      resPos <- resPos + (x[i] / inf[i])
   fimpara
   
   para i de 2 ate 14 passo 2 faca
      resNeg <- resNeg + (x[i] / inf[i])
   fimpara
   
   resFinal <- resPos - resNeg
   
   escreval
   escreval ("O valor do seno é:", resFinal)
   
fimalgoritmo
