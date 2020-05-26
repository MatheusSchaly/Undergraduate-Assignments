/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.univali.kob.poo1.aula04;

/**
 *
 * @author hsmatheus
 */
public class Aula04 {

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
