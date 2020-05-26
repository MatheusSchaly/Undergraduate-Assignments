package matheus_henrique_schaly.mhs.payroll.Model;

import java.util.*;

/**
 * Manages director's characteristics.
 * 
 * @author: Matheus Henrique Schaly
 */
public class Director extends Employee {

    /**
     * Default constructor
     */
    public Director() {
    }

    /**
     * Constructor.
     * 
     * @param name 
     * @param email 
     * @param dateOfBirth 
     * @param hireDate 
     * @param terminationDate 
     * @param hoursPerWorkMonth 
     * @param hourlyRate 
     * @param departmentName
     */
    public void Director(String name, String email, LocalDate dateOfBirth, LocalDate hireDate, LocalDate terminationDate, int hoursPerWorkMonth, BigDecimal hourlyRate, String departmentName) {
        // TODO implement here
    }

    /**
     * Calculates director's bonus.
     * 
     * @return
     */
    public Float getDirectorBonus() {
        // TODO implement here
        return null;
    }

    /**
     * Getter.
     * 
     * @return
     */
    public BigDecimal getHourlyPayment() {
        // TODO implement here
        return null;
    }

    /**
     * Getter.
     * 
     * @return
     */
    public BigDecimal getMonthlyPayment() {
        // TODO implement here
        return null;
    }

    /**
     * Calculates director's monthly payment.
     * 
     * @return
     */
    private BigDecimal calculateMonthlyPayment() {
        // TODO implement here
        return null;
    }

}