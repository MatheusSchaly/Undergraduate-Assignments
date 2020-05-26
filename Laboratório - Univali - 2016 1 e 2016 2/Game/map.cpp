#include <iostream>

#include "map.h"
#include "movement.h"

// Colors

#define RED "\033[31m"
#define RESET "\033[0m"

// Show's the map's place:

std::string mapPlace (int n) {

    std::string terrain;

    switch (n) {
        case 0:
            terrain = "the sea";
            break;
        case 1:
            terrain = "lake";
            break;
        case 2:
            terrain = "hills";
            break;
        case 3:
            terrain = "a forest";
            break;
        case 4:
            terrain = "a open field";
            break;
        case 5:
            terrain = "a road";
            break;
    }

    return terrain;

}

// Checks the territories' availability:

void territoryAvailability (int map, int &i, int &j, int n, int m,  bool verticalMovement) {

    switch (map) {
        case 0: std::cout << "You don't know how to swim, you can't go to the sea!";
            break;
        case 1: std::cout << "You don't know how to swim, you can't go to a lake!";
            break;
        case 2: std::cout << "You don't know how to climb mountains, you can't go to the hills!";
            break;
    }

    if (map > -1 && map < 3) {
        returnPosition (i, j, n, m, verticalMovement);
    }

}