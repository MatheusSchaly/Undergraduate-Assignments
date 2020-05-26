/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.univali.kob.poo1.aula07;

/**
 * Tests the City class.
 * 
 * @author Matheus Schaly
 */
public class CityTest {
    
    private void createCity() {
        State s1 = new State("Santa Catarina", "SC");
        City c1 = new City("Urubici", s1);
        System.out.println(c1.toString());

        State s2 = new State("Santa Catarina", "SC");
        City c2 = new City("Urubici", s2);
        System.out.println(c2.toString());
        
        System.out.println("TRUE ==> " + c1.equals(c2));
        System.out.println("TRUE ==> " + c2.equals(c1));
        System.out.println("FALSE ==> " + (c1 == c2));
        
        try {
            City c3 = new City("Santa Catarina", null);
        } catch (IllegalArgumentException e) {
            System.out.println("Exception correctly caught. Null state");
        }
        
        State s3 = new State("Santa Catarina", "SC");
        try {
            City c4 = new City("", s3);
        } catch (IllegalArgumentException e) {
            System.out.println("Exception correctly caught. City without name");
        }
        
    }

    public void run() {
        System.out.printf("\n\n\n******* aula07: CityTest ******** \n\n");
        createCity();
    }
    
}
