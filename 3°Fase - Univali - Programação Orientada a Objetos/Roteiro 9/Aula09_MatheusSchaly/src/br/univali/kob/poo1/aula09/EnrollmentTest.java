package br.univali.kob.poo1.aula09;

/**
 * Teste de matrícula
 * 
 * @author Marcello Thiry
 */
public class EnrollmentTest {
    
    private final Address address = 
            new Address("Rua Floriano, 2012", null, 
                    new City("Florianópolis", new State("Santa Catarina", "SC")), 
                    "88015200");
    private Professor bruce, strange;
    private Student orin, susan, emma;
    private Course poo1, es1, es2;
    private Class poo1_171, es1_171, es2_171; 
    
    /** 
     * Reinicia a base de testes.
     */
    private void restart() {
        createCourses();
        createClasses();
        createProfessors();
        createStudents();
        createEnrollments();
    }

    /** 
     * Cria base de disciplinas.
     */
    private void createCourses() {
        poo1 = new Course("POO1", "Programação OO", "Ementa de OO", 4);
        es1 = new Course("ES1", "Engenharia de Software", "Ementa de ES1", 4);
        es2 = new Course("ES2", "Engenharia de Software", "Ementa de ES2", 4);
    }
    
    /** 
     * Cria base de turmas.
     */
    private void createClasses() {
        poo1_171 = new Class(2017, 1, poo1);
        es1_171 = new Class(2017, 1, es1);
        es2_171 = new Class(2017, 1, es2);
    }
    
    /** 
     * Cria base de professores.
     */
    private void createProfessors() {
        bruce = new Professor("Prof. Bruce Wayne", "02/05/1996", "wayne@com", "01/03/2017", 40, "20.34", AcademicDegree.BACHELOR, address);
        strange = new Professor("Prof. Stephen Vincent Strange", "23/09/1994", "frost@com", "31/07/2016", 40, "20.34", AcademicDegree.MASTER, address);
    }

    /** 
     * Cria base de estudantes.
     */
    private void createStudents() {
        orin = new Student("Orin Curry", "02/05/1996", "wayne@com", "01/03/2017", address);
        susan = new Student("Susan Kent-Barr", "23/09/1994", "frost@com", "31/07/2016", address);
        emma = new Student("Emma Grace Frost", "23/09/1994", "susan@com", "31/07/2016", address);
    }
    
    /** 
     * Simula matrículas.
     */
    private void createEnrollments() {
        bruce.addClass(poo1_171);
        bruce.addClass(es1_171);
        strange.addClass(es2_171);
        
        orin.addEnrollment(new Enrollment(orin, poo1_171));
        susan.addEnrollment(new Enrollment(susan, poo1_171));
        emma.addEnrollment(new Enrollment(emma, poo1_171));

        orin.addEnrollment(new Enrollment(orin, es1_171));
        susan.addEnrollment(new Enrollment(susan, es1_171));

        susan.addEnrollment(new Enrollment(susan, es2_171));
        emma.addEnrollment(new Enrollment(emma, es2_171));
    }
    
    /**
     * Imprime o cabeçalho do diário de classe.
     * 
     * @param courseClass a turma a ser impressa
     */
    private void printClassHeader(Class courseClass) {
        System.out.println("class " + courseClass.getCourse().getCode() + "." + 
                courseClass.getYear() + "/" + courseClass.getSemester());
        System.out.println("-------------------------------------------");
    }
    
    /**
     * Imprime o cabeçalho do diário de classe.
     * 
     * @param courseClass a turma a ser impressa
     */
    private void printClassProfessors(Class courseClass) {
        for (Professor p : courseClass.getProfessors()) {
            System.out.println(p.getName());
        }
        System.out.println("-");
    }
    
    private void printClassStudents(Class courseClass) {
        for (Enrollment e : courseClass.getEnrollments()) {
            System.out.println(e.getStudent().getName() + " = " + e.getMarks());
        }
        System.out.println("---");
    }
    
    /**
     * Imprime uma turma (diário de classe).
     * 
     * @param courseClass a turma a ser impressa
     */
    private void printClass(Class courseClass) {
        printClassHeader(courseClass);
        printClassProfessors(courseClass);
        printClassStudents(courseClass);
        System.out.println();
    }
    
    /**
     * Imprime diário de POO1.
     */
    private void test1() {
        restart();
        printClass(poo1_171);
    }

    /**
     * Imprime diário de ES1.
     */
    private void test2() {
        restart();
        printClass(es1_171);
    }
    
    /**
     * Imprime diário de ES2.
     */
    private void test3() {
        restart();
        printClass(es2_171);
    }
    
    /**
     * Exclui a matrícula de susan e imprime diário de ES2.
     */
    private void test4() {
        restart();
        es2_171.delEnrollment(new Enrollment(susan, es2_171));
        printClass(es2_171);
    }
    
    /**
     * Adiciona o professor strange em ES1 e imprime o diário.
     */
    private void test5() {
        restart();
        es1_171.addProfessor(strange);
        printClass(es1_171);
    }
    
    /**
     * Retira o professor bruce em ES1 e imprime o diário.
     */
    private void test6() {
        bruce.delClass(es1_171);
        printClass(es1_171);
    }
    
    /**
     * Executa todos os testes.
     */
    public void run() {
        test1();
        test2();
        test3();
        test4();
        test5();
        test6();
        System.out.println("\n\n");
    }
    
}

class EnrollmentLocalTest {

    public static void main(String[] args) {
        new EnrollmentTest().run();        
    }

}

