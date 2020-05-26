package matheus_henrique_schaly.mhs.dominoGame.domino.entity;

/**
 * Description: Manages tile's attributes.
 * 
 * @author Matheus Schaly
 */
public class Tile {
    
    /**
     * Tile's left and right values.
     */
    private final int[] values = new int[2];
    
    /**
     * Tile's total value.
     */
    private final int totalValue;
    
    
    
    /**
     * Constructor. Initializes tile's values.
     * 
     * @param leftValue Tile's left value
     * @param rightValue Tile's right value
     */
    public Tile(int leftValue, int rightValue) {
        values[0] = leftValue;
        values[1] = rightValue;
        totalValue = leftValue + rightValue;
    }
    
    /**
     * Getter.
     * 
     * @return Tile's left value
     */
    public int getLeftValue() {
        return values[0];
    }
    
    /**
     * Getter.
     * 
     * @return Tile's right value
     */
    public int getRightValue() {
        return values[1];
    }
    
    /**
     * Setter.
     * 
     * @param leftValue Tile's left value 
     */
    public void setLeftValue(int leftValue) {
        values[0] = leftValue;
    }
    
    /**
     * Setter.
     * 
     * @param rightValue Tile's right value 
     */
    public void setRightValue(int rightValue) {
        values[1] = rightValue;
    }
    
    /**
     * Getter.
     * 
     * @return Tile's total value
     */
    public int getTotalValue() {
        return totalValue;
    }
    
    /**
     * Flips the tile's values.
     */
    public void tileFlip() {
        int aux = getLeftValue();
        setLeftValue(getRightValue());
        setRightValue(aux);
    }

    /**
     * Overrides the toString java's method.
     * 
     * @return The tile with its values
     */
    @Override
    public String toString() {
        return "[" + getLeftValue() + "," + getRightValue() + "]";
    }
    
}