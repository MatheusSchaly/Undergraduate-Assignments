/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.univali.kob.poo1.aula05;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Arrays;

/**
 *
 * @author Matheus Schaly
 */
public class Professor extends Employee {
    
    /**
     * Professor's academic degree.
     */
    private AcademicDegree academicDegree;
    
    
    
    /**
     * Constructor.
     * @param name employee's name
     * @param dateOfBirth employee's birth date
     * @param hireDate employee's Hiring date
     * @param hoursPerWorkWeek employees's working hours per week
     * @param hourlyRate employees's hourly payment rate
     * @param academicDegree professor's academic degree
     */
    public Professor(String name, LocalDate dateOfBirth, LocalDate hireDate, int hoursPerWorkWeek, BigDecimal hourlyRate, AcademicDegree academicDegree) {
        super(name, dateOfBirth, hireDate, hoursPerWorkWeek, hourlyRate);
        this.academicDegree = academicDegree;
        validateState();
    }
    
    /**
     * Constructor.
     * @param name employee's name
     * @param dateOfBirth employee's birth date
     * @param hireDate employee's Hiring date
     * @param hoursPerWorkWeek employees's working hours per week
     * @param hourlyRate employees's hourly payment rate
     * @param academicDegree professor's academic degree
     */
    public Professor(String name, String dateOfBirth, String hireDate, int hoursPerWorkWeek, String hourlyRate, AcademicDegree academicDegree) {
        this(name, LocalDate.parse(dateOfBirth, AppConfig.DATE_FORMAT),
                LocalDate.parse(hireDate, AppConfig.DATE_FORMAT), hoursPerWorkWeek,
                    new BigDecimal(hourlyRate), academicDegree);
    }
    
    /**
     * Validates Professor state.
     */
    private void validateState() {
        validateAcademicDegree();
    }
    
    /**
     * Validates academic degree.
     */
    private void validateAcademicDegree() {
        for (AcademicDegree academicD: AcademicDegree.values()) {
            if (academicD == academicDegree) {
                return;
            }
        }
        throw new IllegalArgumentException("Academic Degree (" + academicDegree + ") is invalid [" + Arrays.toString(AcademicDegree.values()) + "]");
    }
    
    /**
     * Getter.
     * 
     * @return Professor's academic degree.
     */
    public AcademicDegree getAcademicDegree() {
        return academicDegree;
    }
    
    /**
     * Setter.
     * 
     * @param academicDegree Professor's academic degree.
     */
    public void setAcademicDegree(AcademicDegree academicDegree) {
        this.academicDegree = academicDegree;
    }
    
    /**
     * Calculates the value (in R$) of the professor's bonus according to his or her
     * current degree: 15% for master and 30% for doctorate. Note that the 
     * value still has to be added to the professor's hourly payment rate.
     * 
     * @return the value (in R$) of what need to be added to the professor's 
     * hourly payment rate, according to the professor's degree
     */
    public BigDecimal getAcademicBonus() {
        BigDecimal bonus = super.getHourlyRate().multiply(new BigDecimal(academicDegree.getBonus()));
        return bonus.setScale(2, BigDecimal.ROUND_HALF_EVEN);
    }
    
    /**
     * {@inheritDoc} Adjusts the professor's hourly payment rate
     * according to his or her degree.
     * 
     * @return the professor's hourly payment rate according to 
     * his or her degree
     */
    @Override
    public BigDecimal getHourlyRate() {
        BigDecimal hourlyRate = new BigDecimal("0.0").setScale(2, BigDecimal.ROUND_HALF_EVEN);
        return hourlyRate = super.getHourlyRate().add(getAcademicBonus());
    }
    
    @Override
    protected String appendToString() {
        StringBuilder output = new StringBuilder(super.appendToString());
        output.append(" // Professor " + AppConfig.NEW_LINE);
        output.append(" academicDegree = " + academicDegree + AppConfig.NEW_LINE);
        return output.toString();
    }
    
    @Override
    public boolean equals(Object obj) {
        if (!super.equals(obj)) {
            return false;
        }
        Professor professor = (Professor)obj;
        return
                (academicDegree == professor.academicDegree || academicDegree.equals(professor.academicDegree));
    }
    
    @Override
    public int hashCode() {
        return
                super.hashCode() ^
                academicDegree.ordinal();
    }
    
}
