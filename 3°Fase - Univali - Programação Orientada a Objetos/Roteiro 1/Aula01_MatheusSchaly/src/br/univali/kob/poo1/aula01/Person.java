package br.univali.kob.poo1.aula01;

import java.time.LocalDate;

/**
 * Base class for hierarchy of people in the academic system.
 */
public class Person {

    /**
     * Default constructor
     */
    public Person() {
    }

    /**
     * Person's name
     */
    private String name;

    /**
     * Person's birth date
     */
    private LocalDate dateOfBirth;

    /**
     * Getter.
     * 
     * @return the person's name
     */
    public String getName() {
        name = "";
        return name;
    }

    /**
     * Setter.
     * 
     * @param name the person's name
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Getter.
     * 
     * @return the person's birth date
     */
    public LocalDate getDateOfBirth() {
        return null;
    }

    /**
     * Setter
     * 
     * @param dataOfBirth the person's birth date
     */
    public void setDateOfBirth(LocalDate dataOfBirth) {
        this.dateOfBirth = dataOfBirth;
    }

}
