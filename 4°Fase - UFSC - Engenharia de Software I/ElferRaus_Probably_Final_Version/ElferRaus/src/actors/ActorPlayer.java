package actors;


import control.ElferRaus;
import model.Player;
import view.GameUI;
import view.HomeUI;
import java.util.ArrayList;
import model.Card;
import model.Move;

/** description: "Projeto de Engenharia de Software 2019.1"
#   authors:
#   "Francisco Luiz Vicenzi",
#   "Matheus Schaly",
#   "Uriel Kindermann"
    Copyright 2019
*/

public class ActorPlayer {
    private HomeUI home_screen;
    private GameUI game_screen;
    private ElferRaus controller_game;
    
    
    public ActorPlayer(ElferRaus controller_game) {
        this.controller_game = controller_game;
        home_screen = new HomeUI(this);
        game_screen = new GameUI(this);
    }
    
    public boolean connect(String name, String server){
        return controller_game.connect(name, server);
    }
    
    public void disconnect() {
        controller_game.disconnect();
    }

    public void sendMessage(String connection_sucessful_) {
        home_screen.sendMessageUI(connection_sucessful_);
    }

    public void initializationUI() {
        home_screen.setVisible(true);
    }
    
    public void buildGameScreen(ArrayList<Player> players) {
        game_screen.init(players);
    }

    public boolean startGame(int number_players) {
        if (controller_game.startGame(number_players)) {
            return true;
        }
        return false;        
    }
    
    public void closeHomeUI(){
        home_screen.setVisible(false);
    }
    
    public void informWinnter(String winner) {
        home_screen.sendMessageUI("The winner is " + winner);
    }
    
    public void enableButtons() {
        
    }
    
    public void sendMove(ArrayList<Card> played_cards, int deck_withdraw, boolean is_distribute, int turn) {
        Move move = new Move(played_cards, deck_withdraw, is_distribute, turn);
        move.setDistribute(true);
        controller_game.getNg_actor().sendMove(move);
    
    }

    public ElferRaus getController_game() {
        return controller_game;
    }

    public void setController_game(ElferRaus controller_game) {
        this.controller_game = controller_game;
    }

    public HomeUI getHome_screen() {
        return home_screen;
    }

    public void setHome_screen(HomeUI home_screen) {
        this.home_screen = home_screen;
    }

    public GameUI getGame_screen() {
        return game_screen;
    }

    public void setGame_screen(GameUI game_screen) {
        this.game_screen = game_screen;
    }

    public void updateUI() {
        this.game_screen.updateUI();
    }

    public void sendWinnerMessage(int id_player) {
        this.game_screen.sendWinnerMessage(id_player);
    }
    
    public void sendScoreMessage(int score) {
        this.game_screen.sendScoreMessage(score);
    }

    public void openHomeUI() {
        this.home_screen.setVisible(true);
    }
    
    
    
  
    
    
    
    
}
