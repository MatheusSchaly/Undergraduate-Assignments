#ifndef MOVEMENT_H
#define MOVEMENT_H

int movingVertically (std::string direction, int i); // Moves the character vertically.
int movingHorizontally (std::string direction, int j); // Moves the character horizontally.
void returnPosition (int &i, int &j, int n, int m, bool verticalMovement);// Return the character's position, if he is trying to go to an unreachable terrain.

#endif
