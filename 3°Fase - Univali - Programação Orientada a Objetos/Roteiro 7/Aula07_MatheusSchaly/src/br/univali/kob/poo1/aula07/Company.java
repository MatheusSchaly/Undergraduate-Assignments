package br.univali.kob.poo1.aula07;

import java.time.LocalDate;

/**
 * Company's class.
 *
 * @author Matheus Schaly
 */
public class Company implements Contactable {

    /**
     * Default constructor
     */
    public Company() {
    }

    /**
     * Company's name.
     */
    private String name;

    /**
     * Company's email.
     */
    private String email;

    /**
     * Company's date of establishment.
     */
    private LocalDate dateOfEstablishment;

    /**
     * Constructor.
     * 
     * @param name company's name
     * @param email company's email
     * @param dateOfEstablishment company's date of establishment
     */
    public Company(String name, String email, LocalDate dateOfEstablishment) {
        this.name = name;
        this.email = email;
        this.dateOfEstablishment = dateOfEstablishment;
    }

    /**
     * Constructor.
     * 
     * @param name company's name
     * @param email company's email
     * @param dateOfEstablishment company's date of establishment
     */
    public Company(String name, String email, String dateOfEstablishment) {
        this(name, email, LocalDate.parse(dateOfEstablishment, AppConfig.DATE_FORMAT));
    }

    /**
     * Getter.
     * 
     * @return company's name
     */
    public String getName() {
        return name;
    }

    /**
     * Setter.
     * 
     * @param name the company's name
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Getter.
     * 
     * @return the company's email
     */
    @Override
    public String getEmail() {
        return email;
    }

    /**
     * Setter.
     * 
     * @param email 
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * Getter.
     * 
     * @return the company's date of establishment
     */
    public LocalDate getDateOfEstablishment() {
        return dateOfEstablishment;
    }

    /**
     * Setter.
     * 
     * @param dateOfEstablishment the company's date of establishment
     */
    public void setDateOfEstablishment(LocalDate dateOfEstablishment) {
        this.dateOfEstablishment = dateOfEstablishment;
    }

    /**
     * @param obj 
     * @return
     */
    public boolean equals(Object obj) {
        // TODO implement here
        return false;
    }

    /**
     * @return
     */
    public int hashCode() {
        // TODO implement here
        return 0;
    }

    /**
     * @return
     */
    public String toString() {
        // TODO implement here
        return "";
    }

}