package br.univali.kob.poo1.aula06;

import java.time.LocalDate;
import java.time.Period;

/**
 * Base class for hierarchy of people in the academic system.
 * 
 * @author Matheus Schaly
 */
public abstract class Person implements Contactable {
    
    /**
     * Next ID to be used.
     */
    private static int nextId = 1;
    
    /**
     * Person's identification number.
     */
    private int id;

    /**
     * Person's name.
     */
    private String name;

    /**
     * Person's birth date.
     */
    private LocalDate dateOfBirth;
    
    /**
     * Person's email.
     */
    private String email;
    
    
    
    /**
     * Person's constructor to be reutilized by its subclasses.
     * Name and birth date are required.
     * 
     * @param name person's name
     * @param dateOfBirth person's date of birth
     */
    public Person(String name, LocalDate dateOfBirth, String email) {
        this.name = name;
        this.dateOfBirth = dateOfBirth;
        validateState();
        id = nextId++;
    }
    
    /**
     * Person's constructor to be reutilized by its subclasses.
     * Name and birth date are required.
     * 
     * @param name person's name
     * @param dateOfBirth person's date of birth
     */
    public Person(String name, String dateOfBirth, String email) {
        this(name, LocalDate.parse(dateOfBirth, AppConfig.DATE_FORMAT), email);
    }
    
    /**
     * Validates Person state.
     */
    private void validateState() {
        validateId();
        validateName();
        validateDateOfBirth();
    }
    
    /**
     * Validates id.
     */
    private void validateId() {
        if (id < 0) {
            throw new IllegalArgumentException("Id (" + id + ") is out of range [1..]");
        }
    }
    
    /**
     * Validates name.
     */
    private void validateName() {
        if (name.equals("")) {
            throw new IllegalArgumentException("Name is empty");
        }
    }
    
    /**
     * Validates date of birth.
     */
    private void validateDateOfBirth() {
        if (dateOfBirth.isAfter(LocalDate.now())) {
            throw new IllegalArgumentException("Hire date (" + dateOfBirth + ") is out of range [.." + LocalDate.now() + "]");
        }
    }
    
    /**
     * Getter.
     * 
     * @return Employee's identification number
     */
    public int getId() {
        return id;
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
     * @return the person's name
     */
    public String getName() {
        return name;
    }
    
    /**
     * Setter.
     * 
     * @param dataOfBirth the person's birth date
     */
    public void setDateOfBirth(LocalDate dataOfBirth) {
        this.dateOfBirth = dataOfBirth;
    }
    
    /**
     * Getter.
     * 
     * @return the person's birth date
     */
    public LocalDate getDateOfBirth() {
        return dateOfBirth;
    }
    
    /**
     * Calculates person's age based on date of birth
     * and current date.
     * 
     * @return the person's birth date
     */
    public int getAge() {
        Period period = Period.between(dateOfBirth, LocalDate.now());
        return period.getYears();
    }
    
    /**
     * Builds a String with all its attributes and their respective values.
     * 
     * <pre>
     * @code
     * Full_Class_Name {
     *  Attribute = value
     *  Attribute = value
     *  ...
     * }
     * </pre>
     * 
     * @return the object's state (attributes and their values)
     */
    @Override
    public String toString() {
        StringBuilder output = new StringBuilder();
        output.append(this.getClass().getName() + " {" + AppConfig.NEW_LINE);
        output.append(" // Person " + AppConfig.NEW_LINE);
        output.append(" id = " + id + AppConfig.NEW_LINE);
        output.append(" name = " + name + AppConfig.NEW_LINE);
        output.append(" dateOfBirth = " + dateOfBirth.format(AppConfig.DATE_FORMAT) + AppConfig.NEW_LINE);
        output.append(appendToString());
        output.append("}" + AppConfig.NEW_LINE);
        return output.toString();
    }
    
    /**
     * Each Person's subclass has to build the String that will be added to
     * the herited implementation of toString(). Each attribute with its value
     * has to be in a separated line.
     * 
     * @return a set of lines with "attribute = value" that will be added
     * to herited implementation of toString()
     * @see #toString() for details about the line formats
     */
    protected abstract String appendToString();
    
    /**
     * Defines a equivalence relation between the current object and
     * the object passed as parameter. This operation has to comply with the
     * following rules:
     * 
     * 1) Reflective: a.equals(a) is always true.
     * 2) Symmetry: if a.equals(b), then b.equals(a).
     * 3) Transitive: if a.equals(b) and b.equals(c) then a.equals(c).
     * 4) Consistent: if the objects were not modified, the returned value must
     * be always the same.
     * 5) a.equals(null) always returns false.
     * 
     * If the passed object is null, the comparison will fail. If the passed object
     * points to the same address (a == b), the comparison will return success. If the
     * objects do not belong to the same class, the comparison will fail.
     * 
     * @param obj the object to be compared
     * @return true when the object has the same state, false otherwise
     */
    
    @Override
    public boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }
        Person person = (Person)obj;
        return
                id == person.id &&
                (name == person.name || name.equals(person.name)) &&
                (dateOfBirth == person.dateOfBirth || dateOfBirth.equals(person.dateOfBirth));
    }
    
    /**
     * Calculates a integer value from the object's attributes' value (state),
     * using a XOR between its values. This function has to be consistent, that is,
     * if the object's state is not altered, the returned value must always be
     * the same. It also must always keep the rule that a.equals(b), then a.hashCode()
     * must be equal to b.hashCode().
     * 
     * @return person's hashCode
     */
    @Override
    public int hashCode() {
        return id ^ (name.hashCode()) ^ (dateOfBirth.hashCode());
    }
    
    /**
     * Getter.
     * 
     * @return the person's email
     */
    @Override
    public String getEmail() {
        return email;
    }
    
}
