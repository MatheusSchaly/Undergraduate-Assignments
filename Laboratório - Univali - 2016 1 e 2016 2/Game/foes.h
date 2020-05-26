#include <vector>

#ifndef FOES_H
#define FOES_H

void foeInteraction (int foeNumber, int territory, int &life); // Creates the foes' interactions:
void giantCombat (int &life, int &foeLife); // Calculates the giant's damage and character's damage.
void receivesDamagePenalty (int foeDamage, int &life, std::vector <int> foePenalty, std::vector <std::string> foePenaltyText, std::vector <int> foePenaltyTextQuantity); // Informs the damage done by the foe, deals with penalties, and reduces your life.
void dealsDamagePenalty (int characterDamage, int &foesLife, std::vector <int> characterPenalty, std::vector <std::string> characterPenaltyText, std::vector <int> characterPenaltyTextQuantity); // Informs the damage done by you, deals with penalties, and reduces the foes' life.
void receivesDamage (int foeDamage, int &life); // Informs the damage done by the foe, and reduces your life.
void dealsDamage (int characterDamage, int &foesLife); // Informs the damage done by you, and reduces the foes' life.
int characterPenalties (std::vector <int> characterPenalty, std::vector <std::string> characterPenaltyText, std::vector <int> characterPenaltyTextQuantity); // Calculates character's total penalties and show it.
int foePenalties (std::vector <int> foePenalty, std::vector <std::string> foePenaltyText, std::vector <int> foePenaltyTextQuantity); // Calculates foe's total penalties and show it.
void ambushRun (int &life); // Calculates the ambush's damage while trying to run.
void ambushTalk (int &life, int &foeLife); // Ambush talk.
void ambushCombat (int &life, int &foeLife); // Ambush man combat.
void sleepyMonkeys (int &life); // Sleepy monkeys.

#endif
