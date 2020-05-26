package br.univali.kob.poo1.aula03;

import java.math.BigDecimal;
import java.text.NumberFormat;
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
        Employee[] myEmployee = new Employee[2];
        DateTimeFormatter format = DateTimeFormatter.ofPattern("yyyy/MM/dd");
        myEmployee[0] = new Employee(10, "Lich King", LocalDate.parse("1980/01/01", format), LocalDate.parse("2005/01/01", format), 30, new BigDecimal("30.0"));
        myEmployee[1] = new Employee(20, "Indiana Jones", LocalDate.parse("1970/10/10", format), LocalDate.parse("2005/05/20", format), 40, new BigDecimal("40.0"));
        
        String output = "[Employee %d]\n" +
                "name: %s\n" +
                "age: %d\n" +
                "years of service: %d\n" +
                "hourly rate: %s\n" +
                "hours per work week: %d\n" +
                "regular salary: %s\n" +
                "weekly salary (considering 0 absent hours): %s\n" +
                "weekly salary (considering 5 absent hours): %s\n" +
                "weekly salary (considering 10 absent hours): %s\n\n";
        
        System.out.printf(output,
            myEmployee[0].getId(), 
            myEmployee[0].getName(), 
            myEmployee[0].getAge(),
            myEmployee[0].getYearsOfService(),
            NumberFormat.getCurrencyInstance().format(myEmployee[0].getHourlyRate()),
            myEmployee[0].getHoursPerWorkWeek(),
            NumberFormat.getCurrencyInstance().format(myEmployee[0].getRegularWeekSalary()),
            NumberFormat.getCurrencyInstance().format(myEmployee[0].getWeekPayment(0)),
            NumberFormat.getCurrencyInstance().format(myEmployee[0].getWeekPayment(5)),
            NumberFormat.getCurrencyInstance().format(myEmployee[0].getWeekPayment(10)));

        System.out.printf(output,
            myEmployee[1].getId(), 
            myEmployee[1].getName(), 
            myEmployee[1].getAge(),
            myEmployee[1].getYearsOfService(),
            NumberFormat.getCurrencyInstance().format(myEmployee[1].getHourlyRate()),
            myEmployee[1].getHoursPerWorkWeek(),
            NumberFormat.getCurrencyInstance().format(myEmployee[1].getRegularWeekSalary()),
            NumberFormat.getCurrencyInstance().format(myEmployee[1].getWeekPayment(0)),
            NumberFormat.getCurrencyInstance().format(myEmployee[1].getWeekPayment(5)),
            NumberFormat.getCurrencyInstance().format(myEmployee[1].getWeekPayment(10)));
    }
    
    /**
     * Test load: executes all test cases.
     */
    public void run() {
        System.out.printf("\n\n\n******* aula02: PersonListTest ******** \n\n");
        createEmployee();
    }
    
}
