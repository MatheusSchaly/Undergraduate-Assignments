public class MyClass {
    
    public static void main(String args[]) {
        String semaforo_NS, semaforo_LO, semaforo_P;

    	//------------------------S1----------------------------------------------

    	semaforo_NS = "Vermelho";
    	semaforo_LO = "Vermelho";
    	semaforo_P = "Vermelho";

        contar(5);
    	imprimeValores(semaforo_NS, semaforo_LO, semaforo_P);

        //------------------------S2----------------------------------------------
        semaforo_NS = "Verde";
    	semaforo_LO = "Vermelho";
    	semaforo_P = "Vermelho";

        contar(45);
    	imprimeValores(semaforo_NS, semaforo_LO, semaforo_P);

        //------------------------S3----------------------------------------------

    	semaforo_NS = "Amarelo";
    	semaforo_LO = "Vermelho";
    	semaforo_P = "Vermelho";

        contar(5);
    	imprimeValores(semaforo_NS, semaforo_LO, semaforo_P);
    	
        //------------------------S4----------------------------------------------

    	semaforo_NS = "Vermelho";
    	semaforo_LO = "Vermelho";
    	semaforo_P = "Vermelho";

        contar(5);
    	imprimeValores(semaforo_NS, semaforo_LO, semaforo_P);

        //------------------------S5----------------------------------------------

    	semaforo_NS = "Vemelho";
    	semaforo_LO = "Verde";
    	semaforo_P = "Vermelho";

        contar(45);
    	imprimeValores(semaforo_NS, semaforo_LO, semaforo_P);
    	
        //------------------------S6----------------------------------------------

    	semaforo_NS = "Vermelho";
    	semaforo_LO = "Amarelo";
    	semaforo_P = "Vermelho";

        contar(5);
    	imprimeValores(semaforo_NS, semaforo_LO, semaforo_P);

    	//------------------------S7----------------------------------------------

    	semaforo_NS = "Vermelho";
    	semaforo_LO = "Vermelho";
    	semaforo_P = "Vermelho";

        contar(5);
    	imprimeValores(semaforo_NS, semaforo_LO, semaforo_P);

    	//------------------------S8----------------------------------------------

    	semaforo_NS = "Vermelho";
    	semaforo_LO = "Vermelho";
    	semaforo_P = "Verde";

        contar(25);
    	imprimeValores(semaforo_NS, semaforo_LO, semaforo_P);
    }
    
    public static void imprimeValores(String semaforo_NS, String semaforo_LO, String semaforo_P) {
        System.out.println("Semáforo sentido Norte-Sul = " + semaforo_NS
    		+ "\nSemáforo sentido Leste-Oeste = " + semaforo_LO
    		+ "\nSemáforo de Pedestres = " + semaforo_P);
    }
    public static void contar(int tempo) {
        for(int contador = tempo; contador > 0; contador--){
            
        };
        System.out.println("\nEsperado " + tempo + "segundos\n");
    }
}
