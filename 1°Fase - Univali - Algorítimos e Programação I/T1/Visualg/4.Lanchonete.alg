algoritmo "4.Lanchonete"

// Autor : Matheus Henrique Schaly

var

   cod1, cod2, cod3 : inteiro
   preco1, preco2, preco3, precoF : real

inicio

   escreval("Informe o codigo 1, 2 e 3:")
   leia(cod1, cod2, cod3)

   se (cod1<1) ou (cod1>4) ou (cod2<5) ou (cod2>6) ou (cod3<7) ou (cod3>9) entao
      escreval("Opcao invalida.")
   senao
      escolha(cod1)
         caso 1
            escreval("Hamburger R$ 4,50;")
            preco1 <- 4.50
         caso 2
            escreval("Chessburger R$ 5,50;")
            preco1 <- 5.50
         caso 3
            escreval("Cachorro quente R$ 4,00;")
            preco1 <- 4.00
         outrocaso
            escreval("Sanduiche R$ 3,50;")
            preco1 <- 3.50
      fimescolha

      escolha(cod2)
         caso 5
            escreval("Refrigerante R$ 1,00;")
            preco2 <- 1.00
         outrocaso
            escreval("Suco de laranja R$ 2,00;")
            preco2 <- 2.00
      fimescolha

      escolha(cod3)
         caso 7
            escreval("Milk shake R$ 1,50.")
            preco3 <- 1.50
         caso 8
            escreval("Sundae R$ 3,00.")
            preco3 <- 3.00
         outrocaso
            escreval("Casquinha R$ 1,00.")
            preco3 <- 1.00
      fimescolha

      precoF <- preco1 + preco2 + preco3
      escreval("O valor total eh R$", precoF, ".")

   fimse

fimalgoritmo
