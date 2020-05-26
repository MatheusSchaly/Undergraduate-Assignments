package br.univali.kob.poo1.aula07;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

/**
 * Tests comparableValidator class
 *
 * @author Matheus Schaly
 */
public class ComparableValidatorTest {
    
    private void comparableValidatorTest() {
        DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        LocalDate myDate = LocalDate.parse("01/01/2017", dateFormat);
        LocalDate minDate = LocalDate.parse("01/01/2014", dateFormat);
        LocalDate maxDate = LocalDate.parse("01/01/2018", dateFormat);
        new ComparableValidator<LocalDate>().range(myDate, "My Date", minDate, maxDate);

        BigDecimal myNumber = new BigDecimal("100.45");
        BigDecimal minNumber = new BigDecimal("100.43");
        BigDecimal maxNumber = new BigDecimal("100.47");
        new ComparableValidator<BigDecimal>().range(myNumber, "My Date", minNumber, maxNumber);

        Integer myInt = 10;
        Integer minInt = 1;
        Integer maxInt = 10;
        new ComparableValidator<Integer>().range(myInt, "My Integer", minInt, maxInt);

        String myStr = "DDDD";
        String minStr = "CCCC";
        String maxStr = "EEEE";
        new ComparableValidator<String>().range(myStr, "My Integer", minStr, maxStr);

        System.out.println("Validacoes feitas com sucesso. Todo mundo passou!\n");
    }
    
    public void run() {
        System.out.printf("\n\n\n******* aula06: ComparableValidatorTest ******** \n\n");
        comparableValidatorTest();
    }
}
