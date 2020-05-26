package matheus_henrique_schaly.mhs.payroll.Department;

import java.util.*;

/**
 * Manages department's characteristics.
 * 
 * @author Matheus Henrique Schaly
 */
public class Department {

    /**
     * Default constructor
     */
    public Department() {
    }

    /**
     * Department's name.
     */
    private String name;

    /**
     * Department's director.
     */
    private Director director;

    /**
     * 
     */
    private Set<Employee> employees;


    /**
     * Constructor.
     * 
     * @param name 
     * @param director
     */
    public void Departament(String name, Director director) {
        // TODO implement here
    }

    /**
     * Transfers and employee from one department to another.
     * 
     * @param emoloyeeName 
     * @param employeeName 
     * @return
     */
    public void transferEmployee(String emoloyeeName, String employeeName) {
        // TODO implement here
        return null;
    }

    /**
     * Replaces the current department's director.
     * 
     * @param previousDirectorName 
     * @param directorName 
     * @return
     */
    public void replaceDirector(String previousDirectorName, Director directorName) {
        // TODO implement here
        return null;
    }

    /**
     * Removes an employee.
     * 
     * @param name
     */
    public void removeEmployee(String name) {
        // TODO implement here
    }

    /**
     * Getter.
     * 
     * @return
     */
    public ArrayList<Employee> getAllEmployees() {
        // TODO implement here
        return null;
    }

    /**
     * Getter.
     * 
     * 
     * @param name 
     * @return
     */
    public Employee getByName(String name) {
        // TODO implement here
        return null;
    }

    /**
     * Getter.
     * 
     * 
     * @param position 
     * @return
     */
    public Employee getByPosition(int position) {
        // TODO implement here
        return null;
    }

    /**
     * Getter.
     * 
     * @return
     */
    public int getEmployeeQuantity() {
        // TODO implement here
        return 0;
    }

}