package matheus_henrique_schaly.mhs.payroll.Model;

import java.util.*;

/**
 * Manages employee's characteristics.
 * 
 * @author Matheus Henrique Schaly
 */
public class Employee {

    /**
     * Default constructor
     */
    public Employee() {
    }

    /**
     * Employee's working hours. If the employee exceeds this limit, he will receive overtime.
     */
    private static int workingHours = 160;

    /**
     * Employee's name.
     */
    private String name;

    /**
     * Employee's date of birth.
     */
    private LocalDate dateOfBirth;

    /**
     * Employee's email.
     */
    private String email;

    /**
     * Employee's hire date.
     */
    private LocalDate hireDate;

    /**
     * Employee's termination date.
     */
    private LocalDate terminationDate;

    /**
     * Employee's working hours per month.
     */
    private int hoursPerWorkMonth;

    /**
     * Employee's hourly payment rate.
     */
    private BigDecimal hourlyRate;

    /**
     * 
     */
    private int baseSalary;

    /**
     * Employee's department name.
     */
    private String departmentName;


    /**
     * Constructor.
     * 
     * @param name 
     * @param email 
     * @param dateOfBirth 
     * @param hireDate 
     * @param terminationDate 
     * @param hoursPerWorkMonth 
     * @param hourlyPayment 
     * @param departmentName
     */
    public void Employee(String name, String email, LocalDate dateOfBirth, LocalDate hireDate, LocalDate terminationDate, int hoursPerWorkMonth, BigDecimal hourlyPayment, String departmentName) {
        // TODO implement here
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
     * @param hourlyPayment
     */
    public void Employee(String name, String email, LocalDate dateOfBirth, LocalDate hireDate, LocalDate terminationDate, int hoursPerWorkMonth, BigDecimal hourlyPayment) {
        // TODO implement here
    }

    /**
     * Getter.
     * 
     * @return
     */
    public String getName() {
        // TODO implement here
        return "";
    }

    /**
     * Setter.
     * 
     * @param name 
     * @return
     */
    public void setName(String name) {
        // TODO implement here
        return null;
    }

    /**
     * Getter.
     * 
     * @return
     */
    public LocalDate getDateOfBirth() {
        // TODO implement here
        return null;
    }

    /**
     * Setter.
     * 
     * @param dateOfBirth 
     * @return
     */
    public void setDateOfBirth(LocalDate dateOfBirth) {
        // TODO implement here
        return null;
    }

    /**
     * Getter.
     * 
     * @return
     */
    public String getEmail() {
        // TODO implement here
        return "";
    }

    /**
     * Setter.
     * 
     * @param email 
     * @return
     */
    public void setEmail(String email) {
        // TODO implement here
        return null;
    }

    /**
     * Getter.
     * 
     * @return
     */
    public LocalDate getHireDate() {
        // TODO implement here
        return null;
    }

    /**
     * Setter.
     * 
     * @param hireDate 
     * @return
     */
    public void setHireDate(LocalDate hireDate) {
        // TODO implement here
        return null;
    }

    /**
     * Getter.
     * 
     * @return
     */
    public LocalDate getTerminationDate() {
        // TODO implement here
        return null;
    }

    /**
     * Setter.
     * 
     * @param terminationDate 
     * @return
     */
    public void setTerminationDate(LocalDate terminationDate) {
        // TODO implement here
        return null;
    }

    /**
     * Getter.
     * 
     * @return
     */
    public String getDepartamentName() {
        // TODO implement here
        return "";
    }

    /**
     * Setter.
     * 
     * @param departamentName 
     * @return
     */
    public void setDepartamentName(String departamentName) {
        // TODO implement here
        return null;
    }

    /**
     * Getter.
     * 
     * @return
     */
    public int getHoursPerWorkMonth() {
        // TODO implement here
        return 0;
    }

    /**
     * Setter.
     * 
     * @param hoursPerWorkMonth 
     * @return
     */
    public void setHoursPerWorkMonth(int hoursPerWorkMonth) {
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
     * Setter.
     * 
     * @param hourlyRate 
     * @return
     */
    public void setHourlyPayment(BigDecimal hourlyRate) {
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
     * Calculates employee's monthly payment.
     * 
     * @return
     */
    protected BigDecimal calculateMonthlyPayment() {
        // TODO implement here
        return null;
    }

}