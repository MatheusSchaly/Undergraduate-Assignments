package br.univali.kob.poo1.aula08;

/**
 * Tests the Course and Class classes.
 * 
 * @author Matheus Schaly
 */
public class CourseClassTest {
    
    private void createCourseClass() {
        State s1 = new State("Santa Catarina", "SC");
        City c1 = new City("Florianópilis", s1);
        Address a1 = new Address("Rua Floriano Numero1", null, c1, "88015200");
        Professor bruce = new Professor("Bruce Wayne", "02/05/1996", "wayne@com", "01/03/2017", 40, "20.34", AcademicDegree.BACHELOR, a1);
        Professor emma = new Professor("Emma Grace Frost", "23/09/1994", "fros@com", "31/07/2016", 40, "20.34", AcademicDegree.MASTER, a1);
        Professor strange = new Professor("Stephen Vincent Strange", "23/09/1994", "frost@com", "31/07/2016", 40, "20.34", AcademicDegree.MASTER, a1);
        
        Course poo1 = new Course("POO1", "Programação OO", "Ementa de OO", 4);
        Course es1 = new Course("ES1", "Engenharia de Software", "Ementa de ES1", 4);
        Course es2 = new Course("ES2", "Engenharia de Software", "Ementa de ES2", 4);
        
        Class poo1_171 = new Class(2017, 1, poo1);
        Class es1_171 = new Class(2017, 1, es1);
        Class es2_171 = new Class(2017, 1, es2);
        
        bruce.addClass(poo1_171); //  <- Bug
        emma.addClass(poo1_171);
        poo1_171.delProfessor(bruce);
        
        System.out.println(bruce);
        System.out.println(poo1_171);
        System.out.println(emma);
    }

    public void run() {
        System.out.printf("\n\n\n******* aula08: CourseClassTest ******** \n\n");
        createCourseClass();
    }
    
}
