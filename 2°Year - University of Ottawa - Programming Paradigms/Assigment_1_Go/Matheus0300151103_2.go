package main

import (
	"fmt"
	"math"
)

var n_hidden int = 3
var offset float64 = 1 // This is the input neuron in the input layer and hidden layer
var c_x_1 chan float64 = make(chan float64, n_hidden)
var c_x_2 chan float64 = make(chan float64, n_hidden)
var c_z_1 chan float64 = make(chan float64, 1)
var c_z_2 chan float64 = make(chan float64, 1)
var c_z_3 chan float64 = make(chan float64, 1)
var c_t chan float64 = make(chan float64, 1)

func main() {
	var A = [3][3]float64{
		{0.1, 0.3, 0.4},
		{0.5, 0.8, 0.3},
		{0.7, 0.6, 0.6},
	}
	var B = [4]float64{0.5, 0.3, 0.7, 0.1}

	// Prompts for N
	var N float64
	fmt.Print("Enter N: ")
	_, _ = fmt.Scan(&N)
	fmt.Println("N:", N)

	for k := float64(0); k < N; k++ {
		// Calculates the X neurons
		go calc_X1(k, N)
		go calc_X2(k, N)

		// Calculates the Z neurons
		for i := 0; i < n_hidden; i++ {
			go calc_Z(A[i][0], A[i][1], A[i][2], i)
		}

		// Calculates the T neuron
		go calc_T(B[0], B[1], B[2], B[3])

		// Print input, hidden and output neurons
		fmt.Println("T", k, ":", <-c_t)
	}
}

func calc_X1(k float64, N float64) {
	x1 := math.Sin(float64((2 * math.Pi * (k - 1)) / N))
	for i := 0; i < n_hidden; i++ {
		c_x_1 <- x1
	}
}

func calc_X2(k float64, N float64) {
	x2 := math.Cos(float64((2 * math.Pi * (k - 1)) / N))
	for i := 0; i < n_hidden; i++ {
		c_x_2 <- x2
	}
}

func calc_Z(A01 float64, A11 float64, A12 float64, index int) {
	calculated_z := sigmoid(A01*offset + A11*<-c_x_1 + A12*<-c_x_2)
	if index == 0 {
		c_z_1 <- calculated_z
	} else if index == 1 {
		c_z_2 <- calculated_z
	} else {
		c_z_3 <- calculated_z
	}
}

func calc_T(B01 float64, B11 float64, B12 float64, B13 float64) {
	Z1 := <-c_z_1
	Z2 := <-c_z_2
	Z3 := <-c_z_3
	c_t <- sigmoid(B01*offset + B11*Z1 + B12*Z2 + B13*Z3)
}

func sigmoid(v float64) float64 {
	return (1 / (1 + math.Pow(math.E, -v)))
}
