package br.univali.kob.poo1.aula09;

/**
 * Address representation.
 * 
 * @author Matheus Schaly
 */
public final class Address {

    /**
     * Address' street line 1.
     */
    private final String streetLine1;

    /**
     * Address' street line 2.
     */
    private final String streetLine2;

    /**
     * Address' zip code.
     */
    private final String zipCode;

    /**
     * Address' city.
     */
    private final City city;

    /**
     * Constructor.
     * @param streetLine1 address' street line 1
     * @param streetLine2 address' street line 2
     * @param city address' city
     * @param zipCode address' zipCode
     */
    public Address(String streetLine1, String streetLine2, City city, String zipCode) {
        StringValidator val = new StringValidator();
        val.minWordsCount(streetLine1, "Address", 1);
        this.streetLine1 = streetLine1;
        this.streetLine2 = streetLine2;
        this.city = city;
        this.zipCode = zipCode;
        validateState();
    }
    
    /**
     * Validates Adress state.
     */
    private void validateState() {
        validateCity();
        validateZipCode();
    }
    
    /**
     * Validates city.
     */
    private void validateCity() {
        if (city == null) {
            throw new IllegalArgumentException ("City can't be null");
        }
    }
    
    /**
     * Validates zipCode.
     */
    private void validateZipCode() {
        if (zipCode.equals("")) {
            throw new IllegalArgumentException ("ZipCode can't be empty");
        }
    }

    /**
     * Getter.
     * @return address' street line 1
     */
    public String getStreetLine1() {
        return streetLine1;
    }

    /**
     * Getter.
     * @return address' street line 2
     */
    public String getStreetLine2() {
        return streetLine2;
    }

    /**
     * Getter.
     * @return address' city
     */
    public City getCity() {
        return city;
    }

    /**
     * Getter.
     * @return address' zipCode
     */
    public String getZipCode() {
        return zipCode;
    }

    /**
     * @return
     */
    @Override
    public String toString() {
        StringBuilder output = new StringBuilder();
        output.append(this.getClass().getName() + " {" + AppConfig.NEW_LINE);
        output.append(" // Address " + AppConfig.NEW_LINE);
        output.append(" streetLine1 = " + streetLine1 + AppConfig.NEW_LINE);
        output.append(" streetLine1 = " + streetLine2 + AppConfig.NEW_LINE);
        output.append(" zipCode = " + zipCode + AppConfig.NEW_LINE);
        output.append(" city = " + city + AppConfig.NEW_LINE);
        output.append("}" + AppConfig.NEW_LINE);
        return output.toString();
    }

    /**
     * @return address' hashCode
     */
    @Override
    public int hashCode() {
        return zipCode.hashCode() ^ streetLine1.hashCode() ^ streetLine2.hashCode();
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
        Address address = (Address)obj;
        return
              (streetLine1 == address.streetLine1 || streetLine1.equals(address.streetLine1)) &&
              (streetLine2 == address.streetLine2 || streetLine2.equals(address.streetLine2)) &&
              (zipCode == address.zipCode || zipCode.equals(address.zipCode));
    }

}