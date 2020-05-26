/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.univali.kob.poo1.aula04;

import java.math.BigDecimal;
import java.text.NumberFormat;
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
        DateTimeFormatter format = DateTimeFormatter.ofPattern("yyyy/MM/dd");
        professorList.add(new Professor(20, "Indiana Jones", LocalDate.parse("1970/10/10", format), LocalDate.parse("2005/05/20", format), 40, new BigDecimal("40.0"), AcademicDegree.DOCTORATE));
        professorList.add(new Professor(100, "Peter Quill", LocalDate.parse("1976/01/05", format), LocalDate.parse("2002/09/20", format), 40, new BigDecimal("20.7"), AcademicDegree.MASTER));
        
                String output = "[Employee %d]\n" +
                "name: %s\n" +
                "age: %d\n" +
                "years of service: %d\n" +
                "hourly rate with bonus: %s\n" +
                "hours per work week: %d\n" +
                "regular salary: %s\n" +
                "weekly salary (considering 0 absent hours): %s\n" +
                "weekly salary (considering 5 absent hours): %s\n" +
                "weekly salary (considering 10 absent hours): %s\n" +
                "academic degree description: %s\n" +
                "bonus: %s\n\n";
        
        for (int i = 0; i < professorList.size(); i++) {
            System.out.printf(output,
            professorList.get(i).getId(), 
            professorList.get(i).getName(), 
            professorList.get(i).getAge(),
            professorList.get(i).getYearsOfService(),
            NumberFormat.getCurrencyInstance().format(professorList.get(i).getHourlyRate()),
            professorList.get(i).getHoursPerWorkWeek(),
            NumberFormat.getCurrencyInstance().format(professorList.get(i).getRegularWeekSalary()),
            NumberFormat.getCurrencyInstance().format(professorList.get(i).getWeekPayment(0)),
            NumberFormat.getCurrencyInstance().format(professorList.get(i).getWeekPayment(5)),
            NumberFormat.getCurrencyInstance().format(professorList.get(i).getWeekPayment(10)),
            professorList.get(i).getAcademicDegree().getDescription(),
            NumberFormat.getCurrencyInstance().format(professorList.get(i).getAcademicBonus()));
        }
    }

    /**
     * Carga de teste: executa todos os casos de teste.
     */
    public void run() {
        System.out.printf("\n\n\n******* aula02: ProfessorInheritanceTest ******** \n\n");
        createProfessor();
    }
    
}
