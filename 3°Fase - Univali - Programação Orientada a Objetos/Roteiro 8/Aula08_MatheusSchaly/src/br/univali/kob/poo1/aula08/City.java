package br.univali.kob.poo1.aula08;

/**
 * City representation.
 * 
 * @author Matheus Schaly
 */
public final class City {

    /**
     * City's name.
     */
    private final String name;

    /**
     * City's state.
     */
    private final State state;

    /**
     * Constructor.
     * @param name city's name
     * @param state city's state
     */
    public City(String name, State state) {
        StringValidator val = new StringValidator();
        val.minWordsCount(name, "Name", 1);
        this.name = name;
        this.state = state;
        validateState();
    }

    /**
     * Getter.
     * @return city's name
     */
    public String getName() {
        return name;
    }

    /**
     * Getter.
     * @return city's state
     */
    public State getState() {
        return state;
    }
    
    /**
     * Validates City state.
     */
    private void validateState() {
        validateCityState();
    }
    
    /**
     * Validates state.
     */
    private void validateCityState() {
        if (state == null) {
            throw new IllegalArgumentException ("State can't be null");
        }
    }

    /**
     * @return city's state
     */
    @Override
    public String toString() {
        StringBuilder output = new StringBuilder();
        output.append(this.getClass().getName() + " {" + AppConfig.NEW_LINE);
        output.append(" // City " + AppConfig.NEW_LINE);
        output.append(" name = " + name + AppConfig.NEW_LINE);
        output.append(" state = " + state + AppConfig.NEW_LINE);
        output.append("}" + AppConfig.NEW_LINE);
        return output.toString();
    }

    /**
     * @return city's hashCode
     */
    @Override
    public int hashCode() {
        return name.hashCode() ^ state.hashCode();
    }

    /**
     * @param obj the object to be compared
     * @return true when the object has the same state, false otherwise
     */
    @Override
    public boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }
        City city = (City)obj;
        return
                (name == city.name || name.equals(city.name)) &&
                (state == city.state || state.equals(city.state));
    }

}