package br.univali.kob.poo1.aula08;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

/**
 * Testes de herança: Employee é uma subclasse de Person.
 *
 * @author Matheus Schaly
 */
public class EmployeeInheritanceTest {

    /**
     * Caso de teste: instanciar, popular e mostrar um empregado.
     * <p>
     * Note que foram passadas Strings para o construtor do BigDecimal.
     * Esta é uma recomendação da própria documentação do Java para
     * evitar problemas de precisão na hora de criar o valor.
     * <p>
     * Outra novidade é a utilização do NumberFormat para formatar
     * valores financeiros. Veja mais detalhes sobre NumberFormat em:
     * <p>
     * <a href="https://docs.oracle.com/javase/8/docs/api/java/text/NumberFormat.html">
     * https://docs.oracle.com/javase/8/docs/api/java/text/NumberFormat.html</a>
     * 
     * <p>
     * Verifique também se os cálculos estão corretos.
     */
    private void createEmployee() {
        State s1 = new State("Santa Catarina", "SC");
        City c1 = new City("Urubici", s1);
        Address a1 = new Address("Rua1 Bairro1 Numero1", "", c1, "88650-000");
        System.out.println("test case: createEmployee");
        DateTimeFormatter format = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        Employee employee1 = new Employee("Peter Quill", LocalDate.parse("15/01/1976", format), "email.com", LocalDate.parse("20/09/2002", format), 40, new BigDecimal("20.7"), a1);
        Employee employee2 = new Employee("Peter Quill", "15/01/1976", "email.com", "20/09/2002", 40, "20.7", a1);
        System.out.println(employee1);
        System.out.println("employee1.equals(employee2) (expected false due to id): " + employee1.equals(employee2));
    }

    /**
     * Carga de teste: executa todos os casos de teste.
     */
    public void run() {
        System.out.printf("\n\n\n******* aula02: EmployeeInheritanceTest ******** \n\n");
        createEmployee();
    }
    
}
