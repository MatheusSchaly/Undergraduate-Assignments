/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.univali.kob.poo1.aula05;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

/**
 *
 * @author hsmatheus
 */
public class ProfessorInheritanceTest {
    
    private void createProfessor() {
        System.out.println("test case: createProfessor");
        ArrayList<Professor> professorList = new ArrayList<>(2);
        DateTimeFormatter format = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        professorList.add(new Professor("Indiana Jones", LocalDate.parse("10/10/1970", format), LocalDate.parse("20/05/2005", format), 40, new BigDecimal("40.0"), AcademicDegree.DOCTORATE));
        professorList.add(new Professor("Indiana Jones", "10/10/1970", "20/05/2005", 40, "40.0", AcademicDegree.DOCTORATE));
        professorList.add(new Professor("Peter Quill", "05/01/1976", "20/09/2002", 40, "20.7", AcademicDegree.MASTER));
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
