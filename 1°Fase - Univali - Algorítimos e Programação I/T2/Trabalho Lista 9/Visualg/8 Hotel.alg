algoritmo "8 Hotel"

// Autor :
// Data : 26/09/2016

var

   preco, valorDiaria, taxa1, taxa2, taxa3 : real
   quantDiarias, contasEncerradas, opcao : inteiro
   nome : caracter

inicio

   taxa1 <- 5.00
   taxa2 <- 6.50
   taxa3 <- 7.50
   valorDiaria <- 50.00
   quantDiarias <- 0
   preco <- 0
   contasEncerradas <- 0
   
   repita
   
      escreval
      escreval ("1 - Encerrar a conta de um hospede.")
      escreval ("2 - Verificar numero de contas encerradas.")
      escreval ("3 - Finalizar a execução.")
      leia (opcao)
      
      se (opcao = 1) entao

         contasEncerradas <- contasEncerradas + 1
         escreva ("Forneça nome: ")
         leia (nome)
         
         repita
         escreva ("Forneça a quantidade de diarias: ")
         leia (quantDiarias)
         ate (quantDiarias > 0)
         
         se (quantDiarias < 15) entao
         
            preco <- quantDiarias * valorDiaria + quantDiarias * taxa1
            
         senao
         
            se (quantDiarias > 15) entao
            
               preco <- quantDiarias * valorDiaria + quantDiarias * taxa3
               
            senao
            
               preco <- quantDiarias * valorDiaria + quantDiarias * taxa2
               
            fimse
         fimse
      escreval (nome, ", custo total de:", preco)
      fimse
      
      se (opcao = 2) entao
      
         escreval ("A quantidade de contas encerradas eh de:", contasEncerradas)

      fimse
   ate (opcao = 3)
   
fimalgoritmo
