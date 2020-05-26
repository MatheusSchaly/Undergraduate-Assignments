algoritmo "5"

// Autor : Matheus Henrique Schaly
// Data : 24/10/2016

var

   matA, matB, matC, matAux : vetor [1..50,1..50] de inteiro
   i, j, n : inteiro

inicio

      repita
            escreva ("Forneca a ordem da matriz quadrada: ")
            leia (n)
      ate (n > 0) e (n < 51)
      
      escreval
      escreval ("Matriz A:")

      para i de 1 ate n faca
           para j de 1 ate n faca
                escreva ("Informe o termo", i, j, ": ")
                leia (matA[i, j])
           fimpara
      fimpara
      
      escreval
      se i = j entao
           escreval ("Matriz A é simétrica.")
      senao
           escreval ("Matriz A não é simétrica.")
      fimse
      
      para i de 1 ate n faca
           para j de 1 ate n faca
                escreva (matA[i, j], " ")
           fimpara
           escreval
      fimpara
      
      escreval
      escreval ("Matriz B:")
      
      para i de 1 ate n faca
           para j de 1 ate n faca
                escreva ("Informe o termo", i, j, ": ")
                leia (matB[i, j])
           fimpara
      fimpara
      
      escreval
      se i = j entao
           escreval ("Matriz B é simétrica.")
      senao
           escreval ("Matriz B não é simétrica.")
      fimse
      
      para i de 1 ate n faca
           para j de 1 ate n faca
                escreva (matB[i, j], " ")
           fimpara
           escreval
      fimpara
      
      escreval
      escreval ("Matriz resultante da multiplicação:")
      
      para i de 1 ate n faca
           para j de 1 ate n faca
                matC[i, j] <- matA[i, j] * matB[i, j]
                escreva (matC[i, j], " ")
           fimpara
           escreval
      fimpara
      
      escreval
      escreval ("Matriz transposta de A:")
      
      para i de 1 ate n faca
           para j de 1 ate n faca
                matAux[i, j] <- matA[j, i]
                escreva (matAux[i, j], " ")
           fimpara
           escreval
      fimpara
      
      escreval
      escreval ("Matriz transposta de B:")

      para i de 1 ate n faca
           para j de 1 ate n faca
                matAux[i, j] <- matA[j, i]
                escreva (matAux[i, j], " ")
           fimpara
           escreval
      fimpara
      
      // Para simetria, deve ser espelhada:

fimalgoritmo
