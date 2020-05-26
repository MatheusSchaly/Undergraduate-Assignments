package br.univali.kob.poo1.aula04;

import java.time.LocalDate;

/**
 * @author Matheus Schaly
 */

public class Student extends Person {
    
    /**
     * Student's enrollment number.
     */
    private int enrollmentNumber;
    
    /**
     * Student's first enrollment date.
     */
    private LocalDate enrollmentDate;
    
    /**
     * Student's last enrollment date.
     */
    private LocalDate dropDate;
    
    
    
    /**
     * Constructor.
     * @param enrollmentNumber student's enrollment number
     * @param name student's name
     * @param dateOfBirth student's birth date
     * @param enrollmentDate student's first enrollment date
     */
    public Student(int enrollmentNumber, String name, LocalDate dateOfBirth, LocalDate enrollmentDate) {
        super(name, dateOfBirth);
        this.enrollmentNumber = enrollmentNumber;
        this.enrollmentDate = enrollmentDate;
        this.dropDate = null;
        validateState();
    }
    
    /**
     * Validates Student state.
     */
    private void validateState() {
        validateRollNumber();
        validateEnrollmentDate();
    }
    
    /**
     * Validates enrollment number.
     */
    private void validateRollNumber() {
        if (enrollmentNumber < 0) {
            throw new IllegalArgumentException("Roll Number (" + enrollmentNumber + ") is out of range [1..]");
        }
    }
    
    /**
     * Validates enrollment date.
     */
    private void validateEnrollmentDate() {
        if (enrollmentDate.isAfter(LocalDate.now())) {
            throw new IllegalArgumentException("Enrollment Date (" + enrollmentDate + ") is out of range [.." + LocalDate.now() + "]");
        }
    }
    
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
    public int getEnrollmentNumber() {
        return enrollmentNumber;
    }
    
    /**
     * Setter.
     * 
     * @param enrollmentNumber student's enrollment number
     */
    public void setEnrollmentNumber(int enrollmentNumber) {
        this.enrollmentNumber = enrollmentNumber;
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
