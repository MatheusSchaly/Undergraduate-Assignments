package br.univali.kob.poo1.aula08c;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Teste de matrícula
 *
 * @author Marcello Thiry
 */
public class EnrollmentTest {

    private final Address address
            = new Address("Rua Floriano, 2012", null,
                    new City("Florianópolis", new State("Santa Catarina", "SC")),
                    "88015200");
    private Map<String, Professor> professors = new HashMap<>();
    private Map<String, Student> students = new HashMap<>();
    private Map<String, Department> departments = new HashMap<>();
    private Map<String, Course> courses = new HashMap<>();
    private Map<String, PlannedCourse> plannedCourses = new HashMap<>();
    private Map<String, DegreePlan> plans = new HashMap<>();
    private Map<String, Major> majors = new HashMap<>();
    private Map<String, Class> classes = new HashMap<>();

    /**
     * Reinicia a base de testes.
     */
    private void restart() {
        createProfessors();
        createStudents();
        createDepartments();
        createCourses();
        createPlans();
        createPlannedCourses();
        updateCoursesAndDegreePlans();
        createMajors();
        createClasses();
        createEnrollments();
    }

    /**
     * Cria base de professores.
     */
    private void createProfessors() {
        professors.put("bruce", new Professor("Prof. Bruce Wayne", "02/05/1996", "wayne@com", address, "01/03/2017", 40, "20.34", AcademicDegree.BACHELOR));
        professors.put("strange", new Professor("Prof. Stephen Vincent Strange", "23/09/1994", "frost@com", address, "31/07/2016", 40, "20.34", AcademicDegree.MASTER));
    }

    /**
     * Cria base de estudantes.
     */
    private void createStudents() {
        students.put("orin", new Student("Orin Curry", "02/05/1996", "wayne@com", address, "01/03/2017"));
        students.put("susan", new Student("Susan Kent-Barr", "23/09/1994", "frost@com", address, "31/07/2016"));
        students.put("emma", new Student("Emma Grace Frost", "23/09/1994", "susan@com", address, "31/07/2016"));
    }

    /**
     * Cria base de departamentos.
     */
    private void createDepartments() {
        departments.put("DCC", new Department("Ciência da Computação", "DCC"));
    }

    /**
     * Cria base de disciplinas.
     */
    private void createCourses() {
        Department cc = departments.get("DCC");
        courses.put("ALG" , new Course("ALG" , "Algoritmos", "Ementa Algoritmos", 4, cc));
        courses.put("C1"  , new Course("C1"  , "Cálculo", "Ementa Cálculo 1", 4, cc));
        courses.put("C2"  , new Course("C2"  , "Cálculo", "Ementa Cálculo 2", 4, cc));
        courses.put("ED"  , new Course("ED"  , "Estrutura de Dados", "Ementa Estrutura de Dados", 4, cc));
        courses.put("POO" , new Course("POO" , "Programação Orientada a Objetos", "Ementa Programação Orientada a Objetos", 4, cc));
        courses.put("ES1" , new Course("ES1" , "Engenharia de Software", "Ementa Engenharia de Software 1", 4, cc));
        courses.put("ES2" , new Course("ES2" , "Engenharia de Software", "Ementa Engenharia de Software 2", 4, cc));
        courses.put("BD1" , new Course("BD1" , "Banco de Dados", "Ementa Banco de Dados 1", 4, cc));
        courses.put("BD2" , new Course("BD2" , "Banco de Dados", "Ementa Banco de Dados 2", 4, cc));
        courses.put("MD"  , new Course("MD"  , "Matemática Discreta", "Ementa Matemática Discreta", 4, cc));
        courses.put("TOP" , new Course("TOP" , "Tópicos em Computação", "Ementa Tópicos em Computação", 4, cc));
        courses.put("TCC1", new Course("TCC1", "Trabalho de Conclusão de Curso", "Ementa Trabalho de Conclusão de Curso 1", 4, cc));
        courses.put("TCC2", new Course("TCC2", "Trabalho de Conclusão de Curso", "Ementa Trabalho de Conclusão de Curso 2", 4, cc));
    }

