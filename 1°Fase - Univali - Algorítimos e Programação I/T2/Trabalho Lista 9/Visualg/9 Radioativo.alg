algoritmo "9 Radioativo"

// Autor :
// Data : 26/09/2016

var

   tempo, meiaVida : inteiro
   massaIni, massaFin : real

inicio

   meiaVida <- 50
   
   repita
   
   escreva ("Forneca a massa em kg: ")
   leia (massaIni)
   massaIni <- massaIni * 1000
   
   ate (massaIni > 0)
   
   escreval ("Massa inicial:", massaIni, " gramas.")
   
   enquanto (massaIni >= 0.5) faca

      tempo <- tempo + 50
      massaIni <- massaIni / 2

   fimenquanto
   
   escreval ("Massa final:", massaIni, "gramas.")
   escreval ("Tempo:", tempo, "segundos.")

fimalgoritmo
