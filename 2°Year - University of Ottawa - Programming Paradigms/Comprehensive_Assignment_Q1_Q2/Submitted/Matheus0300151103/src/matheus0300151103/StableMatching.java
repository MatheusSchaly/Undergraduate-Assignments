package matheus0300151103;

import java.io.*;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

public class StableMatching {
	private String e_file_path;
	private String s_file_path;
	private ArrayList<Student> students = new ArrayList<Student>();
	private ArrayList<Employer> employers = new ArrayList<Employer>();
	private int problem_size; // Captures the size of the csv

	public StableMatching(String e_file_name, String s_file_name) {
		this.e_file_path = System.getProperty("user.dir") + "\\" + e_file_name;
		this.s_file_path = System.getProperty("user.dir") + "\\" + s_file_name;
	}
	
	public void init() {
		read_s_CSV(s_file_path);
		read_e_CSV(e_file_path);
		Set<Match> stable_matches = Gale_Shapley(employers, students);
		create_output_file(stable_matches);
	}
	
	// Reads the student csv file and instantiates (partially) 
	// the employers objects and (fully) the students objects
	public void read_s_CSV(String s_file_path) {
		try {
			// Variable initialization
			File file = new File(s_file_path);
			FileReader fr = new FileReader(file);
			BufferedReader br = new BufferedReader(fr);
			String line = "";
			String[] tempArr;
			String delimiter = ",";
			String input;
			boolean first_column;
			boolean first_row = true;
	
			// Reads the csv and creates the objects
	        while ((line = br.readLine()) != null) {
	        	first_column = true;
	        	Student student = new Student();
	        	input = "";
	        	tempArr = line.split(delimiter);
	        	if (first_row) {
	        		first_row = false;
			        for(String tempStr : tempArr) {
			        	if (first_column) {
			        		first_column = false;
			        		student.set_name(tempStr);
			        	} else {
			        		problem_size ++;
			        		Employer employer = new Employer(tempStr);
			        		employers.add(employer);
			        		student.add_preference(employer);
			        	}
			        }
	        	} else {
			        for(String tempStr : tempArr) {
			        	if (first_column) {
			        		first_column = false;
			        		student.set_name(tempStr);
			        	} else {
			        		Employer employer = null;
			        		for (int i = 0; i < employers.size(); i++) {
			        			if (employers.get(i).get_name().equals(tempStr)) {
			        				employer = employers.get(i);
			        				break;
			        			}
			        		}
			        		student.add_preference(employer);
			        	}
			        }
	        	}
		        this.students.add(student);
			}
			br.close();
		} catch(IOException ioe) {
			ioe.printStackTrace();
		}
	}
	
	// Reads the employers csv file and fully
	// instantiates the employers objects
	public void read_e_CSV(String e_file_path) {
		// Variable initialization
		try {
			// 
			File file = new File(e_file_path);
			FileReader fr = new FileReader(file);
			BufferedReader br = new BufferedReader(fr);
			String line = "";
			String[] tempArr;
			String delimiter = ",";
			String input;
			boolean first_column;
	
			// Reads the csv and creates the objects
	        while ((line = br.readLine()) != null) {
	        	first_column = true;
	        	input = "";
	        	tempArr = line.split(delimiter);
	        	Employer employer = null;
		        for(String tempStr : tempArr) {
		        	if (first_column) {
		        		first_column = false;
		        		for (int i = 0; i < employers.size(); i++) {
		        			if (employers.get(i).get_name().equals(tempStr)) {
		        				employer = employers.get(i);
		        				break;
		        			}
		        		}
		        	} else {
		        		Student student = null;
		        		for (int i = 0; i < students.size(); i++) {
		        			if (students.get(i).get_name().equals(tempStr)) {
		        				student = students.get(i);
		        				break;
		        			}
		        		}
		        		employer.add_preference(student);
		        	}
		        }
			}
			br.close();
		} catch(IOException ioe) {
			ioe.printStackTrace();
		}
	}
	
	// Pseudo code's java implementation
	public Set<Match> Gale_Shapley(ArrayList<Employer> employers, ArrayList<Student> students) {
		Set<Match> M = new HashSet<Match>();
		while (!all_matched()) {
			Employer employer = null;
			for (Employer temp_employer : employers) {
				if (temp_employer.get_match() == null) {
					employer = temp_employer;
					break;
				}
			}
			Student best_student = employer.get_preferences().get(0);
			if (best_student.get_match() == null) {
				Match new_match = new Match();
				new_match.set_employer(employer);
				new_match.set_student(best_student);
				employer.match(best_student);
				best_student.match(employer);
				M.add(new_match);
			} else if (best_student.get_match_rank(employer) < best_student.get_current_match_rank()) {
				for (Match match : M) {
					if (match.get_student().equals(best_student)) {
						match.get_employer().match(null);
						match.set_employer(employer);
						employer.match(best_student);
						break;
					}
				}
			}
			employer.get_preferences().remove(best_student);
		}
		return M;
	}
	
	// Checks if there is still some employer that doesn't have a match
	public boolean all_matched() {
		for (Employer employer : employers) {
			if (employer.get_match() == null) {
				return false;
			}
		}
		return true;
	}

	// Creates the csv output file
	public void create_output_file(Set<Match> stable_matches) {
		String d = String.valueOf(this.problem_size);
		try {
			FileWriter myWriter = new FileWriter("matches_java_" + d + "x" + d + ".csv");
			for (Match m : stable_matches) {
				myWriter.write("Pair: " + m.get_employer().get_name() 
						+ " - " + m.get_student().get_name() + "\n");
			}
			myWriter.close();
			System.out.println("Successfully wrote to the file.");
		} catch (IOException e) {
			System.out.println("An error occurred.");
			e.printStackTrace();
		}
	}
	
}
