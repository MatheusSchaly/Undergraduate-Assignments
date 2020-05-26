package br.univali.kob.poo1.aula03;

/**
 * @author Matheus Schaly
 */
public class Aula03 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        StudentInheritanceTest studentTest = new StudentInheritanceTest();
        studentTest.run();
        EmployeeInheritanceTest employeeTest = new EmployeeInheritanceTest();
        employeeTest.run();
        PersonListTest personListTest = new PersonListTest();
        personListTest.run();
        ProfessorInheritanceTest professorTest = new ProfessorInheritanceTest();
        professorTest.run();
    }
    
}
