package br.univali.kob.poo1.aula06;

import java.util.Comparator;

/**
 * Class that compares the contact's names.
 * 
 * @author Matheus Schaly
 */
public class ContactableNameComparator implements Comparator<Contactable> {
    
    @Override
    public int compare (Contactable c1, Contactable c2) {
        // On testing, remove the below commentary and follow the comparisons
        System.out.println(c1.getName() + " comparing to " + c2.getName());
        return c1.getName().compareTo(c2.getName());
    }
}
