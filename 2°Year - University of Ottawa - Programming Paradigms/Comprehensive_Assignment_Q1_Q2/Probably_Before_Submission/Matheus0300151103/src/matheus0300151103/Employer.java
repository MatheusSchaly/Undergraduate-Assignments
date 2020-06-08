package matheus0300151103;

import java.util.ArrayList;

public class Employer {
	private String name;
	private ArrayList<Student> preferences = new ArrayList<Student>();
	private Student match = null;
	private int current_match_rank;
	
	public Employer(String name) {
		this.name = name;
	}
	
	public String get_name() {
		return this.name;
	}
	
	public ArrayList<Student> get_preferences() {
		return this.preferences;
	}
	
	public void add_preference(Student student) {
		this.preferences.add(student);
	}
	
	public Student get_match() {
		return this.match;
	}
	
	// Matches this employer with the parameter student
	public void match(Student student) {
		this.match = student;
		this.current_match_rank = this.preferences.indexOf(match);
	}
	
	// Gets the ranking of the current match
	public int get_current_match_rank() {
		return this.current_match_rank;
	}
	
	// Gets the ranking of the student parameter
	public int get_match_rank(Student student) {
		return this.preferences.indexOf(student);
	}
	
	// Used for debugging
	public void print_employer() {
		System.out.println("Employer name: " + this.name);
		System.out.print("Students: ");
		for (int i = 0; i < preferences.size(); i++) {
			System.out.print(preferences.get(i).get_name() + " ");
		}
		System.out.println();
	}
}