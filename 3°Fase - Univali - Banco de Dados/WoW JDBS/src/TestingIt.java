//Establish a connection to a postgre database using JDBC
import java.sql.*; 
import java.util.Scanner;

class TestingIt { 
	public static void main (String[] args) { 
		try {
			// Step 1: "Load" the JDBC driver
			Class.forName("org.postgresql.Driver"); 
			
			// Step 2: Establish the connection to the database 
			String url = "jdbc:postgresql://localhost:5432/MatheusSchaly"; 
			Connection conn = DriverManager.getConnection(url,"MatheusSchaly","99ms");
			Statement statement = conn.createStatement();
			
			int opcao;
			String opcaoColuna, atributo, condicao, colunaCondicao, sql;
			Scanner out = new Scanner(System.in);
			  
			do {
				do {
					System.out.println("Selecione a operacao:");
					System.out.println("1 - INSERT INTO jogo");
					System.out.println("2 - DELETE FROM jogo");
					System.out.println("3 - UPDATE jogo");
					System.out.println("4 - SELECT FROM jogo");
					System.out.println("5 - SELECT * FROM jogo");
					System.out.println("0 - Exit");
					opcao = out.nextInt();
				} while (opcao < 0 || opcao > 5);
				  
				switch (opcao) {
					case 1:
						out.nextLine();
						System.out.println("Nome:");
						String nome = out.nextLine();
						System.out.println("Data de Lancamento:");
						String dataLancamento = out.nextLine();
						System.out.println("Versao:");
						String versao = out.nextLine();
						System.out.println("Preco:");
						int preco = out.nextInt();
						out.nextLine();
						sql = "INSERT INTO jogo (nome_jogo, data_de_lancamento, versao, preco) VALUES ('" + nome + "', '" + dataLancamento + "', '" + versao + "', '" + preco + "')";
						statement.executeUpdate(sql);
					break;
					case 2:
						out.nextLine();
						opcaoColuna = lerColuna();
						System.out.println("Atributo:");
						atributo = out.nextLine();
						statement.executeUpdate("DELETE FROM jogo WHERE " + opcaoColuna + " = '" + atributo + "'");
					break;
					case 3:
						System.out.println("SET");
						opcaoColuna = lerColuna();
						out.nextLine();
						System.out.println("Atributo:");
						atributo = out.nextLine();
						System.out.println("WHERE:");
						colunaCondicao = lerColuna();
						System.out.println("Condicao:");
						condicao = out.nextLine();
						statement.executeUpdate("UPDATE jogo SET " + opcaoColuna + " = '" + atributo + "'WHERE " + colunaCondicao + " = '" + condicao + "'");
					break;
					case 4:
						opcaoColuna = lerColuna();
						ResultSet rs = statement.executeQuery("SELECT " + opcaoColuna + " FROM jogo");
						while (rs.next()) {
							System.out.println(rs.getString(opcaoColuna));
						}
					break;
					case 5:
						ResultSet rs2 = statement.executeQuery("SELECT * FROM jogo");
						while (rs2.next()) {
							System.out.println("nome_jogo: " + rs2.getString("nome_jogo") + 
									" data_de_lancamento: " + rs2.getString("data_de_lancamento") +
									" versao: " + rs2.getString("versao") +
									" preco: " + rs2.getString("preco"));
						}
					System.out.println();
					break;
				}
			} while (opcao != 0);
		}
			
		catch (Exception e) {
			System.err.println("Exception!"); 
			System.err.println(e.getMessage()); 
		}
	}
	
	private static String lerColuna() {
		Scanner out = new Scanner(System.in);
		String opcaoColuna;
		do {
			System.out.println("Selecione a coluna:");
			System.out.println("preco");
			System.out.println("nome_jogo");
			System.out.println("data_de_lancamento");
			System.out.println("versao");
			opcaoColuna = out.nextLine();	
		} while (!(opcaoColuna.equals("preco") || opcaoColuna.equals("nome_jogo") || opcaoColuna.equals("data_de_lancamento") || opcaoColuna.equals("versao")));
		return opcaoColuna;
	}

}