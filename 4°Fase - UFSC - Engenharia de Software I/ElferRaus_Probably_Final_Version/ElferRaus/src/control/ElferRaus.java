package control;


import actors.ActorNetGames;
import actors.ActorPlayer;
import model.Card;
import model.Deck;
import model.Player;
import model.Move;
import model.Vectors;
import java.util.ArrayList;


/** description: "Projeto de Engenharia de Software 2019.1"
#   authors:
#   "Francisco Luiz Vicenzi",
#   "Matheus Schaly",
#   "Uriel Kindermann"
    Copyright 2019
*/

public class ElferRaus {
    private ActorPlayer player;
    private ActorNetGames ng_actor;
    private Move move;
    private Player game_player;
    private ArrayList<Player> list_players = new ArrayList();
    private ArrayList<Vectors> vectors = new ArrayList();
    private Deck deck;

    public ElferRaus() {
//        move = new Move();
        ng_actor = new ActorNetGames(this);
        player = new ActorPlayer(this);
    }

    public ActorPlayer getPlayer() {
        return player;
    }

    public Player getGame_player() {
        return game_player;
    }

    public void setGame_player(Player game_player) {
        this.game_player = game_player;
    }   

    public void setPlayer(ActorPlayer player) {
        this.player = player;
    }

    public ArrayList<Player> getList_players() {
        return list_players;
    }

    public void setList_players(ArrayList<Player> list_players) {
        this.list_players = list_players;
    }

    public ActorNetGames getNg_actor() {
        return ng_actor;
    }

    public void setNg_actor(ActorNetGames ng_actor) {
        this.ng_actor = ng_actor;
    }
    
    public boolean connect(String name, String server){
        boolean cn = ng_actor.connect(name, server);
        if (cn) {
            player.sendMessage("Connection sucessful !");
        }
        return cn;
    }
    
    public void disconnect() {
        ng_actor.disconnect();
        player.sendMessage("Disconnected!");
    }
    
    public boolean startGame(int number_players) {
        return ng_actor.iniciarPartida(number_players);
    }
    
    public void sendMessage(String message) {
        player.sendMessage(message);
    }

    public Move getTable() {
        return move;
    }
    
    public ArrayList<Vectors> initVectors() {
        Vectors v_red = new Vectors("Red");
        Vectors v_green = new Vectors("Green");
        Vectors v_blue = new Vectors("Blue");
        Vectors v_yellow = new Vectors("Yellow");
        vectors.add(v_red);
        vectors.add(v_green);
        vectors.add(v_blue);
        vectors.add(v_yellow);
        return vectors;
    }

    public ArrayList<Vectors> getVectors() {
        return vectors;
    }

    public void setVectors(ArrayList<Vectors> vectors) {
        this.vectors = vectors;
    }

    public void startNewGame(Integer position) {
        System.out.println("JOGADOR: " + ng_actor.getProxy().getNomeJogador() + " - " + position);
        ArrayList<String> players_name = ng_actor.getPlayers(); // adversarios apenas
        int idp = position - 1;
        Player p = new Player(idp, ng_actor.getProxy().getNomeJogador());
        this.setGame_player(p);
        this.list_players.add(p);
        this.list_players = createPlayers(getList_players(), players_name, idp);
        ArrayList<Vectors> vectors = initVectors();

        if (position == 1) {
            deck = new Deck();
            ArrayList<Card> cards = deck.getCards();
            move = new Move(cards, 0, false, 0);
            setMove(move);
            list_players.get(0).distributeCards(cards, idp, list_players.size());
            ng_actor.sendMove(move);
            deck.removePlayerCards(60);
            player.closeHomeUI();
            player.buildGameScreen(this.getList_players());
        }        
    }

    public void initialization() {
        player.initializationUI();
    }
    
