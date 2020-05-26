algoritmo "7"

// Autor : Matheus Henrique Schaly
// Data : 29/10/2016

var

   mat : vetor [1..12,1..10] de inteiro
   custo, venda : vetor [1..10] de real
   custoT, receitaL, receitaB : vetor [1..12] de real
   i, j, n : inteiro



inicio

      repita
            escreva ("Informe quantidade de motores: ")
            leia (n)
      ate (n > 0) e (n < 11)
      
      para i de 1 ate n faca
           escreva ("Informe o custo do motor", i, ": ")
           leia (custo[i])
           escreva ("Informe a preço de venda do motor", i, ": ")
           leia (venda[i])
      fimpara
      
      para i de 1 ate 12 faca
           para j de 1 ate n faca
                repita
                      escreva ("Mês", i, " quantidade de motores", j, ": ")
                      leia (mat[i, j])
                ate mat[i, j] > -1
                custoT[i] <- custoT[i] + custo[j] * mat[i, j]
                receitaB[i] <- receitaB[i] + venda[j] * mat[i, j]
           fimpara
           receitaL[i] <- receitaB[i] - custoT[i]
      fimpara
      
      escreval
      
      para i de 1 ate 12 faca
           escreval (i, "° mês:")
           escreval ("Custo total R$", custoT[i])
           escreval ("Receita bruta R$", receitaB[i])
           escreval ("Receita líquida R$", receitaL[i])
           escreval
      fimpara

fimalgoritmo
