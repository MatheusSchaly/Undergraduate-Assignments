package br.univali.kob.poo1.aula09;

/**
 * Manages the course object.
 */
public class Course {

    /**
     * Default constructor
     */
    public Course() {
    }

    /**
     * Course's code.
     */
    private String code;

    /**
     * Course's name.
     */
    private String name;

    /**
     * Course's content.
     */
    private String content;

    /**
     * Course's credit hours.
     */
    private int creditHours;

    /**
     * Constructor.
     * @param code 
     * @param name 
     * @param content 
     * @param creditHours
     */
    public Course(String code, String name, String content, int creditHours) {
        this.code = code;
        this.name = name;
        this.content = content;
        this.creditHours = creditHours;
    }

    /**
     * Getter.
     * @return
     */
    public String getCode() {
        return code;
    }

    /**
     * Setter.
     * @param code 
     */
    public void setCode(String code) {
        this.code = code;
    }

    /**
     * Getter.
     * @return
     */
    public String getName() {
        return name;
    }

    /**
     * Setter.
     * @param name 
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Getter.
     * @return
     */
    public String getContent() {
        return content;
    }

    /**
     * Setter.
     * @param content 
     */
    public void setContent(String content) {
        this.content = content;
    }

    /**
     * Getter.
     * @return
     */
    public int getCreditHours() {
        return creditHours;
    }

    /**
     * Setter.
     * @param creditHours 
     */
    public void setCreditHours(int creditHours) {
        this.creditHours = creditHours;
    }
    
    /**
     * @return
     */
    @Override
    public String toString() {
        StringBuilder output = new StringBuilder();
        output.append(this.getClass().getName() + " {" + AppConfig.NEW_LINE);
        output.append(" code = " + code + AppConfig.NEW_LINE);
        output.append(" name = " + name + AppConfig.NEW_LINE);
        output.append(" content = " + content + AppConfig.NEW_LINE);
        output.append(" creditHours = " + creditHours + AppConfig.NEW_LINE);
        output.append("}" + AppConfig.NEW_LINE);
        return output.toString();
    }
    
    /**
     * @param obj 
     * @return
     */
    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        Course course = (Course)obj;
        return 
                (code == course.code) &&
                (name == course.name) &&
                (content == course.content) &&
                (creditHours == course.creditHours);
    }

    /**
     * @return
     */
    @Override
    public int hashCode() {
        return code.hashCode() ^ name.hashCode() ^ content.hashCode() ^ creditHours;
    }
    
}