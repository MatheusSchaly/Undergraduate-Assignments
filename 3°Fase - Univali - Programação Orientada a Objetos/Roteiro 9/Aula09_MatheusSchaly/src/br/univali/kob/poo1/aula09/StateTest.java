package br.univali.kob.poo1.aula09;

/**
 * Tests the State class.
 * 
 * @author Matheus Schaly
 */
public class StateTest {
    
    private void createState() {
        State s1 = new State("Santa Catarina", "SC");
        System.out.println(s1.toString());

        State s2 = new State("Santa Catarina", "SC");
        System.out.println(s2.toString());
        
        System.out.println("TRUE ==> " + s1.equals(s2));
        System.out.println("TRUE ==> " + s2.equals(s1));
        System.out.println("FALSE ==> " + (s1 == s2));
        
        try {
            State s3 = new State("Santa Catarina", "");
        } catch (IllegalArgumentException e) {
            System.out.println("Exception correctly caught. City without state");
        }
        
        try {
            State s4 = new State("", "SC");
        } catch (IllegalArgumentException e) {
            System.out.println("Exception correctly caught. State without city");
        }
        
    }

    public void run() {
        System.out.printf("\n\n\n******* aula07: StateTest ******** \n\n");
        createState();
    }
    
}
