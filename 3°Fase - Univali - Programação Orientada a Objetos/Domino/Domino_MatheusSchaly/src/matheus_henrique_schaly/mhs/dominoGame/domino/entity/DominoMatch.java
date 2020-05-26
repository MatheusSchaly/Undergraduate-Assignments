package matheus_henrique_schaly.mhs.dominoGame.domino.entity;

import java.util.*;

/**
 * Description: Connects and manages table, player and UserIO classes.
 * 
 * @author Matheus Schaly
 */
public class DominoMatch {
    
    /**
     * Turn's current player.
     */
    private Player currentPlayer;
    
    /**
     * Turn's previous player.
     */
    private Player previousPlayer;

    /**
     * Domino's number of players.
     */
    private final int numPlayers;

    /**
     * Domino's table.
     */
    private final Table table = new Table();

    /**
     * Domino's players. Includes the user.
     */
    private final ArrayList<Player> players;
    
    /**
     * Domino's demonstrative mode. True if only AI.
     */
    private final boolean demonstration;
    
    
    
    /**
     * Constructor. Initializes player's hands and plays
     * the first tile.
     * 
     * @param numAI AI's quantity
     */
    public DominoMatch(int numAI) {
        demonstration = true;
        players = new ArrayList(numAI);
        createAI(numAI);
        numPlayers = numAI;
        createsPlayersHand();
        playFirstTile();
    }
    
    /**
     * Constructor. Initializes player's hands, plays
     * the first tile and set the user's name.
     * 
     * @param name User name
     * @param numAI AI's quantity
     */
    public DominoMatch(int numAI, String name) {
        demonstration = false;
        players = new ArrayList(numAI);
        createAI(numAI);
        players.add(new Player(name));
        numPlayers = numAI + 1;
        players.get(numPlayers - 1).setIsUser(true);
        createsPlayersHand();
        playFirstTile();
    }
    
    /**
     * Getter.
     * 
     * @return CurrentPlayer Turn's current player
     */
    public Player getCurrentPlayer() {
        return currentPlayer;
    }
    
    /**
     * Setter.
     * 
     * @param currentPlayer Turn's current player
     */
    public void setCurrentPlayer(Player currentPlayer) {
        this.currentPlayer = currentPlayer;
    }
    
    /**
     * Getter.
     * 
     * @return Turn's previous player
     */
    public Player getPreviousPlayer() {
        return previousPlayer;
    }
    
    /**
     * Setter.
     * 
     * @param previousPlayer Turn's previous player
     */
    public void setPreviousPlayer(Player previousPlayer) {
        this.previousPlayer = previousPlayer;
    }
    
    /**
     * Getter.
     * 
     * @return numPlayers Domino's of players
     */
    public int getNumPlayers() {
        return numPlayers;
    }

    /**
     * Getter.
     * 
     * @return table Dominos's table
     */
    public Table getTable() {
        return table;
    }

    /**
     * Getter.
     * 
     * @return players Domino's players
     */
    public ArrayList<Player> getPlayers() {
        return players;
    }
    
    /**
     * Getter.
     * 
     * @return Domino's demonstration mode
     */
    public boolean getDemonstration() {
        return demonstration;
    }
    
    /**
     * Creates the domino's AI by creating its names and
     * putting them at player's array.
     * 
     * @param numAI AI's quantity
     */
    private void createAI(int numAI) {
        String botNames[] = {"Roy Batty", "Leaon Kowalski", "Pris Stratton", "Zhora Salome"};
        for (int i = 0; i < numAI; i++) {
            getPlayers().add(new Player(botNames[i]));
        }
    }
    
    /**
     * Creates the players' hand, allocating the
     * table's tile one by one.
     */
    private void createsPlayersHand() {
        for (int i = 0; i < getNumPlayers(); i++) {
            for (int j = 0; j < 7; j++) {
                getPlayers().get(i).addHandTile(getTable().drawBoneyardTile());
            }
        }
    }
    
    /**
     * Selects the player that plays the first tile and plays it.
     */
    private void playFirstTile() {
        Tile playedTile;
        for (int i = 6; i != -1; i--) {
            for (int j = 0; j < getNumPlayers(); j++) {
                for (int k = 0; k < getPlayers().get(j).getHand().size(); k++) {
                    if (getPlayers().get(j).getHand().get(k).getLeftValue() == i && getPlayers().get(j).getHand().get(k).getRightValue() == i) {
                        playedTile = getPlayers().get(j).playTile(k);  
                        getTable().addChainFirstTile(playedTile);
                        setCurrentPlayer(getPlayers().get(j));
                        moveToNextPlayer();
                        return;
                    }
                }
            }
        }
        for (int i = 5; i > -1; i--) {
            for (int j = 6; j > i - 1; j--) {
                if (j != i) {
                     for (int k = 0; j < getNumPlayers(); j++) {
                         for (int l = 0; l < getPlayers().get(k).getHand().size(); l++) {
                            if (getPlayers().get(k).getHand().get(l).getLeftValue() == i && getPlayers().get(k).getHand().get(l).getRightValue() == j) {
                                playedTile = getPlayers().get(j).playTile(k);  
                                getTable().addChainFirstTile(playedTile);
                                setCurrentPlayer(getPlayers().get(k));
                                moveToNextPlayer();
                                return;
                            }
                        }
                    }
                }
            }
        }
    }
    
