package br.univali.kob.poo1.aula09;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

/**
 * @author Matheus Schaly
 */
public class ProfessorInheritanceTest {
    
    private void createProfessor() {
        State s1 = new State("Santa Catarina", "SC");
        City c1 = new City("Urubici", s1);
        Address a1 = new Address("Rua1 Bairro1 Numero1", "", c1, "88650-000");
        System.out.println("test case: createProfessor");
        ArrayList<Professor> professorList = new ArrayList<>(2);
        DateTimeFormatter format = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        professorList.add(new Professor("Indiana Jones", LocalDate.parse("10/10/1970", format), "email.com", LocalDate.parse("20/05/2005", format), 40, new BigDecimal("40.0"), AcademicDegree.DOCTORATE, a1));
        professorList.add(new Professor("Indiana Jones", "10/10/1970", "email.com", "20/05/2005", 40, "40.0", AcademicDegree.DOCTORATE, a1));
        professorList.add(new Professor("Peter Quill", "05/01/1976", "email.com", "20/09/2002", 40, "20.7", AcademicDegree.MASTER, a1));
        System.out.println(professorList.get(0));
        System.out.println(professorList.get(1));
        System.out.println(professorList.get(2));
        System.out.println("professorList.get(0).equals(professorList.get(1))) (expected false due to id): " + professorList.get(0).equals(professorList.get(1)));
        System.out.println("professorList.get(0).equals(professorList.get(0))) (true expected): " + professorList.get(0).equals(professorList.get(0)));
        System.out.println("professorList.get(0).equals(null) (false expected): " + professorList.get(0).equals(null) + '\n');
    }

    /**
     * Carga de teste: executa todos os casos de teste.
     */
    public void run() {
        System.out.printf("\n\n\n******* aula02: ProfessorInheritanceTest ******** \n\n");
        createProfessor();
    }
    
}
