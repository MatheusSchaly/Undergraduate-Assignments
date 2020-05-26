package model;

import br.ufsc.inf.leobr.cliente.Jogada;
import java.util.ArrayList;

/** description: "Projeto de Engenharia de Software 2019.1"
#   authors:
#   "Francisco Luiz Vicenzi",
#   "Matheus Schaly",
#   "Uriel Kindermann"
    Copyright 2019
*/

public class Player {

    private final int id;
    private final String name;
    private int points;
    private ArrayList<Card> cards;
    private int number_cards;

    public Player(int id, String name) {
        this.id = id;
        this.name = name;
        this.points = 0;
        ArrayList<Card> cards = new ArrayList();
    }

    public int getId() {
        return id;
    }
    
    public void setCards(ArrayList<Card> cards_) {
        this.cards = cards_;
    }
    
    public ArrayList<Card> getCards() {
        return this.cards;
    }

    public String getName() {
        return name;
    }

    public int getPoints() {
        return points;
    }
    
    public void setPoints(int new_points) {
        this.points = new_points;
    }
    
    public void distributeCards(ArrayList<Card> cards_, int idp, int players_size) {
        int number_cards = 60/players_size;
        int min_range = idp * number_cards;
        int max_range = min_range + number_cards;
        ArrayList<Card> my_cards = new ArrayList();
        for (int i = min_range; i < max_range; i++) {
            my_cards.add(cards_.get(i));
        }
        this.setNumber_cards(number_cards);
        this.setCards(my_cards);        
    }

    public int getNumber_cards() {
        return number_cards;
    }

    public void setNumber_cards(int number_cards) {
        this.number_cards = number_cards;
    }

    public void updateNumber_cards(int to_update) {
        this.number_cards += to_update;
    }
    
    
    
    
    
    
}
