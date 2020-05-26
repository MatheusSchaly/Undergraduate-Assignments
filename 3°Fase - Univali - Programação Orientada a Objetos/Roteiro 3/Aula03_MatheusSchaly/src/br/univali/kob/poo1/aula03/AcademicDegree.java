/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.univali.kob.poo1.aula03;

/**
 * Academic degree
 * 
 * @author Matheus Schaly
 */
public enum AcademicDegree {
    
    BACHELOR ("Bachelor", "0.00"),
    MASTER ("Master", "0.15"),
    DOCTORATE ("Doctorate (PhD)" , "0.30");
    
    /**
     * Text that describes each of enum items.
     */
    private final String description;
    
    /**
     * Bonus value in string format to be 
     * used with balues in BigDecimal.
     */
    private final String bonus;
    
    public String getDescription() {
        return description;
    }
    
    public String getBonus() {
        return bonus;
    }
    
    private AcademicDegree(String description, String bonus) {
        this.description = description;
        this.bonus = bonus;
    }
    
}
