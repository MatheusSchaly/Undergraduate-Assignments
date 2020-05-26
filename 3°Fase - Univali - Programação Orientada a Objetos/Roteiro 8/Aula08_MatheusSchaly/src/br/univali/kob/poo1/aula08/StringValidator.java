package br.univali.kob.poo1.aula08;

/**
 * Validates a string.
 * 
 * @author hsmatheus
 */
class StringValidator {
    
    public void minWordsCount(String name, String message, int minWords) {
        if (name.equals("") || countWords(name) < minWords) {
            throw new IllegalArgumentException ("Invalid " + message + " passed, number must by greater or equal to " + minWords);
        }
    }
    
    public void maxWordsCount(String name, String message, int maxWords) {
        if (name.equals("") || countWords(name) > maxWords) {
            throw new IllegalArgumentException ("Invalid " + message + " passed, number must by less than " + maxWords);
        }
    }
    
    public static int countWords(String s){
        int wordCount = 0;

        boolean word = false;
        int endOfLine = s.length() - 1;

        for (int i = 0; i < s.length(); i++) {
            // if the char is a letter, word = true.
            if (Character.isLetter(s.charAt(i)) && i != endOfLine) {
                word = true;
                // if char isn't a letter and there have been letters before,
                // counter goes up.
            } else if (!Character.isLetter(s.charAt(i)) && word) {
                wordCount++;
                word = false;
                // last word of String; if it doesn't end with a non letter, it
                // wouldn't count without this.
            } else if (Character.isLetter(s.charAt(i)) && i == endOfLine) {
                wordCount++;
            }
        }
        return wordCount;
    }
    
}
