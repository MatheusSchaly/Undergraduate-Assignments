package matheus_henrique_schaly.mhs.payroll.Model;

import java.util.*;

/**
 * Manages Freelancer's characteristics.
 * 
 * @author: Matheus Henrique Schaly
 */
public class Freelancer extends Employee {

    /**
     * Default constructor
     */
    public Freelancer() {
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
     */
    public void Freelancer(String name, String email, LocalDate dateOfBirth, LocalDate hireDate, LocalDate terminationDate, int hoursPerWorkMonth, BigDecimal hourlyRate) {
        // TODO implement here
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
     * Calculates freelancer's monthly payment.
     * 
     * @return
     */
    private BigDecimal calculateMonthlyPayment() {
        // TODO implement here
        return null;
    }

}