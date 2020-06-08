package matheus0300151103;

public class Match {
	private Employer employer;
	private Student student;
	
	public Employer get_employer() {
		return this.employer;
	}
	
	public void set_employer(Employer employer) {
		this.employer = employer;
	}
	
	public Student get_student() {
		return this.student;
	}
	
	public void set_student(Student student) {
		this.student = student;
	}
	
	// Used for debbuging
	public void print_match() {
		System.out.println(this.employer.get_name() + " matched with " + this.student.get_name());
	}
	
}
