algoritmo "5.Carro"

// Autor : Matheus Henrique Schaly

var

   percurso, gasolina : real
   carro : caracter

inicio

      escreval("Forneca seu carro, A, B ou C; e o percurso em quilometros:")
      leia(carro, percurso)
      
      se (carro < "A") ou (carro > "C") ou (percurso <= 0) entao
         escreval("Dados incorretos.")
      senao
         se carro = "A" entao
            gasolina <- 8
         senao
            se carro = "B" entao
               gasolina <- 9
            senao
               gasolina <- 12
            fimse
         fimse

      escreval("A gasolina necessaria para seu percurso eh:", percurso / gasolina, " L.")

      fimse

fimalgoritmo
