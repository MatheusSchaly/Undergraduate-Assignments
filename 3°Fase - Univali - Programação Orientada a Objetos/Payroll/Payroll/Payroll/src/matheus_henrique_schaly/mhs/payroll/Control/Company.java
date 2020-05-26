package matheus_henrique_schaly.mhs.payroll.Comapany;

import java.util.*;

/**
 * Manages company's characteristics.
 * 
 * @author Matheus Henrique Schaly
 */
public class Company {

    /**
     * Default constructor
     */
    public Company() {
    }

    /**
     * 
     */
    private String name;

    /**
     * 
     */
    private ArrayList<Department> deparaments;

    /**
     * 
     */
    private Set<Department> departments;


    /**
     * @param name
     */
    public void Company(String name) {
        // TODO implement here
    }

    /**
     * @param departmentName 
     * @param director 
     * @return
     */
    public void addDepartment(String departmentName, Director director) {
        // TODO implement here
        return null;
    }

    /**
     * @param departmentName
     */
    public void removeDepartment(String departmentName) {
        // TODO implement here
    }

    /**
     * @param departmentName 
     * @return
     */
    public Department getDepartment(String departmentName) {
        // TODO implement here
        return null;
    }

    /**
     * @return
     */
    public ArrayList<Department> getAllDepartments() {
        // TODO implement here
        return null;
    }

}