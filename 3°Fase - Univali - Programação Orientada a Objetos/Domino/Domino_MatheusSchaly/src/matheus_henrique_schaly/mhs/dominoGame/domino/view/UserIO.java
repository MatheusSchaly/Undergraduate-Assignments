package matheus_henrique_schaly.mhs.dominoGame.domino.view;

import matheus_henrique_schaly.mhs.dominoGame.domino.entity.Player;
import matheus_henrique_schaly.mhs.dominoGame.domino.entity.DominoMatch;
import matheus_henrique_schaly.mhs.dominoGame.lib.io.Console;

/**
 * Description: Receives input and manages output.
 * 
 * @author Matheus Schaly
 */
public class UserIO {

    /**
     * UserIO's domino game.
     */
    private DominoMatch dominoMatch;

    
    /**
     * Getter.
     * 
     * @return Domino game
     */
    public DominoMatch getDominoGame() {
        return dominoMatch;
    }
    
    /**
     * Setter.
     * 
     * @param dominoMatch Domino game
     */
    public void setDominoGame(DominoMatch dominoMatch) {
        this.dominoMatch = dominoMatch;
    }
    
    /**
     * Runs UserIO. Initialises the players and starts the game.
     */
    public void run() {
        int numBots;
        int maxBots = 4;
        boolean userIsPlayer;
        userIsPlayer = Console.askYesNo("Do you want to be a player? ");
        if (userIsPlayer) {
            maxBots--;
        }
        numBots = Console.readIntInterval("Choose number of bots: ", maxBots - 2, maxBots);
        if (userIsPlayer) {
            String userName = Console.readString("Enter your name:");
            setDominoGame(new DominoMatch(numBots, userName));
        }
        else {
            setDominoGame(new DominoMatch(numBots));
        }
        playTurns();
    }

    /**
     * Plays turns (both user and AI) while there is no winner.
     */
    private void playTurns() {
        printEndTurn();
        Player winner = null;
        do {
            if (getDominoGame().getCurrentPlayer().getIsUser()) {
                printPlayerStatus();
                playTurnsUser();
                printEndTurn();
            }
            else {
                playTurnsAI();
                printEndTurn();
            }
            winner = getDominoGame().searchWinner();
            getDominoGame().getCurrentPlayer().clearDrewTiles();
        } while (winner == null);
        System.out.println("\n" + winner.getName() + " is the winner.");
    }
    
    /**
     * Plays AI's turn. Tries its actions until it plays any of them.
     */
    private void playTurnsAI() {
        do {
            for (int tileIndex = 0; tileIndex < getDominoGame().getCurrentPlayer().getHand().size(); tileIndex++) {
                if (getDominoGame().playPlayerTile(tileIndex)) {
                    return;
                }
            }

            if (!getDominoGame().drawPlayerTile()) {
                getDominoGame().passPlayer();
                return;
            }  
        } while (true);
    }

  
    /**
     * Plays user's turn. Prompts the action and checks its availability.
     */
    private void playTurnsUser() {
        int userOption;
        boolean repeatTurn = true;
        while(repeatTurn) {
            userOption = userMenu();
            switch (userOption) {
                case 1:
                    int tilePosition = Console.readIntInterval("Which tile do you want to playTurns? ", 1, getDominoGame().getCurrentPlayer().getHand().size());
                    if (getDominoGame().playPlayerTile(tilePosition - 1)) {
                        repeatTurn = false;
                    }
                    else {
                        System.out.println("Your tile does not fit within the tile chain.");
                    }
                    break;
                case 2:
                    if (getDominoGame().drawPlayerTile()) {
                        printPlayerStatus();
                    }
                    else {
                        System.out.println("You cannot draw a tile either because you have something to playTurns or the boneyard is empty.");
                    }
                    break;
                case 3:
                    if (getDominoGame().passPlayer()) {
                        repeatTurn = false;
                    }
                    else {
                        System.out.println("You cannot pass either because you have something to playTurns or the boneyard is not empty.");
                    }
                    break;
            }
        }
    }
    
    /**
     * Prints player's current status.
     */
    private void printPlayerStatus() {
        System.out.println("\n" + getDominoGame().getCurrentPlayer().getName() + " it is your turn.");
        System.out.println("Your hand : " + getDominoGame().getCurrentPlayer().getHand());
        System.out.println("Table     : " + getDominoGame().getTable().getTilesChain() + "\n");
    }

    /**
     * Prints the last turn's end information.
     */
    private void printEndTurn() {
        System.out.println("\nRound\t: " + getDominoGame().getTable().getRound());
        System.out.println("Player\t: " + getDominoGame().getPreviousPlayer().getName());
        System.out.println("Hand\t: " + getDominoGame().getPreviousPlayer().getHand());
        System.out.println("Drew\t: " + getDominoGame().getPreviousPlayer().getDrewTiles());
        System.out.println("Used\t: " + getDominoGame().getPreviousPlayer().getPlayedTile());
        System.out.println("Table\t: " + getDominoGame().getTable().getTilesChain());
        if (getDominoGame().getDemonstration()) {
            System.out.println("Bonyard\t: " + getDominoGame().getTable().getBoneyard());
        }
    }
    
    /**
     * Prints user's menu and prompts an action.
     * 
     * @return User's decision
     */
    private int userMenu() {
        return Console.readIntInterval("Choose:\n"
                    + "1 - Play a tile.\n"
                    + "2 - Draw a tile.\n"
                    + "3 - Pass.\n", 1, 3);
    }

}