package br.univali.kob.poo1.aula07;

/**
 * Tests the whole address. Which includes address, city and state.
 * 
 * @author Matheus Schaly
 */
public class WholeAddressTest {
    
    private void createWholeAddress() {
        State s1 = new State("Santa Catarina", "SC");
        City c1 = new City("Urubici", s1);
        Address a1 = new Address("Rua1 Bairro1 Numero1", "", c1, "88650-000");
        System.out.println(a1.toString());

        Address a2 = new Address("Rua1 Bairro1 Numero1", "", c1, "88650-000");
        System.out.println(a2.toString());
        
        System.out.println("TRUE ==> " + a1.equals(a2));
        System.out.println("TRUE ==> " + a2.equals(a1));
        System.out.println("FALSE ==> " + (a1 == a2));
        
        try {
            Address a3 = new Address("Rua1 Bairro1", "", c1, "88650-000");
        } catch (IllegalArgumentException e) {
            System.out.println("Exception correctly caught. Address incorrect streetLine1");
        }
        
        try {
            Address a4 = new Address("Rua1 Bairro1 Rua1", "Apto1", null, "88650-000");
        } catch (IllegalArgumentException e) {
            System.out.println("Exception correctly caught. Address without city");
        }
        
        try {
            Address a4 = new Address("Rua1 Bairro1 Rua1", "Apto1", c1, "");
        } catch (IllegalArgumentException e) {
            System.out.println("Exception correctly caught. Address without zipCode");
        }
        
    }

    public void run() {
        System.out.printf("\n\n\n******* aula07: WholeAddressTest ******** \n\n");
        createWholeAddress();
    }
    
}
