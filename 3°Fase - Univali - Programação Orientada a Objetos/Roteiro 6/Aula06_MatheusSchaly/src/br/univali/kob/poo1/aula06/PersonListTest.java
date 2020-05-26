package br.univali.kob.poo1.aula06;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

/**
 * @author Matheus Schaly
 */

public class PersonListTest {
    
    /**
     * Test case: instanciate, fill and show a employee.
     */
    
    private void createEmployee() {
        Employee[] myEmployee = new Employee[3];
        DateTimeFormatter format = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        myEmployee[0] = new Employee("Lich King", LocalDate.parse("01/01/1995", format), "@email.com", LocalDate.parse("01/01/2005", format), 30, new BigDecimal("30.0"));
        myEmployee[1] = new Employee("Lich King", "01/01/1995", "@email.com", "01/01/2005", 30, "30.0");
        myEmployee[2] = new Employee("Indiana Jones", "10/10/1970", "@email.com", "20/05/2005", 40, "40.0");
        System.out.println(myEmployee[0]);
        System.out.println(myEmployee[1]);
        System.out.println(myEmployee[2]);
        System.out.println("myEmployee[0].equals(myEmployee[1]) (expected false due to id): " + myEmployee[0].equals(myEmployee[1]));
    }
    
    /**
     * Test load: executes all test cases.
     */
    public void run() {
        System.out.printf("\n\n\n******* aula02: PersonListTest ******** \n\n");
        createEmployee();
    }
    
}
