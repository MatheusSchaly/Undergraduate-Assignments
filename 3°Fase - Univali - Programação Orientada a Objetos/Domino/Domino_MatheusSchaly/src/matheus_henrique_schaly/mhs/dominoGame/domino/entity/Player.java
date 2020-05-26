package matheus_henrique_schaly.mhs.dominoGame.domino.entity;

import java.util.*;

/**
 * Description: Manages player's attributes.
 * 
 * @author Matheus Schaly
 */
public class Player {

    /**
     * Player's name.
     */
    private final String name;
    
    /**
     * Player's hand.
     */
    private final ArrayList<Tile> hand = new ArrayList(21);

    /**
     * Player's drew tiles.
     */
    private final ArrayList<Tile> drewTiles = new ArrayList(14);

    /**
     * Player's played tile.
     */
    private Tile playedTile;

    /**
     * Player's points based on his tiles.
     */
    private int points;

    /**
     * True if the player has passed his turn.
     */
    private boolean passed;
    
    /**
     * True is the player is a user.
     */
    private boolean isUser;
    
    
    
    /**
     * Constructor. Initialises player's name
     * 
     * @param name Player's name 
     */
    public Player(String name) {
        this.name = name;
    }

    /**
     * Getter.
     * 
     * @return name Player's name
     */
    public String getName() {
        return name;
    }
    
    /**
     * Getter.
     * 
     * @return Player's hand
     */
    public ArrayList<Tile> getHand() {
        return hand;
    }
    
    /**
     * Getter.
     * 
     * @return Player's drew tiles
     */
    public ArrayList<Tile> getDrewTiles() {
        return drewTiles;
    }
    
    /**
     * Getter.
     * 
     * @return playedTile Player's last played tile
     */
    public Tile getPlayedTile() {
        return playedTile;
    }
    
    /**
     * Setter.
     * 
     * @param playedTile Player's last played tile
     */
    public void setPlayedTile(Tile playedTile) {
        this.playedTile = playedTile;
    }

    /**
     * Getter.
     * 
     * @return Player's points
     */
    public int getPoints() {
        return points;
    }
    
    /**
     * Setter.
     * 
     * @param points Player's points
     */
    public void setPoints(int points) {
        this.points = points;
    }
    
    /**
     * Getter.
     * 
     * @return pass True if the player passed
     */
    public boolean getPassed() {
        return passed;
    }
    
    /**
     * Setter.
     * 
     * @param pass True if the player passed
     */
    public void setPassed(boolean pass) {
        passed = pass;
    }
    
    /**
     * Getter.
     * 
     * @return isUser True if the player is a user
     */
    public boolean getIsUser() {
        return isUser;
    }
    
    /**
     * Setter.
     * 
     * @param isUser True if the player is a user
     */
    public void setIsUser(boolean isUser) {
        this.isUser = isUser;
    }
    
    /**
     * Adds a tile to the player's hand.
     * 
     * @param tile Tile to be added
     */
    public void addHandTile(Tile tile) {
        hand.add(tile);
    }
    
    /**
     * Plays a tile at the table's tile chain. Get a tile from player's
     * hand, removing and then returning it.
     * 
     * @param handTileIndex The hand's tile index
     * @return playerPlayedTile The tile removed from player's hand
     */
    public Tile playTile(int handTileIndex) {
        Tile playerPlayedTile = getHand().get(handTileIndex);
        getHand().remove(handTileIndex);
        setPlayedTile(playerPlayedTile);
        return playerPlayedTile;
    }

    /**
     * Adds a tile to the player's hand and sets it
     * as a draw tile.
     * 
     * @param tile The drew tile
     */
    public void drawTile(Tile tile) {
        getHand().add(tile);
        getDrewTiles().add(tile);
    }
    
    /**
     * Calculates player points based on his or her remaining 
     * hand's tiles.
     * 
     * @return pointSum Sum of all the tiles' points
     */
    public int calculatePoints() {
        int pointsSum = 0;
        for (Tile tile : getHand()) {
            pointsSum += tile.getTotalValue();
        }
        setPoints(pointsSum);
        return pointsSum;
    }
    
    /**
     * Clears the last used tile.
     */
    public void clearUsedTile() {
        setPlayedTile(null);
    }
    
    /**
     * Clears the tiles from player's drew tiles.
     */
    public void clearDrewTiles() {
        getDrewTiles().clear();
    }
    
}