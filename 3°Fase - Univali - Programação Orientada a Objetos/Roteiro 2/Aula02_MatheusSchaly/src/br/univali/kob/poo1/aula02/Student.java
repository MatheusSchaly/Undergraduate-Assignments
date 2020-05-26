package br.univali.kob.poo1.aula02;

import java.time.LocalDate;

/**
 * @author Matheus Schaly
 */

public class Student extends Person {
    
    /**
     * Telescoping pettern.
     * 
     * @param id student's enrollment number
     * @param name student's name
     * @param dateOfBirth student's birth date
     * 
     */
    public Student(int rollNumber, String name, LocalDate dateOfBirth) {
        super(name, dateOfBirth);
        setRollNumber(rollNumber);
        setDropDate(null);
    }
    
        /**
     * Telescoping pettern.
     * 
     * @param id student's enrollment number
     * @param name student's name
     * @param dateOfBirth student's birth date
     * @param enrollmentDate student's first enrollment date
     */
    public Student(int rollNumber, String name, LocalDate dateOfBirth, LocalDate enrollmentDate) {
        this(rollNumber, name, dateOfBirth);
        setEnrollmentDate(enrollmentDate);
    }
         
    /**
     * Student's enrollment number.
     */
    private int rollNumber;
    
    /**
     * Student's first enrollment date.
     */
    private LocalDate enrollmentDate;
    
    /**
     * Student's last enrollment date.
     */
    private LocalDate dropDate;
    
    /**
     * Informs if the student is enrolled or not.
     * 
     * @return current student's situation, registered or not
     */
    public boolean isEnrolled() {
        return dropDate == null;
    }
    
    /**
     * Getter.
     * 
     * @return student's enrollment number
     */
    public int getRollNumber() {
        return rollNumber;
    }
    
    /**
     * Setter.
     * 
     * @param rollNumber student's enrollment number
     */
    public void setRollNumber(int rollNumber) {
        this.rollNumber = rollNumber;
    }
    
    /**
     * Getter.
     * 
     * @return Student's first enrollment date
     */
    public LocalDate getEnrollmentDate() {
        return enrollmentDate;
    }
    
    /**
     * Setter.
     * 
     * @param enrollmentDate student's first enrollment date
     */
    public void setEnrollmentDate(LocalDate enrollmentDate) {
        this.enrollmentDate = enrollmentDate;
    }
    
    /**
     * Getter.
     * 
     * @return Student's last registration date, null if still enrolled
     */
    public LocalDate getDropDate() {
        return dropDate;
    }
    
    /**
     * Setter.
     * 
     * @param dropDate Student's last enrollment date
     */
    public void setDropDate(LocalDate dropDate) {
        this.dropDate = dropDate;
    }
    
}
