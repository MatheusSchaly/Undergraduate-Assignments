package model;


import java.util.ArrayList;
import java.util.Collections;

/** description: "Projeto de Engenharia de Software 2019.1"
#   authors:
#   "Francisco Luiz Vicenzi",
#   "Matheus Schaly",
#   "Uriel Kindermann"
    Copyright 2019
*/

public class Deck {
    private ArrayList<Card> cards;

    public Deck() {
        this.cards = deckInitialization(20);
        this.shuffleDeck();
        
    }

    public ArrayList<Card> getCards() {
        return cards;
    }
    
    public void setCards(ArrayList<Card> cards) {
        this.cards = cards;
    }
    
    private ArrayList<Card> deckInitialization(Integer deck_size) {
        ArrayList<String> colours = new ArrayList();
        ArrayList<Card> cards = new ArrayList();
        colours.add("Red");
        colours.add("Yellow");
        colours.add("Green");
        colours.add("Blue");
        for (int i = 0; i < colours.size(); i++){
            for (int j = 1; j <= deck_size; j++){
                if (!"Red".equals(colours.get(i)) || j != 11) {
                    Card c = new Card(colours.get(i), j);
                    cards.add(c);
                }
            }
        }        
        return cards;
    }
    
    
    
    
    private void shuffleDeck(){
        Collections.shuffle(this.getCards());
        Card r11 = new Card("Red", 11);
        cards.add(0, r11);

    }
    
    public void printpls(){
        System.out.println("-----------------\nDECK:");
        System.out.println(this.cards.size());
        for (int i=0; i < this.getCards().size(); i++) {
            System.out.println(this.cards.get(i).getColour() + " - " + this.cards.get(i).getNumber());
        }
        System.out.println("----------------------------------");
    }
    
    public Deck distributeCards(ArrayList<Player> list_players) {
        int number_cards = 60/list_players.size();
        for (int i = 0; i < list_players.size(); i++) {
            ArrayList<Card> cards_aux = new ArrayList();
            for (int j = 0; j < number_cards; j++) {
                cards_aux.add(this.cards.remove(i));
            }
            list_players.get(i).setCards(cards_aux);
        }
        return this;
    }
    
    public void removePlayerCards(int number_cards) {
        int count = 0;
        while (count < number_cards) {
            this.cards.remove(0);
            count++;
        }
    }
    
    
    
    
}