    /**
     * Plays a tile for the player, add a tile to tile chain.
     * 
     * @param tileIndex The player's hand tile index
     * @return True if the tile was played
     */
    public boolean playPlayerTile(int tileIndex) {      
        if (checkPlayedTile(tileIndex)) {
            Tile playerPlayedTile = getCurrentPlayer().playTile(tileIndex);
            if (!getTable().addChainRightTile(playerPlayedTile)) {
                getTable().addChainLeftTile(playerPlayedTile);
            }
            getTable().addRound();
            moveToNextPlayer();
            return true;
        }
        return false;
    }
    
    /**
     * Checks if a tile can be played.
     * 
     * @param tileIndex The player's hand tile index
     * @return True if the tile can be played
     */
    private boolean checkPlayedTile(int tileIndex) {
        for (int i = 0; i < 2; i++) {
            if (getTable().getChainLeftTile().getLeftValue() == getCurrentPlayer().getHand().get(tileIndex).getRightValue() ||
                    getTable().getChainRightTile().getRightValue() == getCurrentPlayer().getHand().get(tileIndex).getLeftValue()) {
                return true;
            }
            getCurrentPlayer().getHand().get(tileIndex).tileFlip();
        }
        return false;
    }
       
    /**
     * Draws a tile for the player, remove a tile from boneyard.
     * 
     * @return True if player drew a tile
     */
    public boolean drawPlayerTile() {
        if (checkDrawTile()) {
            Tile drewTile = getTable().drawBoneyardTile();
            getCurrentPlayer().drawTile(drewTile);
            return true;
        }
        return false;
    }
    
    /**
     * Checks if a tile could be played.
     * 
     * @return True if the tile can be draw
     */
    private boolean checkDrawTile() {
        if (getTable().getBoneyard().isEmpty()) {
            return false;
        }
        for (int i = 0; i < getCurrentPlayer().getHand().size(); i++) {
            if (checkPlayedTile(i)) {
                return false;
            }
        }
        return true;
    } 
    
    /**
     * Passes the player's turn.
     * 
     * @return True if player passed
     */
    public boolean passPlayer() {
        if (checkPass()) {
            getCurrentPlayer().setPassed(true);
            getCurrentPlayer().clearUsedTile();
            getTable().addRound();
            moveToNextPlayer();
            return true;
        }
        return false;        
    }
    
    /**
     * Checks if player could pass the turn.
     * 
     * @return True if player could pass
     */
    private boolean checkPass() {
        for (int i = 0; i < getCurrentPlayer().getHand().size(); i++) {
            if (checkPlayedTile(i)) {
                return false;
            }
        } 
        return getTable().getBoneyard().isEmpty();
    } 
    
    /**
     * Moves to the next player's turn and set the previous player.
     */
    private void moveToNextPlayer() {
        setPreviousPlayer(getCurrentPlayer());
        if (getPlayers().indexOf(getCurrentPlayer()) == (getPlayers().size() - 1)) {
            setCurrentPlayer(getPlayers().get(0));
        }
        else {
            setCurrentPlayer(getPlayers().get(getPlayers().indexOf(getCurrentPlayer()) + 1));
        }
    }
    
    /**
     * Searches if the match has a winner. Firstly checking if the current player's hand
     * is empty and then it checks if all players passed (the game is stuck) and calculates
     * their values to find the winner.
     * 
     * @return The match's winner
     */
    public Player searchWinner() {
        if (getPreviousPlayer().getHand().isEmpty()) {
            getTable().addRound();
            return getPreviousPlayer();
        }
        for (int playerIndex = 0; playerIndex < getNumPlayers(); playerIndex++) {
            if (!getPlayers().get(playerIndex).getPassed()) {
                return null;
            }
        }
        ArrayList<Integer> playerPoints = new ArrayList(getNumPlayers());
        for (int playerIndex = 0; playerIndex < getNumPlayers(); playerIndex++) {
            playerPoints.add(getPlayers().get(playerIndex).calculatePoints());
        }
        
        for (int playerIndex = 0; playerIndex < getNumPlayers(); playerIndex++) {
            if (getPlayers().get(playerIndex).getPoints() == Collections.min(playerPoints)) {
                getTable().addRound();
                setPreviousPlayer(getCurrentPlayer());
                return getPlayers().get(playerIndex);
            }
        }  
        return null;
    }

}