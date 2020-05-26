algoritmo "3.Multiplo"

// Autor : Matheus Henrique Schaly

var

   numero : inteiro

inicio

      escreval("Forneca um numero inteiro entre 1000 e 9999:")
      leia(numero)
      numero <- numero div 100
      
      se (numero < 10) ou (numero > 99) entao
         escreval("Numero invalido.")
      senao
         se (numero mod 4) = 0 entao
            escreval("Eh multiplo de 4.")
         senao
            escreval("Nao eh multiplo de 4.")
         fimse
      fimse
      
fimalgoritmo
