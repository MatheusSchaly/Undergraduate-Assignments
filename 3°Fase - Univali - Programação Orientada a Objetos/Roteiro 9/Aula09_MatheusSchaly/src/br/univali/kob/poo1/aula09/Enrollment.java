package br.univali.kob.poo1.aula09;

/**
 * Manages the enrollment object.
 */
public class Enrollment {

    /**
     * Enrollment's marks.
     */
    private int marks;

    /**
     * Enrollment's student.
     */
    private Student student;

    /**
     * Enrollment's class.
     */
    private Class aClass;

    /**
     * Constructor.
     * @param student 
     * @param aClass
     */
    public Enrollment(Student student, Class aClass) {
        this.student = student;
        this.aClass = aClass;
        validateState();
    }
    
    private void validateState() {
        Validator val = new Validator();
        val.notNull(student, "student");
        val.notNull(aClass, "class");
    }

    /**
     * Getter.
     * @return
     */
    public int getMarks() {
        return marks;
    }

    /**
     * Setter.
     * @param marks 
     */
    public void setMarks(int marks) {
        new ComparableValidator().range(marks, "marks", 0, 100);
        this.marks = marks;
    }

    /**
     * Getter.
     * @return
     */
    public Student getStudent() {
        return student;
    }

    /**
     * Getter.
     * @return
     */
    public Class getAClass() {
        return aClass;
    }

}