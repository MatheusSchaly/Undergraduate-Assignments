package matheus_henrique_schaly.mhs.dominoGame.main;

import matheus_henrique_schaly.mhs.dominoGame.domino.view.UserIO;

/**
 * Description: Creates and runs the UserIO class.
 * 
 * @author Matheus Schaly
 */
public class DominoGame {

    /**
     * Runs the UserIO class.
     */
    public void run() {
        UserIO userIO = new UserIO();
        userIO.run();
    }
    
    /**
     * Main method.
     * 
     * @param args the command line arguments, not used
     */
    public static void main(String[] args) {
        new DominoGame().run();
    }
    
}
