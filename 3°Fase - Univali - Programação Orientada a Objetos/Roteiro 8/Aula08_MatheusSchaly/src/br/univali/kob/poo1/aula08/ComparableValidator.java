package br.univali.kob.poo1.aula08;

import java.time.format.DateTimeFormatter;

/**
 * Generic class to validate comparable data.
 *
 * @author Matheus Schaly
 * 
 * @param <Type> any class that implements Comparable
 */
public class ComparableValidator<Type extends Comparable> extends Validator {
    
    private static DateTimeFormatter dateFormat;
    
    public ComparableValidator() {
        dateFormat = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    }
    
    public ComparableValidator(DateTimeFormatter format) {
        dateFormat = format;
    }
    
    /**
     * Verifies if a value Comparable is within a specific range.
     * 
     * @param value the value to be validated
     * @param valueLabel the text reference to the value that will be used in the exception
     * @param min the minimum value to the range (inclusive)
     * @param max the maximum value to the range (inclusive)
     * 
     * @throws NullPointerException if the value is null
     * @throws IllegalArgumentException if the value is outside the range
     */
    public final void range(Type value, String valueLabel, Type min, Type max) {
        notNull(value, valueLabel);
        if (min.compareTo(max) > 0 || min == null || max == null) {
            throw new IllegalArgumentException(min.toString() + ", " + max.toString());
        }
        if (value.compareTo(min) < 0 || value.compareTo(max) > 0) {
            throw new OutOfRangeException(value.toString(),
                    value.getClass().getSimpleName() + "." + valueLabel, min.toString(), max.toString());
        }
    }
    
    /**
     * Verifies if a Comparable value is smaller or eqaul another value.
     * 
     * @param value the value to be validated
     * @param valueLabel the text reference to the value that will be used in the exception
     * @param otherValue the value to be compared
     * 
     * @throws NullPointerException if one of the values is null
     * @throws IllegalArgumentException if value is not smaller or equal another value
     */
    public final void lessOrEquals(Type value, String valueLabel, Type otherValue) {
        notNull(value, valueLabel);
        notNull(otherValue, "Other Value");
        if (value.compareTo(otherValue) > 0) {
            throw new IllegalArgumentException(valueLabel + " (" + value.toString()
                    + ") must be less than or equals to " + otherValue);
        }
    }
    
}
