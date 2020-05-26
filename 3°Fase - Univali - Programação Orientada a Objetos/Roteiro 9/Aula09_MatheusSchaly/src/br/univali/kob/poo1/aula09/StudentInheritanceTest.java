package br.univali.kob.poo1.aula09;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

/**
 * Testes de herança (Student é uma subclasse de Person).
 *
 * @author Matheus Schaly
 */
public class StudentInheritanceTest {
    
    /**
     * Caso de teste: instanciar, popular e mostrar um estudante (subclasse).
     */
    private void createSubclassStudent() {
        State s1 = new State("Santa Catarina", "SC");
        City c1 = new City("Urubici", s1);
        Address a1 = new Address("Rua1 Bairro1 Numero1", "", c1, "88650-000");
        System.out.println("test case: createSubclassStudent");
        DateTimeFormatter format = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        Student student1 = new Student("John", LocalDate.parse("22/04/1994", format), "@email.com", LocalDate.parse("27/02/2017", format), a1);
        Student student2 = new Student("John", "22/04/1994", "@email.com", "27/02/2017", a1);
        System.out.println(student1);
        System.out.println(student2);
        System.out.println("student1.equals(student2) (expected false due to id): " + student1.equals(student2) + "\n");
    }
    
    /**
     * Caso de teste: acessar atributos da superclasse.
     * <p>
     * Mostra que os atributos (tanto aqueles herdados quanto aqueles
     * definidos na classe Student) só podem ser acessados por meio de
     * operações de acesso. Deste modo, garantimos a proteção aos dados
     * via "information hiding" (ocultamento da informação).
     * </p>
     * Atributos devem ser SEMPRE privados. Para permitir que eles sejam
     * acessados, deve-se utilizar operações de acesso.
     */
    private void tryAccessToSuperAttributes() {
        State s1 = new State("Santa Catarina", "SC");
        City c1 = new City("Urubici", s1);
        Address a1 = new Address("Rua1 Bairro1 Numero1", "", c1, "88650-000");
        System.out.println("test case: tryAccessToSuperAttributes");
        DateTimeFormatter format = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        Student student = new Student("John", "22/04/1994", "@email.com", "27/02/2017", a1);
        // Experimente tirar os comentários das próximas linhas e
        // verificar o que acontece. Leia o erro retornado.
        //student.name = "John";
        //student.rollNumber = 1;
        System.out.println("Se chegou aqui é porque você não tentou " + 
                "acessar atributos diretamente. Atributos devem ser " +
                "SEMPRE privados.");
    }

    /**
     * Carga de teste: executa todos os casos de teste.
     */
    public void run() {
        System.out.printf("\n\n\n******* aula02a: StudentInheritanceTest ******** \n\n");
        createSubclassStudent();
        tryAccessToSuperAttributes();
    }
    
}