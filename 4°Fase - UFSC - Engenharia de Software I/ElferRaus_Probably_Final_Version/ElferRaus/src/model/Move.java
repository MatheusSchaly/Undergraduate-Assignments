/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import br.ufsc.inf.leobr.cliente.Jogada;
import java.util.ArrayList;
import model.Card;

/** description: "Projeto de Engenharia de Software 2019.1"
#   authors:
#   "Francisco Luiz Vicenzi",
#   "Matheus Schaly",
#   "Uriel Kindermann"
    Copyright 2019
*/

public class Move implements Jogada {
    
    private ArrayList<Card> cards;
    private int deck_withdraw;
    private boolean distribute;
    private int turn;
    
    public Move(ArrayList<Card> cards, int deck_withdraw, boolean distribute, int turn) {
        this.cards = cards;
        this.deck_withdraw = deck_withdraw;
        this.distribute = distribute;
        this.turn = turn;
    }

    public int getTurn() {
        return turn;
    }

    public void setTurn(int turn) {
        this.turn = turn;
    }

    public ArrayList<Card> getCards() {
        return cards;
    }

    public void setCards(ArrayList<Card> cards) {
        this.cards = cards;
    }

    public int getDeck_withdraw() {
        return deck_withdraw;
    }

    public void setDeck_withdraw(int deck_withdraw) {
        this.deck_withdraw = deck_withdraw;
    }

    public boolean isDistribute() {
        return distribute;
    }

    public void setDistribute(boolean distribute) {
        this.distribute = distribute;
    }

    
    
    

    
   
}
