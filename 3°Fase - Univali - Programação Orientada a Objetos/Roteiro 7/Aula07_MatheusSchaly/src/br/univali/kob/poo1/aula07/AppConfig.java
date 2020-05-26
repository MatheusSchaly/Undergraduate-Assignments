package br.univali.kob.poo1.aula07;

import java.time.format.DateTimeFormatter;

/**
 * Aplication general configuration
 * 
 * @author Marcello Thiry
 */
public class AppConfig {
    
    /**
     * Application's name.
     */
    public static final String APP_NAME;
    
    /**
     * Application's version.
     */
    public static final String APP_VERSION;
    
    /**
     * Brazilian date format constant.
     */
    public static final DateTimeFormatter DATE_FORMAT;
    
    /**
     * Line break format constant, according to the operating system being used.
     */
    public static final String NEW_LINE;
    
    /**
     * Store information from some source.
     */
    private static final Object SETTINGS[] = new Object[10];
    
    /**
     * Static block, it's called just once, when the class is initialized.
     */
    static {
        loadSettings();
        APP_NAME = (String)SETTINGS[0];
        APP_VERSION = (String)SETTINGS[1];
        DATE_FORMAT = (DateTimeFormatter)SETTINGS[2];
        NEW_LINE = (String)SETTINGS[3];
    }
    
    /**
     * Loads the configurations from some source as, for exemple, 
     * a XML file or the system's properties
     */
    private static void loadSettings() {
        SETTINGS[0] = "Academic System";
        SETTINGS[1] = "1.0";
        SETTINGS[2] = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        SETTINGS[3] = System.getProperty("line.separator");
    }
    
}
