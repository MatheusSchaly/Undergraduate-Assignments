package matheus0300151103;

import java.io.*;

import java.util.ArrayList;

public class Student {
	private String name;
	private ArrayList<Employer> preferences = new ArrayList<Employer>();
	private Employer match = null;
	private int current_match_rank;
	
	public String get_name() {
		return this.name;
	}
	
	public void set_name(String name) {
		this.name = name;
	}
	
	public ArrayList<Employer> get_preferences() {
		return this.preferences;
	}
	
	public void add_preference(Employer employer) {
		this.preferences.add(employer);
	}
	
	public Employer get_match() {
		return this.match;
	}
	
	// Matches this student with the parameter employer
	public void match(Employer employer) {
		this.match = employer;
		this.current_match_rank = this.preferences.indexOf(match);
	}
	
	// Gets the ranking of the current match
	public int get_current_match_rank() {
		return this.current_match_rank;
	}
	
	// Gets the ranking of the employer parameter
	public int get_match_rank(Employer employer) {
		return this.preferences.indexOf(employer);
	}
	
	// Used for debugging
	public void print_student() {
		System.out.println("Student name: " + this.name);
		System.out.print("Employers: ");
		for (int i = 0; i < preferences.size(); i++) {
			System.out.print(preferences.get(i).get_name() + " ");
		}
		System.out.println();
	}
}
