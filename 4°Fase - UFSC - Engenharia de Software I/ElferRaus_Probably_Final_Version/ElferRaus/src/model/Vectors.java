/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;


/** description: "Projeto de Engenharia de Software 2019.1"
#   authors:
#   "Francisco Luiz Vicenzi",
#   "Matheus Schaly",
#   "Uriel Kindermann"
    Copyright 2019
*/

public class Vectors {
    private String colour;
    private boolean middle;
    private int left;
    private int right;

    public Vectors(String color) {
        this.colour = color;
        this.middle = false;
        this.left = 11;
        this.right = 11;
    }

    public String getColour() {
        return colour;
    }

    public void setColour(String colour) {
        this.colour = colour;
    }

    public boolean isMiddle() {
        return middle;
    }

    public void setMiddle(boolean middle_) {
        this.middle = middle_;
    }

    public int getLeft() {
        return left;
    }

    public void setLeft(int left) {
        this.left = left;
    }

    public int getRight() {
        return right;
    }

    public void setRight(int right) {
        this.right = right;
    }
    
    
    
    
    
}
