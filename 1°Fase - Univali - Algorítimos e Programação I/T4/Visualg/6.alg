algoritmo "6"

// Autor : Matheus Henrique Schaly
// Data : 27/10/2016

var

    mat : vetor [1..4,1..7] de real
    tempMed : vetor [1..4] de real
    tempMax : vetor [1..4] de real
    tempMin : vetor [1..4] de real
    maisQuente, maisFrio : real
    i, j, diasAcima, diasAbaixo : inteiro

inicio

      para i de 1 ate 4 faca
           para j de 1 ate 7 faca
                escreva ("Informe o termo", i, j, ": ")
                leia (mat[i, j])
                tempMed[i] <- tempMed[i] + mat[i, j]
                se j = 1 entao
                   tempMax[i] <- mat[i, 1]
                   tempMin[i] <- mat[i, 1]
                fimse
                se (i = 1) e (j = 1) entao
                   maisQuente <- mat[1, 1]
                   maisFrio <- mat[1, 1]
                fimse
                se mat[i, j] > 25 entao
                   diasAcima <- diasAcima + 1
                fimse
                se mat[i, j] < 25 entao
                   diasAbaixo <- diasAbaixo + 1
                fimse
                se tempMax[i] < mat[i, j] entao
                   tempMax[i] <- mat[i, j]
                fimse
                se tempMin[i] > mat[i, j] entao
                   tempMin[i] <- mat[i, j]
                fimse
           fimpara
           se tempMax[i] > maisQuente entao
              maisQuente <- tempMax[i]
           fimse
           se tempMin[i] < maisFrio entao
              maisFrio <- tempMin[i]
           fimse
           tempMed[i] <- tempMed[i] / 7
      fimpara

      escreval

      para i de 1 ate 4 faca
           escreval (i, "° semana:")
           escreval ("Média:", tempMed[i])
           escreval ("Máxima:", tempMax[i])
           escreval ("Mínima:", tempMin[i])
           escreval
      fimpara
      
      escreval ("Dia mais quente:", maisQuente)
      escreval ("Dia mais frio:", maisFrio)
      escreval ("Dias acima de 25°:", diasAcima)
      escreval ("Dias abaixo de 25°:", diasAbaixo)

fimalgoritmo
