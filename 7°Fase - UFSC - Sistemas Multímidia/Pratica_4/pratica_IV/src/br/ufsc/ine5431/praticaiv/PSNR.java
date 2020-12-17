package br.ufsc.ine5431.praticaiv;
import java.lang.*;

public final class PSNR {

	/*
	 *  Ferramenta que calcula o PSNR entre um arquivo BMP original e um arquivo BMP decodificado
	 */
	public static void main(String[] args) {
		if (args.length!=2) {
	    	System.out.println("Número errado de argumentos:" + args.length);
	    	System.out.println("Sintaxe: java PSNR  <arquivo BMP original> <arquivo BMP decodificado>");
	    	return;
	    }

	    String original = args[0];
	    String decodificado = args[1];

	    try {
		    Bitmap bmporiginal = new Bitmap(original);
		    Bitmap bmpdecodificado = new Bitmap(decodificado);
	  		System.out.println("Relação de Sinal-Ruído de Pico (PSNR): "
	  				+ psnr(bmporiginal.raster,bmpdecodificado.raster,24) + " dB");

	    } catch (Exception e) {
	    	e.getMessage();
	    	e.getStackTrace();
	    }

	}

	private static double psnr(int[][][] original, int[][][] decodificado, int bpp) {
		double dividendo = Math.pow(Math.pow(2, bpp) - 1, 2);
		double divisor = mse(original, decodificado);
		double psnr_var = 10 * Math.log10(dividendo / divisor);
			return psnr_var;
	}

	private static double mse(int[][][] original, int[][][] decodificado)  {
		double mse_var = 0;
		int nlinhas = original[0].length;
		int ncolunas = original.length;
		double n = 0;
			for (int i=0;i<nlinhas;i++) {  //percorre linhas
			for (int j=0;j<ncolunas;j++) {  //percorre colunas
					for (int p=0;p<3;p++) {  //percorre componentes R, G e B
					n++;
					mse_var += Math.pow((double)original[i][j][p] - (double)decodificado[i][j][p], 2);
						}
				}
			}
		return mse_var/n;
	}
	
}
