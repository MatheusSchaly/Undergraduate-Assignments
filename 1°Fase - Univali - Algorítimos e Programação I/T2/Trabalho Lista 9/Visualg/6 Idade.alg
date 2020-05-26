algoritmo "6 Idade"

// Autor :
// Data : 26/09/2016

var

   idade, pessoas : inteiro
   medIdade : real
   continuidade : caracter

inicio


   enquanto (continuidade <> "N") faca

      escreva ("Forneca idade: ")
      leia (idade)
      
      enquanto (idade <= 0) faca
         escreva ("Idade deve ser maior que 0: ")
         leia (idade)
      fimenquanto
      
         pessoas <- pessoas + 1;
         medIdade <- medIdade + idade;
         
         escreva ("Deseja continuar? S/N: ")
         leia (continuidade)
         
         enquanto ((continuidade <> "N") e (continuidade <> "S")) faca
            escreva ("Incorreto, use S ou N: ")
            leia (continuidade)
         fimenquanto
         
   fimenquanto
   
   escreval ("Media de idade:", medIdade / pessoas)


fimalgoritmo
