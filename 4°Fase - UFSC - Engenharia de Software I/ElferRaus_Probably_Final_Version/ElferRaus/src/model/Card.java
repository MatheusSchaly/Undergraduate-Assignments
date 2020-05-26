package model;

import br.ufsc.inf.leobr.cliente.Jogada;

/** description: "Projeto de Engenharia de Software 2019.1"
#   authors:
#   "Francisco Luiz Vicenzi",
#   "Matheus Schaly",
#   "Uriel Kindermann"
    Copyright 2019
*/

public class Card implements Jogada {

    private final String colour;
    private final int number;

    public Card(String colour, int number) {
        this.colour = colour;
        this.number = number;
    }

    public String getColour() {
        return colour;
    }

    public int getNumber() {
        return number;
    }    
}