    /**
     * Cria base de grades.
     */
    private void createPlans() {
        plans.put("CC2017", new DegreePlan(LocalDate.parse("01/01/2017", AppConfig.DATE_FORMAT)));
    }
    
    /**
     * Cria base de relacionamentos entre disciplina e grade.
     */
    private void createPlannedCourses() {
        List<PlannedCourse> prereq;
        plannedCourses.put("ALG_CC2017" , new PlannedCourse(courses.get("ALG") , plans.get("CC2017"), 1, CourseRequirement.REQUIRED, null)); 
        plannedCourses.put("C1_CC2017"  , new PlannedCourse(courses.get("C1")  , plans.get("CC2017"), 1, CourseRequirement.REQUIRED, null));
        //
        prereq = new ArrayList<>();
        prereq.add(plannedCourses.get("C1_CC2017"));
        plannedCourses.put("C2_CC2017"  , new PlannedCourse(courses.get("C2")  , plans.get("CC2017"), 2, CourseRequirement.REQUIRED, prereq));
        //
        prereq = new ArrayList<>();
        prereq.add(plannedCourses.get("ALG_CC2017"));
        plannedCourses.put("ED_CC2017"  , new PlannedCourse(courses.get("ED")  , plans.get("CC2017"), 2, CourseRequirement.REQUIRED, prereq)); 
        plannedCourses.put("POO_CC2017" , new PlannedCourse(courses.get("POO") , plans.get("CC2017"), 2, CourseRequirement.REQUIRED, prereq)); 
        plannedCourses.put("MD_CC2017"  , new PlannedCourse(courses.get("MD")  , plans.get("CC2017"), 3, CourseRequirement.REQUIRED, prereq)); 
        //
        prereq = new ArrayList<>();
        prereq.add(plannedCourses.get("ED_CC2017"));
        prereq.add(plannedCourses.get("POO_CC2017"));
        plannedCourses.put("ES1_CC2017" , new PlannedCourse(courses.get("ES1") , plans.get("CC2017"), 3, CourseRequirement.REQUIRED, prereq)); 
        plannedCourses.put("BD1_CC2017" , new PlannedCourse(courses.get("BD1") , plans.get("CC2017"), 3, CourseRequirement.REQUIRED, prereq)); 
        //
        prereq = new ArrayList<>();
        prereq.add(plannedCourses.get("ES1_CC2017"));
        plannedCourses.put("ES2_CC2017" , new PlannedCourse(courses.get("ES2") , plans.get("CC2017"), 4, CourseRequirement.REQUIRED, prereq)); 
        //
        prereq = new ArrayList<>();
        prereq.add(plannedCourses.get("BD1_CC2017"));
        plannedCourses.put("BD2_CC2017" , new PlannedCourse(courses.get("BD2") , plans.get("CC2017"), 4, CourseRequirement.REQUIRED, prereq)); 
        //
        plannedCourses.put("TOP_CC2017" , new PlannedCourse(courses.get("TOP") , plans.get("CC2017"), 4, CourseRequirement.REQUIRED, null)); 
        //
        prereq = new ArrayList<>();
        prereq.add(plannedCourses.get("ES2_CC2017"));
        prereq.add(plannedCourses.get("BD2_CC2017"));
        plannedCourses.put("TCC1_CC2017", new PlannedCourse(courses.get("TCC1"), plans.get("CC2017"), 5, CourseRequirement.REQUIRED, prereq)); 
        //
        prereq = new ArrayList<>();
        prereq.add(plannedCourses.get("TCC1_CC2017"));
        plannedCourses.put("TCC2_CC2017", new PlannedCourse(courses.get("TCC2"), plans.get("CC2017"), 6, CourseRequirement.REQUIRED, prereq)); 
    }

