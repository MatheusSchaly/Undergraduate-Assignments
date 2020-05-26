#include <iostream>
#include <string>

unsigned short time = 0;

void semaphore(std::string &NS, std::string &EW, std::string &P, unsigned short reset) {
    if (reset == 1) {
        time = 0;
        NS = "green";
        EW = "red";
        P = "red";
    }
    if (time == 45) {   // after 45 seconds
        NS = "yellow";  // changes north-south traffic light to yellow
    }
    if (time == 50 || time == 105 || time == 135) {
        NS = "red";
        EW = "red";
        P = "red";
    }
    if (time == 55) {
        EW = "green";
    }
    if (time == 100) {
        EW = "yellow";
    }
    if (time == 110) {
        P = "green";
    }
    if (time == 140) {  // after 140 seconds
        NS = "green";   // changes north-south traffic light to green
        time = 0;       // resets timer
    }
    time ++;            // increases one second
}

void simulate() {
    std::string NS_light = "green", EW_light = "red", P_light = "red"; // initialization
    unsigned short reset = 0;

    for (unsigned int i = 1; i <= 420; i++) {  // simulates 420 clock pulses
        if (i == 65) {                         // simulates 5 consecutive resets after 65 clock pulses
            reset = 1;
        }
        if (i == 200) {                        // simulates one reset after 200 clock pulses
            reset = 1;
        }
        semaphore(NS_light, EW_light, P_light, reset);
        std::cout << "Pulse " << i << ": " << NS_light << ", " << EW_light << ", " << P_light << ", " << reset << std::endl;
        if (i == 70) {
            reset = 0;
        }
        if (i == 200) {
            reset = 0;
        }
    }
}

int main() {
    simulate();
    return 0;
}
