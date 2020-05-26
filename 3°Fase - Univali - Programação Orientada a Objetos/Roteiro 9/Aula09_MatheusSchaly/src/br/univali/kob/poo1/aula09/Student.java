package br.univali.kob.poo1.aula09;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 * Student's class.
 * 
 * @author Matheus Schaly
 */

public class Student extends Person {
    
    /**
     * Student's first enrollment date.
     */
    private LocalDate enrollmentDate;
    
    /**
     * Student's last enrollment date.
     */
    private LocalDate dropDate;
    
    /**
     * Class enrollments where the student is or was enrolled.
     */
    private List<Enrollment> enrollments = new ArrayList<>();
    
    
    /**
     * Constructor.
     * @param name student's name
     * @param dateOfBirth student's birth date
     * @param email student's email
     * @param enrollmentDate student's first enrollment date
     * @param address student's address
     */
    public Student(String name, LocalDate dateOfBirth, String email, LocalDate enrollmentDate, Address address) {
        super(name, dateOfBirth, email, address);
        this.enrollmentDate = enrollmentDate;
        this.dropDate = null;
        validateState();
    }
    
    /**
     * Constructor.
     * @param name student's name
     * @param dateOfBirth student's birth date
     * @param email student's email
     * @param enrollmentDate student's first enrollment date
     * @param address student's address
     */
    public Student(String name, String dateOfBirth, String email, String enrollmentDate, Address address) {
        this(name, LocalDate.parse(dateOfBirth, AppConfig.DATE_FORMAT), 
                email, LocalDate.parse(enrollmentDate, AppConfig.DATE_FORMAT), address);
    }
    
    /**
     * Validates Student state.
     */
    private void validateState() {
        validateEnrollmentDate();
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
    
    @Override
    protected String appendToString() {
        StringBuilder output = new StringBuilder();
        output.append(" // Student " + AppConfig.NEW_LINE);
        output.append(" enrollmentDate = " + enrollmentDate.format(AppConfig.DATE_FORMAT) + AppConfig.NEW_LINE);
        output.append(" dropDate = ");
        output.append(((dropDate == null) ? null : dropDate.format(AppConfig.DATE_FORMAT)) + AppConfig.NEW_LINE);
        return output.toString();
    }
    
    @Override
    public boolean equals(Object obj) {
        if (!super.equals(obj)) {
            return false;
        }
        Student student = (Student)obj;
        return
                (enrollmentDate == student.enrollmentDate || enrollmentDate.equals(student.enrollmentDate));
    }
    
    @Override
    public int hashCode() {
        return
                super.hashCode() ^
                enrollmentDate.hashCode();
    }
    
    /**
     * @return All student's class enrollments
     */
    public List<Enrollment> getEnrollments() {
        return enrollments;
    }
    
    /**
     * @param aClass the student's enrollment class
     * @return class' enrollment of this student, null if the class
     * is/was not enrolled in this student
     */
    public Enrollment getEnrollment(Class aClass) {
        for (Enrollment enrollment: enrollments) {
            if (enrollment.getAClass() == aClass) {
                return enrollment;
            }
        }
        return null;
    }
    
    /**
     * Enrolls this student in a class.
     * 
     * @param enrollment the enrollment to be added
     */
    public void addEnrollment(Enrollment enrollment) {
        validateEnrollment(enrollment);
        if (!enrollments.contains(enrollment)) {
            enrollments.add(enrollment);
            enrollment.getAClass().addEnrollment(enrollment);
        }
    }
    
    /**
     * Validates if the enrollment's student is the same as this.
     * 
     * @param enrollment the enrollment to be validate
     */
    private void validateEnrollment(Enrollment enrollment) {
        if (enrollment.getStudent() != this) {
            throw new IllegalArgumentException("Expected student " + this + " but other have been sent " + enrollment.getStudent());
        }
    }
    
    /**
     * Removes the class' enrollment of a student.
     * 
     * @param enrollment the enrollment to be removed
     */
    public void delEnrollment(Enrollment enrollment) {
        validateEnrollment(enrollment);
        if (enrollments.contains(enrollment)) {
            enrollments.remove(enrollment);
            enrollment.getAClass().delEnrollment(enrollment);
        }
    }
    
}