    public void treatMove(Move move) {
        int turn = move.getTurn();
        int id_move = turn % getList_players().size();
        int id_player = (turn - 1) % getList_players().size();
        
        System.out.println("id_move: " + id_move + " - id_player: " + id_player);
        if (!move.isDistribute()) {
            Player p_aux = this.getGame_player();
            deck = new Deck();
            System.out.println(Integer.toString(p_aux.getId()));
            this.list_players.get(0).distributeCards(move.getCards(), p_aux.getId(), this.getList_players().size());
            player.closeHomeUI();
            player.buildGameScreen(this.getList_players());
            deck.setCards(move.getCards());
            deck.removePlayerCards(60);
//            System.out.println("Topo no deck INICIO: TREAT " + deck.getCards().get(0).getNumber());

        } else {
            player.sendMessage("Move received!");
            updateVector(move.getCards());
            updateDeck(move.getDeck_withdraw());
            int number_cards = move.getDeck_withdraw() - move.getCards().size();
            move.setDeck_withdraw(0);
            
            int player_number_cards = updatePlayerCard(id_player, number_cards);
            System.out.println("ATUALIZANDO " + id_player + " AGORA COM " + player_number_cards);
            setMove(move);
//            System.out.println("Topo no deck DEPOIS DO MOVE: TREAT " + deck.getCards().get(0).getNumber());
//            deck.printpls();
            player.updateUI();
            player.getGame_screen().setBorders(turn);
            verifyWinner(player_number_cards, id_player);                 
        }
        if (id_move == getList_players().get(0).getId()) {
            player.getGame_screen().enableButtons(true);
        } else {
            player.getGame_screen().enableButtons(false);
        }
    }
    
    public void updateDeck(int deck_withdraw) {
        this.deck.removePlayerCards(deck_withdraw);
    }
    
    
    public void updateVector(ArrayList<Card> cards) {         
        for (int i = 0; i < cards.size(); i++) {
            Card card = cards.get(i);
            switch(card.getColour()) {
                case "Red":
                    if (card.getNumber() < 11) {
                        this.vectors.get(0).setLeft(card.getNumber());
                    }
                    if (card.getNumber() > 11) {
                        this.vectors.get(0).setRight(card.getNumber());
                    }
                    if (card.getNumber() == 11) {
                        this.vectors.get(0).setMiddle(true);
                    }
                    break;
                case "Green":
                    if (card.getNumber() < 11) {
                        this.vectors.get(1).setLeft(card.getNumber());
                    }
                    if (card.getNumber() > 11) {
                        this.vectors.get(1).setRight(card.getNumber());
                    }
                    if (card.getNumber() == 11) {
                        this.vectors.get(1).setMiddle(true);
                    }
                    break;
                case "Blue":
                    if (card.getNumber() < 11) {
                        this.vectors.get(2).setLeft(card.getNumber());
                    }
                    if (card.getNumber() > 11) {
                        this.vectors.get(2).setRight(card.getNumber());
                    }
                    if (card.getNumber() == 11) {
                        this.vectors.get(2).setMiddle(true);
                    }
                    break;
                case "Yellow":
                    if (card.getNumber() < 11) {
                        this.vectors.get(3).setLeft(card.getNumber());
                    }
                    if (card.getNumber() > 11) {
                        this.vectors.get(3).setRight(card.getNumber());
                    }
                    if (card.getNumber() == 11) {
                        this.vectors.get(3).setMiddle(true);
                    }
                    break;
            }
        }
    }

    public Deck getDeck() {
        return deck;
    }

    public void setDeck(Deck deck) {
        this.deck = deck;
    }    
    
    public ArrayList<Player> createPlayers(ArrayList<Player> ps, ArrayList<String> players_name, Integer idp) {
        ArrayList<Integer> idxs = new ArrayList();
        int players_size = players_name.size() + 1;
        int number_cards = 60/players_size;
        idxs.add(idp);
        for (int i = 0; i < players_name.size(); i++){//          
            if (!idxs.contains(i)) {
               Player aux = new Player(i, players_name.get(i));
               aux.setNumber_cards(number_cards);
               ps.add(aux);
               idxs.add(i);
               
            } else {
               Player aux = new Player(i + 1, players_name.get(i)); 
               aux.setNumber_cards(number_cards);
               ps.add(aux);
               idxs.add(i + 1);
            }            
            
        }
        return ps;
    }

    private void setMove(Move move) {
        this.move = move;
    }

    public int updatePlayerCard(int id, int number_cards) {
        for (int i = 0; i < list_players.size(); i++) {
            if (list_players.get(i).getId() == id) {
                list_players.get(i).updateNumber_cards(number_cards);
                return list_players.get(i).getNumber_cards();
            }
        }
        return 666;
    }
    
    public int getFinalScore(){
        ArrayList<Card> cards = list_players.get(0).getCards();
        int score = 0;
        for (int i = 0; i < cards.size(); i++) {
            score += cards.get(i).getNumber();
        }
        return score;
    }

    private void verifyWinner(int player_number_cards, int id_player) {
        if (player_number_cards == 0) {
                int score = getFinalScore();
                player.sendWinnerMessage(id_player);
                player.sendScoreMessage(score);
                System.exit(0);
            }  
    }

}
