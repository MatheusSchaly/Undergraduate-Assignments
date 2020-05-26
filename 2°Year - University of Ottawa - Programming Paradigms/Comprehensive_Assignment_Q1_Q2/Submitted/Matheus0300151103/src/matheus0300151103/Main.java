package matheus0300151103;

import java.util.Scanner;

public class Main {

	public static void main(String[] args) {
		String e_file_name = args[0];
		String s_file_name = args[1];
		
		StableMatching stableMatching = new StableMatching(e_file_name, s_file_name);
		stableMatching.init();
	}

}