    /**
     * Atualiza os relacionamentos entre disciplinas e grades.
     */
    private void updateCoursesAndDegreePlans() {
        // basta atualizar uma ponta
        for (Map.Entry<String, PlannedCourse> entry : plannedCourses.entrySet()) {
            plans.get("CC2017").addPlannedCourse(entry.getValue());
        }
    }
    
    /**
     * Cria base de cursos.
     */
    private void createMajors() {
        Major major = new Major("Ciência da Computação", "CC");
        major.addDegreePlan(plans.get("CC2017"));
        majors.put("CC", major);
    }

    /**
     * Cria base de turmas.
     */
    private void createClasses() {
        classes.put("poo1_171", new Class(2017, 1, courses.get("POO")));
        classes.put("es1_171", new Class(2017, 1, courses.get("ES1")));
        classes.put("es2_171", new Class(2017, 1, courses.get("ES2")));
    }

    /**
     * Simula matrículas.
     */
    private void createEnrollments() {
        professors.get("bruce").addClass(classes.get("poo1_171"));
        professors.get("bruce").addClass(classes.get("es1_171"));
        professors.get("strange").addClass(classes.get("es2_171"));

        students.get("orin").addEnrollment(new Enrollment(students.get("orin"), classes.get("poo1_171")));
        students.get("susan").addEnrollment(new Enrollment(students.get("susan"), classes.get("poo1_171")));
        students.get("emma").addEnrollment(new Enrollment(students.get("emma"), classes.get("poo1_171")));

        students.get("orin").addEnrollment(new Enrollment(students.get("orin"), classes.get("es1_171")));
        students.get("susan").addEnrollment(new Enrollment(students.get("susan"), classes.get("es1_171")));
        
        students.get("susan").addEnrollment(new Enrollment(students.get("susan"), classes.get("es2_171")));
        students.get("emma").addEnrollment(new Enrollment(students.get("emma"), classes.get("es2_171")));
    }
    
    /**
     * Imprime uma grade curricular.
     *
     * @param major o curso que tem a grade curricular
     */
    private void printDegreePlan(Major major, LocalDate activation) {
        DegreePlan plan = major.getDegreePlan(activation);
        System.out.println(major.getName());
        System.out.println("-------------------------------------------");
        System.out.println("degree plan " + plan.getActivationDate());
        System.out.println(plan.getCreditHours() + " credits hours");
        System.out.println("---");
        for (PlannedCourse pc : plan.getPlannedCourses()) {
            System.out.print(pc.getCourse().getCode() + "." 
                    + pc.getCourse().getName() + ", " + pc.getSemester() 
                    + " [");
            for (PlannedCourse pr : pc.getPrerequisites()) {
                System.out.print(pr.getCourse().getCode());
            }
            System.out.println("]");
        }
        System.out.println("---");
    }

    /**
     * Imprime o cabeçalho do diário de classe.
     *
     * @param courseClass a turma a ser impressa
     */
    private void printClassHeader(Class courseClass) {
        System.out.println("class " + courseClass.getCourse().getCode() + "."
                + courseClass.getYear() + "/" + courseClass.getSemester());
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
    private void ComputerSciencePlanDegreeTest() {
        restart();
        printDegreePlan(majors.get("CC"), LocalDate.parse("01/01/2017", AppConfig.DATE_FORMAT));
        System.out.println("\n\n");
    }

    
    /**
     * Imprime diário de POO1.
     */
    private void StudentListTest() {
        restart();
        printClass(classes.get("poo1_171"));
        System.out.println("\n\n");
    }

    /**
     * Executa todos os testes.
     */
    public void run() {
        ComputerSciencePlanDegreeTest();
        StudentListTest();
        System.out.println("\n\n");
    }

}

class EnrollmentLocalTest {

    public static void main(String[] args) {
        new EnrollmentTest().run();
    }

}
