algoritmo "2.Banco"

// Autor : Matheus Henrique Schaly

var

   saldoM, valorC : real

inicio

      escreval("Forneca seu saldo medio:")
      leia(saldoM)
      
      se saldoM <= 500 entao
         escreval("Seu saldo medio eh: ", saldoM, " e voce nao recebeu credito.")
      senao
         se saldoM <= 1000 entao
            valorC <- 30
            saldoM <- saldoM * 1.30
         senao
            se saldoM <= 3000 entao
               valorC <- 40
               saldoM <- saldoM * 1.40
            senao
               valorC <- 50
               saldoM <- saldoM * 1.50
            fimse
         fimse

      escreval("Seu saldo medio eh:", saldoM, " e seu credito eh:", valorC, "%.")

      fimse

fimalgoritmo
