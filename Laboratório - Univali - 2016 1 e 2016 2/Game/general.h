#include <vector>

#ifndef GENERAL_H
#define GENERAL_H

int readIntPositiveNumber (); // Validates a positive integer number.
int readIntIntervalNumber (int upperLimit, int lowerLimit); // Validates a number between limits.
int randomizeNumber (int n); // Randomizes a number.
int randomizeNumberWithProbability (int nQuantity, std::vector <int> probability); // Randomizes an vector with probabilities.
std::string randomizeWordsWithProbability (int nQuantity, std::vector <int> probability, std::vector <std::string> words); // Randomizes an vector of strings with probabilities.
std::string checkWords (int wordQuantity, std::vector <std::string> word); // Checks words.

#endif
