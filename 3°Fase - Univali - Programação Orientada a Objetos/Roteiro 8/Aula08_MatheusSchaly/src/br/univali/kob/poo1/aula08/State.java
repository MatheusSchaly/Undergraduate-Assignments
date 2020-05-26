package br.univali.kob.poo1.aula08;

/**
 * State representation.
 * 
 * @author Matheus Schaly
 */
public final class State {

    /**
     * State's name.
     */
    private final String name;

    /**
     * State's abbreviation.
     */
    private final String abbreviation;

    /**
     * Constructor.
     * @param name state's name
     * @param abbreviation state's abbreviation
     */
    public State(String name, String abbreviation) {
        StringValidator val = new StringValidator();
        val.minWordsCount(name, "Name", 1);
        val.maxWordsCount(abbreviation, "Abbreviation", 1);
        this.name = name;
        this.abbreviation = abbreviation;
    }

    /**
     * Getter.
     * @return state's name
     */
    public String getName() {
        return name;
    }

    /**
     * Getter.
     * @return state's abbreviation
     */
    public String getAbbreviation() {
        return abbreviation;
    }

    /**
     * @return state's state (current attribute's values)
     */
    @Override
    public String toString() {
        StringBuilder output = new StringBuilder();
        output.append(this.getClass().getName() + " {" + AppConfig.NEW_LINE);
        output.append(" // State " + AppConfig.NEW_LINE);
        output.append(" name = " + name + AppConfig.NEW_LINE);
        output.append(" abbreviation = " + abbreviation + AppConfig.NEW_LINE);
        output.append("}" + AppConfig.NEW_LINE);
        return output.toString();
    }

    /**
     * @return states's hashCode
     */
    @Override
    public int hashCode() {
        return name.hashCode() ^ abbreviation.hashCode();
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
        State state = (State)obj;
        return
                (name == state.name || name.equals(state.name)) &&
                (abbreviation == state.abbreviation || abbreviation.equals(state.abbreviation));
    }

}