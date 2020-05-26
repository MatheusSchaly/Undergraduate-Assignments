package matheus_henrique_schaly.mhs.dominoGame.domino.entity;

import java.util.*;

/**
 * Description: Manages domino game's table.
 * 
 * @author Matheus Schaly
 */
public class Table {

    /**
     * Tables's tile chain.
     */
    private final ArrayList<Tile> tilesChain = new ArrayList(28);
    
    /**
     * Tables's boneyard.
     */
    private final ArrayList<Tile> boneyard = new ArrayList(28);

    /**
     * Table's round.
     */
    private int round;

    

    /**
     * Table's constructor.
     */
    public Table() {
        createBoneyard();
        shuffle();
        round = 1;
    }
    
    /**
     * Getter.
     * 
     * @return tilesChain Table's tile chain
     */
    public ArrayList<Tile> getTilesChain() {
        return tilesChain;
    }
    
    /**
     * Getter.
     * 
     * @return boneyard Table's boneyard
     */
    public ArrayList<Tile> getBoneyard() {
        return boneyard;
    }

    /**
     * Getter.
     * 
     * @return round Table's round
     */
    public int getRound() {
        return round;
    }
    
    /**
     * Setter.
     * 
     * @param round Table's round
     */
    public void setRound(int round) {
        this.round = round;
    }
    
    /**
     * Getter.
     * 
     * @return Tile chain's rightmost tile
     */
    public Tile getChainRightTile() {
        return getTilesChain().get(getTilesChain().size() - 1);
    }
    
    /**
     * Getter.
     * 
     * @return Tile left's leftmost tile
     */
    public Tile getChainLeftTile() {
        return getTilesChain().get(0);
    }
    
    /**
     * Adds tile chain's first tile.
     * 
     * @param tile Table's first tile
     */
    public void addChainFirstTile(Tile tile) {
        getTilesChain().add(tile);
    }

    /**
     * Adds a new tile to tiles chain's right side.
     * 
     * @param tile Tile to be added
     * @return True if tile was added
     */
    public boolean addChainRightTile(Tile tile) {
        if (getChainRightTile().getRightValue() == tile.getLeftValue()) {
            getTilesChain().add(getTilesChain().size(), tile);
            return true;
        }
        return false;
    }

    /**
     * Adds a new tile to tiles chain's left side.
     * 
     * @param tile Tile to be added
     * @return True if tile was added
     */
    public boolean addChainLeftTile(Tile tile) {
        if (getChainLeftTile().getLeftValue() == tile.getRightValue()) {
            getTilesChain().add(0, tile);
            return true;
        }
        return false;
    }
    
    /**
     * Remove a tile from boneyard.
     * 
     * @return drewTile
     */
    public Tile drawBoneyardTile() {
        Tile drewTile = getBoneyard().get(0);
        getBoneyard().remove(0);
        return drewTile;
    }
    
    /**
     * Adds one round to the table.
     */
    public void addRound() {
        setRound(getRound() + 1);
    }
    
    /**
     * Creates the boneyard.
     */
    private void createBoneyard() {
        for (int i = 0; i < 7; i++) {
            for (int j = i; j < 7; j++) {
                getBoneyard().add(new Tile(i, j));
            }
        }
    }

    /**
     * Shuffles table's tiles.
     */
    private void shuffle() {
        Collections.shuffle(getBoneyard());
    }

}