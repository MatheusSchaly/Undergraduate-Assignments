package pratica_2;

import java.awt.image.*;
import java.net.*;
import javax.imageio.ImageIO;
import javax.swing.*;
import java.io.File;
import java.awt.Graphics2D;

// Grupo: Bernardo Mendonça, Francisco Vicenzi, Matheus Schaly

public class ImageApp   {

	// Leitura da imagem
	public static BufferedImage loadImage(String path) {
		BufferedImage bimg = null;
		try {
			bimg = ImageIO.read(new File(path));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bimg;
	}

	public void apresentaImagem(JFrame frame, BufferedImage img) {
		frame.setBounds(0, 0, img.getWidth(), img.getHeight());
		JImagePanel panel = new JImagePanel(img, 0, 0);
		frame.add(panel);
		frame.setVisible(true);
	}

	public static void printImageSize(BufferedImage img, String id) {
		System.out.println("Image: " + id + ", size: " + img.getHeight() + ", " + img.getWidth());
	}

	public static BufferedImage resizeImage(BufferedImage sourceImage, double scale) {
		int sourceHeight = sourceImage.getHeight();
		int sourceWidth = sourceImage.getWidth();
		int newHeight = (int) (sourceHeight * scale);
		int newWidth = (int) (sourceWidth * scale);
		BufferedImage newImage = new BufferedImage(newHeight, newWidth, BufferedImage.TYPE_INT_RGB);
		WritableRaster raster = newImage.getRaster();
		for(int h=0; h < sourceHeight; h+=1/scale) { //Percorre a horizontal
			int resize_h = (int) (h*scale);
			for(int w=0; w < sourceWidth; w+=1/scale) {//Percorre a vertical
				int resize_w = (int) (w*scale);
				int rgb = sourceImage.getRGB(w, h);
				int r = (int) ((rgb&0xFF0000) >>> 16); // componente vermelho
				int g = (int) ((rgb&0xFF00) >>> 8); // componente verde
				int b = (int) (rgb&0xFF); //componente azul
				raster.setSample(resize_w,resize_h,0,r); // Componente Vermelho
				raster.setSample(resize_w,resize_h,1,g); // Componente Verde
				raster.setSample(resize_w,resize_h,2,b);  // Componente Azul
			}
		}
		return newImage;
	}

	public static BufferedImage toGrayScale(BufferedImage sourceImage) {
		int sourceHeight = sourceImage.getHeight();
		int sourceWidth = sourceImage.getWidth();
		BufferedImage newImage = new BufferedImage(sourceHeight, sourceWidth, BufferedImage.TYPE_BYTE_GRAY);
		WritableRaster raster = newImage.getRaster();
		for(int h=0; h < sourceHeight; h++) //Percorre a horizontal
			for(int w = 0; w < sourceWidth; w++) {//Percorre a vertical
				int rgb = sourceImage.getRGB(w, h);
				int r = (int) ((rgb&0xFF0000) >>> 16); // componente vermelho
				int g = (int) ((rgb&0xFF00) >>> 8); // componente verde
				int b = (int) (rgb&0xFF); //componente azul
				int convertedColor = (int) (0.3 * r + 0.59 * g + 0.11 * b);
				raster.setSample(w, h, 0, convertedColor);
			}
		return newImage;

	}

	public static BufferedImage toBlackWhite(BufferedImage sourceImage, double threshold) {
		int sourceHeight = sourceImage.getHeight();
		int sourceWidth = sourceImage.getWidth();
		BufferedImage newImage = new BufferedImage(sourceHeight, sourceWidth, BufferedImage.TYPE_BYTE_BINARY);
		WritableRaster raster = newImage.getRaster();
		for(int h=0; h < sourceHeight; h++) //Percorre a horizontal
			for(int w = 0; w < sourceWidth; w++) {//Percorre a vertical
				int rgb = sourceImage.getRGB(w, h);
				int r = (int) ((rgb&0xFF0000) >>> 16); // componente vermelho
				int g = (int) ((rgb&0xFF00) >>> 8); // componente verde
				int b = (int) (rgb&0xFF); //componente azul
				int convertedColor = (r + g + b)/3 < (255 * threshold) ? 0 : 1;
				raster.setSample(w, h, 0, convertedColor);
			}
		return newImage;
	}

	public static BufferedImage splitRGB(BufferedImage sourceImage, int component, int mask, int shift) {
		int sourceHeight = sourceImage.getHeight();
		int sourceWidth = sourceImage.getWidth();
		BufferedImage newImage = new BufferedImage(sourceHeight, sourceWidth, BufferedImage.TYPE_INT_RGB);
		WritableRaster raster = newImage.getRaster();
		for(int h=0; h < sourceHeight; h++) //Percorre a horizontal
			for(int w = 0; w < sourceWidth; w++) {//Percorre a vertical
				int rgb = sourceImage.getRGB(w, h);
				int componentColor = (int) ((rgb&mask) >>> shift);
				raster.setSample(w, h, component, componentColor);
			}
		return newImage;
	}

	public static void main(String[] args) {
		ImageApp ia = new ImageApp();
		// Carrega circle.png
		BufferedImage sourceImage = loadImage("./circle.png");
		ia.apresentaImagem(new JFrame("Imagem fonte, circle.pmg"), sourceImage);
		printImageSize(sourceImage, "source/circle.png");

		// Reduza de 1/4 a resolucao da imagem circle.png e apresente esta imagem.
		BufferedImage resizedImage = resizeImage(sourceImage, 0.25);
		ia.apresentaImagem(new JFrame("Imagem com resolucao reduzida em 1/4"), resizedImage);
		printImageSize(resizedImage, "resizedImage");

		// Transforme a imagem circle.png em tons de cinza e a apresente.
		BufferedImage grayScaledImage = toGrayScale(sourceImage);
		ia.apresentaImagem(new JFrame("Imagem transformada para escala de cinza"), grayScaledImage);
		printImageSize(grayScaledImage, "grayScaledImage");

		// Transforme a imagem circle.png em imagem binaria e a apresenta.
		BufferedImage blackWhiteImage = toBlackWhite(grayScaledImage, 0.75);
		ia.apresentaImagem(new JFrame("Imagem transformada para escala binaria (a partir da escala de cinza)"), blackWhiteImage);
		printImageSize(blackWhiteImage, "blackWhiteImage");

		// Imagem Vermelho
		BufferedImage redImage = splitRGB(sourceImage, 0, 0xFF0000, 16);
		ia.apresentaImagem(new JFrame("Imagem transformada para tom de vermelho"), redImage);

		// Imagem Verde
		BufferedImage greenImage = splitRGB(sourceImage, 1, 0xFF00, 8);
		ia.apresentaImagem(new JFrame("Imagem transformada para tom de verde"), greenImage);

		// Imagem Azul
		BufferedImage blueImage = splitRGB(sourceImage, 2, 0xFF, 0);
		ia.apresentaImagem(new JFrame("Imagem transformada para tom de azul"), blueImage);

	}
}
