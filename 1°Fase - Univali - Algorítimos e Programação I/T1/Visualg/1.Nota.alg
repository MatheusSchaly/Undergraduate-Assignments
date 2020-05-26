algoritmo "1.Nota"

// Autor : Matheus Henrique Schaly

var

   p1, p2, p3, p4, t1, t2, t3, t4, mediaP, mediaT, mediaF : real

inicio

      escreval("Forneca as 4 notas de prova:")
      leia(p1, p2, p3, p4)
      escreval("Forneca as 4 notas de trabalho:")
      leia(t1, t2, t3, t4)
      
      mediaP <- (p1 + p2 + p3 + p4) / 4
      mediaT <- (t1 + t2 + t3 + t4) / 4
      mediaF <- mediaP * 0.8 + mediaT * 0.2
      
      se mediaF >= 6.0 entao
         escreval("Aprovado.")
      senao
         escreval("Nao Aprovado.")
      fimse

fimalgoritmo
