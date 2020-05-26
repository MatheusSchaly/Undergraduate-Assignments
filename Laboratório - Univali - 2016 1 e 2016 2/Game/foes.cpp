#include <iostream>
#include <vector>
#include <math.h>
#include <algorithm>

#include "foes.h"
#include "general.h"

// Creates the foes' interactions:

void foeInteraction (int foeNumber, int territory, int &life) {

    std::vector <std::string> words2, words3, words4;
    std::vector <int> prob1;
    std::string empty, fightOrFlee, giantAction, talkOrRun;
    int giantLife, manLife;

    giantLife = 100;
    manLife = 100;
    empty = "there is no one there.";

    switch (territory) {

        case 3:
            switch (foeNumber) {
                case 1:
                    std::cout << empty;
                    break;
                case 2:
                    std::cout << "you see a furious giant, choose: ";
                    words2 = {"fight", "flee"};
                    fightOrFlee = checkWords(2, words2);
                    std::cout << std::endl;
                    while (giantLife > 0 && life > 0 && fightOrFlee == "fight") {
                        if (fightOrFlee == "fight") {
                            words3 = {"He tries to grab you, ", "He tries to seize you, "};
                            prob1 = {50, 50};
                            giantAction = randomizeWordsWithProbability(2, prob1, words3);
                            std::cout << "The giant action is: " << giantAction << std::endl;
                        }
                        if (giantAction == "He tries to grab you, " || giantAction == "He tries to seize you, ") {
                            std::cout << giantAction;
                            giantCombat(life, giantLife);
                        }
                        if (giantLife > 0 && life > 0) {
                            fightOrFlee = checkWords(2, words2);
                            std::cout << std::endl;
                        }
                    }
                    if (fightOrFlee == "fight") {
                        if (life > 0) {
                            std::cout << "You've killed the beast!\n";
                        } else {
                            if (giantLife <= 0) {
                                std::cout << "You've killed the beast, but died while doing so!";
                            } else {
                                std::cout << "You've died trying to kill the beast!";
                            }
                        }
                    }
                    break;
                case 3:
                    std::cout << "you came into an ambush, with approximately 20 men. Choose: ";
                    words4 = {"talk", "run"};
                    talkOrRun = checkWords(2, words4);
                    if (talkOrRun == "run") {
                        ambushRun(life);
                        if (life < 1) {
                            std::cout << "You've died trying to scape!";
                        }
                    } else {
                        ambushTalk(life, manLife);
                    }
                    break;
                default:
                    std::cout << "there are sleepy monkeys in the trees around you, choose: ";
                    sleepyMonkeys (life);
                    break;
            }
            break;

        case 4:
            switch (foeNumber) {
                case 1:
                    std::cout << empty;
                    break;
                case 2:
                    std::cout << "you see a troll, choose: ";
                    break;
                case 3:
                    std::cout << "you see a group of people, choose: ";
                    break;
                default:
                    std::cout << "there are wild bulls all around the field, choose: ";
                    break;
            }
            break;

        default:
            switch (foeNumber) {
                case 1:
                    std::cout << empty;
                    break;
                case 2:
                    std::cout << "you see an orc, choose: ";
                    break;
                case 3:
                    std::cout << "you see a wagon coming at your direction, choose: ";
                    break;
                default:
                    std::cout << "there are sheep blocking the road, choose: ";
                    break;
            }
            break;
    }

}

// Sleepy monkeys:

void sleepyMonkeys (int &life) {



}

// Ambush talk:

void ambushTalk (int &life, int &foeLife) {

    std::vector <std::string> words5, words6;
    std::string answer;
    int i;


    std::cout << "I'm just a pious priest going to the church. / Do you dare to point your weapons to THE GREATEST WARRIOR OF THE KINGDOM!? Choose: ";
    words5 = {"priest", "warrior"};
    answer = checkWords (2, words5);

    if (answer == "priest") {
        std::cout << "Unknown man: \"If you are really a priest, you know how to read and write. So spell the word used to address the king, you have three chances:\" ";
        std::cin >> answer;
        std::transform (answer.begin(), answer.end(), answer.begin(), ::tolower);
        i = 0;
        do {
            i++;
            if (answer != "lord") {
                if (i == 1) {
                    std::cout << "Unknown man: \"That's not right \"priest\", try it again:\" ";
                    std::cin >> answer;
                    std::transform(answer.begin(), answer.end(), answer.begin(), ::tolower);
                }
                if (i == 2) {
                    std::cout << "Unknown man: \"I'm smelling a lie:\" ";
                    std::cin >> answer;
                    std::transform(answer.begin(), answer.end(), answer.begin(), ::tolower);
                }
                if (i == 3) {
                    std::cout << "Unknown man: \"And liars must die!\"";
                }
            }
        } while (i < 4 && answer != "lord");
        if (answer != "lord") {
            std::cout << "\nYou've died in the ambush.";
            life = 0;
        }
        else {
            std::cout << "Unknown man: \"Good job priest, you can follow you path safely.\"";
        }
    }
    else {
        std::cout << "Unknown man: \"If you are who you say, you'll not have problems fighting with OUR greatest warrior.\" Choose: ";
        words6 = {"run", "fight"};
        answer = checkWords (2, words6);
        if (answer == "run") {
            ambushRun (life);
        }
        else {
            ambushCombat (life, foeLife);
        }
    }
}

// Calculates the man's damage and character's damage:

void ambushCombat (int &life, int &foeLife) {

    std::vector<std::string> words7, words8, words9, words10, characterPenaltyText, foePenaltyText;
    std::vector<int> foePenalty, characterPenalty, characterPenaltyTextQuantity, foePenaltyTextQuantity;
    std::string answer;
    int foeDamage, foeDamageChanged, characterDamage, characterDamageChanged, action;

    characterDamage = randomizeNumber(10) + 3;
    foeDamage = randomizeNumber(10) + 2;

    std::cout << "A furious man comes running at your direction. With a giant sword.\n";
    std::cout << "You enter despair and throw your sword ai him and...\n";
    answer = "throw";
    action = randomizeNumber(10);
    if (answer == "throw") {
        if (action < 6) {
            std::cout << "You've missed.\n";
            characterDamageChanged = 0;
            characterPenalty.push_back(3);
            characterPenaltyText.push_back("Fighting with a knife");
            characterPenaltyTextQuantity.push_back(1);
            dealsDamagePenalty(characterDamageChanged, foeLife, characterPenalty, characterPenaltyText,
                               characterPenaltyTextQuantity);
        } else {
            std::cout << "Your sword slightly hit his right arm.\n";
            characterDamageChanged = characterDamage * 6;
            foePenalty.push_back(4);
            foePenaltyText.push_back("Wounded right arm");
            foePenaltyTextQuantity.push_back(1);
            dealsDamagePenalty(characterDamageChanged, foeLife, characterPenalty, characterPenaltyText,
                               characterPenaltyTextQuantity);
        }
        std::cout << "He reached you and tried to strike your chest.\n";
        std::cout << "Try to tumble and hit him back while doing so. / Try to parry it with your knife. . Choose: ";
        words8 = {"tumble", "parry"};
        answer = checkWords(2, words8);
        action = randomizeNumber(10);
        if (answer == "tumble") {
            if (action < 4) {
                std::cout
                        << "You are not so good at tumbling, you stabbed your own leg while doing so. Also, he kicked your stomach.\n";
                foeDamageChanged = foeDamage * 4;
                characterPenalty.push_back(2);
                characterPenaltyText.push_back("Stabbed leg");
                characterPenaltyTextQuantity.push_back(1);
                receivesDamagePenalty(foeDamageChanged, life, foePenalty, foePenaltyText, foePenaltyTextQuantity);
            } else {
                std::cout << "You stroke your knife at your opponent's leg.\n";
                characterDamageChanged = characterDamage * 6;
                foePenalty.push_back(4);
                foePenaltyText.push_back("Stabbed leg");
                foePenaltyTextQuantity.push_back(1);
                dealsDamagePenalty(characterDamageChanged, foeLife, characterPenalty, characterPenaltyText,
                                   characterPenaltyTextQuantity);
            }
        } else {
            if (action < 7) {
                std::cout
                        << "You tried to parry a giant sword with a knife and didn't succeeded. He removed a big chunk of flesh out of your chest.\n";
                foeDamageChanged = foeDamage * 6;
                characterPenalty.push_back(3);
                characterPenaltyText.push_back("Shattered chest");
                characterPenaltyTextQuantity.push_back(1);
                receivesDamagePenalty(foeDamageChanged, life, foePenalty, foePenaltyText, foePenaltyTextQuantity);
            } else {
                std::cout
                        << "You incredibly parried a giant sword with your knife (surprising everyone). Then smashed his knee with a kick, breaking it.\n";
                characterDamageChanged = characterDamage * 9;
                foePenalty.push_back(4);
                foePenaltyText.push_back("Broken knee");
                foePenaltyTextQuantity.push_back(1);
                dealsDamagePenalty(characterDamageChanged, foeLife, characterPenalty, characterPenaltyText,
                                   characterPenaltyTextQuantity);
            }
        }
        if (life > 0 && foeLife > 0) {
            std::cout << "He enters in rage and tries to pierce you with his sword.\n";
            std::cout
                    << "Try to evade with your body to the left. And cut his neck thereafter. / Try to shift his sword's trajectory using your knife, and cut his neck thereafter. Choose: ";
            words9 = {"body", "knife"};
            answer = checkWords(2, words9);
            action = randomizeNumber(10);
            if (answer == "body") {
                if (action < 4) {
                    std::cout << "You moved too slowly. He cut through your right arm, hurting you strongly.\n";
                    foeDamageChanged = foeDamage * 6;
                    characterPenalty.push_back(3);
                    characterPenaltyText.push_back("Sliced right arm");
                    characterPenaltyTextQuantity.push_back(1);
                    receivesDamagePenalty(foeDamageChanged, life, foePenalty, foePenaltyText, foePenaltyTextQuantity);
                } else {
                    std::cout
                            << "You successfully evade his attack. As you had to be fast, you only sliced his back instead of his neck.\n";
                    characterDamageChanged = characterDamage * 9;
                    foePenalty.push_back(4);
                    foePenaltyText.push_back("Sliced");
                    foePenaltyTextQuantity.push_back(1);
                    dealsDamagePenalty(characterDamageChanged, foeLife, characterPenalty, characterPenaltyText,
                                       characterPenaltyTextQuantity);
                }
            } else {
                if (action < 7) {
                    std::cout
                            << "Your knife couldn't deflect his giant sword. He pierced your pelvis, hurting you strongly.\n";
                    foeDamageChanged = foeDamage * 7;
                    characterPenalty.push_back(4);
                    characterPenaltyText.push_back("Destroyed pelvis");
                    characterPenaltyTextQuantity.push_back(1);
                    receivesDamagePenalty(foeDamageChanged, life, foePenalty, foePenaltyText, foePenaltyTextQuantity);
                } else {
                    std::cout
                            << "You deflected his giant sword with your sword (surprising everyone). As you had to be fast, you only sliced his back instead of his neck.\n";
                    characterDamageChanged = characterDamage * 10;
                    foePenalty.push_back(5);
                    foePenaltyText.push_back("Broken knee");
                    foePenaltyTextQuantity.push_back(1);
                    dealsDamagePenalty(characterDamageChanged, foeLife, characterPenalty, characterPenaltyText,
                                       characterPenaltyTextQuantity);
                }
            }
        }
        if (life > 0 && foeLife > 0) {
            std::cout
                    << "You two still standing, there is blood running across the grass . You two are facing each other. He starts to get closer.\n";
            std::cout
                    << "Run toward him and at the last moment, jump and try to pierce his heart. / Walk toward him and suddenly stick your knife in his heart. Choose: ";
            words10 = {"run", "walk"};
            answer = checkWords(2, words10);
            action = randomizeNumber(10);
            if (answer == "run") {
                if (action < 3) {
                    std::cout << "While jumping, he swing his blade and slightly hit your ankle.\n";
                    std::cout << "But you could still pierce his heart with your knife.\n";
                    foeDamageChanged = foeDamage * 2;
                    characterPenalty.push_back(1);
                    characterPenaltyText.push_back("Injured ankle");
                    characterPenaltyTextQuantity.push_back(1);
                    receivesDamagePenalty(foeDamageChanged, life, foePenalty, foePenaltyText, foePenaltyTextQuantity);
                    characterDamageChanged = characterDamage * 28;
                    foePenalty.push_back(6);
                    foePenaltyText.push_back("Without heart");
                    foePenaltyTextQuantity.push_back(1);
                    dealsDamagePenalty(characterDamageChanged, foeLife, characterPenalty, characterPenaltyText,
                                       characterPenaltyTextQuantity);
                } else {
                    std::cout << "While jumping, you precisely targeted his heart, and stroke exactly his heart.\n";
                    characterDamageChanged = characterDamage * 30;
                    foePenalty.push_back(15);
                    foePenaltyText.push_back("Without heart");
                    foePenaltyTextQuantity.push_back(1);
                    dealsDamagePenalty(characterDamageChanged, foeLife, characterPenalty, characterPenaltyText,
                                       characterPenaltyTextQuantity);
                }
            } else {
                if (action < 4) {
                    std::cout << "While trying to stab him, he swing his blade and slightly hit your left shoulder.\n";
                    std::cout << "But you could still pierce his heart with your knife.\n";
                    foeDamageChanged = foeDamage * 3;
                    characterPenalty.push_back(1);
                    characterPenaltyText.push_back("Injured shoulder");
                    characterPenaltyTextQuantity.push_back(1);
                    receivesDamagePenalty(foeDamageChanged, life, foePenalty, foePenaltyText, foePenaltyTextQuantity);
                    characterDamageChanged = characterDamage * 27;
                    foePenalty.push_back(13);
                    foePenaltyText.push_back("Without heart");
                    foePenaltyTextQuantity.push_back(1);
                    dealsDamagePenalty(characterDamageChanged, foeLife, characterPenalty, characterPenaltyText,
                                       characterPenaltyTextQuantity);
                } else {
                    std::cout
                            << "While trying to stab him, you moved so quickly, that you precisely targeted his heart, and stroke exactly his heart.\n";
                    characterDamageChanged = characterDamage * 29;
                    foePenalty.push_back(14);
                    foePenaltyText.push_back("Without heart");
                    foePenaltyTextQuantity.push_back(1);
                    dealsDamagePenalty(characterDamageChanged, foeLife, characterPenalty, characterPenaltyText,
                                       characterPenaltyTextQuantity);
                }
            }
            if (life > 0 && foeLife <= 0) {
                std::cout << "After 5 seconds, he fell to the floor, dead...";
                std::cout << "You took whatever you wanted and left the ambush.";
            } else {
                if (life <= 0 && foeLife <= 0) {
                    std::cout << "After 5 seconds, he fell to the floor, dead. Five second later, you died...";
                }
            }
        }
    }
}

// Calculates the ambush's damage while trying to run:

void ambushRun(int &life) {

    int foeDamage;

    foeDamage = randomizeNumber(10);

    if (foeDamage > 9) {
        std::cout << "You ran but you were pierced by an arrow in the chest.\n";
        foeDamage = round(life * 0.9);
        receivesDamage(foeDamage, life);
    } else {
        if (foeDamage > 7) {
            std::cout << "You ran but you were pierced by an arrow in your right leg.\n";
            foeDamage = round(life * 0.4);
            receivesDamage(foeDamage, life);
        } else {
            if (foeDamage > 4) {
                std::cout << "You ran but you were pierced by an arrow in your right arm.\n";
                foeDamage = round(life * 0.2);
                receivesDamage(foeDamage, life);
            } else {
                std::cout << "You escaped safely.\n";
                foeDamage = 0;
                receivesDamage(foeDamage, life);
            }
        }
    }
}

// Calculates the giant's damage and character's damage:

void giantCombat(int &life, int &foeLife) {

    int foeDamage, characterDamage;

    characterDamage = randomizeNumber(10);
    foeDamage = randomizeNumber(10);

    if (characterDamage > 9) {
        std::cout << "but while he is trying to do it, you strike him right in the face.\n";
        characterDamage *= 8;
        dealsDamage(characterDamage, foeLife);
    } else {
        if (characterDamage > 7) {
            std::cout << "but while he is trying to do it, you strike him right in the chest.\n";
            characterDamage *= 4;
            dealsDamage(characterDamage, foeLife);
        } else {
            if (characterDamage > 3) {
                std::cout << "but while he is trying to do it, you strike him right in the leg.\n";
                characterDamage *= 2;
                dealsDamage(characterDamage, foeLife);
            } else {
                std::cout << "you were not able to strike him.\n";
                characterDamage = 0;
                dealsDamage(characterDamage, foeLife);
            }
        }
    }

    if (foeDamage > 9) {
        std::cout
                << "Then, when he finally grabs you, he throws you eight meters away and you hit a sharp edge rock.\n";
        foeDamage *= 4;
        receivesDamage(foeDamage, life);
    } else {
        if (foeDamage > 7) {
            std::cout
                    << "Then, when he finally grabs you, he throws you six meters away and you hit a rotten tree.\n";
            foeDamage *= 2;
            receivesDamage(foeDamage, life);
        } else {
            if (foeDamage > 3) {
                std::cout
                        << "Then, when he finally grabs you, he throws you three meters away and you hit the ground.\n";
                receivesDamage(foeDamage, life);
            } else {
                std::cout << "And you successfully evades him.\n";
                foeDamage = 0;
                receivesDamage(foeDamage, life);
            }
        }
    }
}

// Informs the damage done by the foe, deals with penalties, and reduces your life:

void receivesDamagePenalty(int foeDamage, int &life, std::vector<int> foePenalty, std::vector<std::string> foePenaltyText, std::vector<int> foePenaltyTextQuantity) {

    int totalPenalties;

    totalPenalties = foePenalties(foePenalty, foePenaltyText, foePenaltyTextQuantity);
    foeDamage -= totalPenalties;

    if (foeDamage > 0) {
        std::cout << "Receiving " << foeDamage << " total damage.\n";
        life -= foeDamage;
        std::cout << "Your current life is: " << life << "\n\n";
    } else {
        std::cout << "Don't receiving any damage.\n";
        std::cout << "Your current life is: " << life << "\n\n";
    }
}

// Informs the damage done by you, deals with penalties, and reduces the foes' life:

void dealsDamagePenalty(int characterDamage, int &foesLife, std::vector<int> characterPenalty, std::vector<std::string> characterPenaltyText, std::vector<int> characterPenaltyTextQuantity) {

    int totalPenalties;

    totalPenalties = characterPenalties(characterPenalty, characterPenaltyText, characterPenaltyTextQuantity);
    characterDamage -= totalPenalties;

    if (characterDamage > 0) {
        std::cout << "Dealing " << characterDamage << " total damage.\n";
        foesLife -= characterDamage;
        std::cout << "The foes current life is: " << foesLife << "\n\n";
    } else {
        std::cout << "Don't dealing any damage.\n";
        std::cout << "The foes current life is: " << foesLife << "\n\n";
    }
}

// Calculates total penalties and show it:

int characterPenalties(std::vector<int> characterPenalty, std::vector<std::string> characterPenaltyText, std::vector<int> characterPenaltyTextQuantity) {

    int totalCharacterPenalty, i;
    totalCharacterPenalty = 0;

    for (i = 0; i < characterPenalty.size(); i++) {
        totalCharacterPenalty += characterPenalty[i];
    }

    if (totalCharacterPenalty < 1) {
        std::cout << "You aren't hurt yet.\n";
    } else {
        std::cout << "Your penalties are:\n";
        for (i = 0; i < characterPenalty.size(); i++) {
            std::cout << characterPenaltyTextQuantity[i] << " - " << characterPenaltyText[i] << " - Dealing "
                      << characterPenalty[i] << " less damage.\n";
        }
    }

    return totalCharacterPenalty;

}

// Calculates total penalties and show it:

int foePenalties(std::vector<int> foePenalty, std::vector<std::string> foePenaltyText, std::vector<int> foePenaltyTextQuantity) {

    int totalFoePenalty, i;
    totalFoePenalty = 0;

    for (i = 0; i < foePenalty.size(); i++) {
        totalFoePenalty += foePenalty[i];
    }

    if (totalFoePenalty < 1) {
        std::cout << "The foe isn't hurt yet.\n";
    } else {
        std::cout << "The foe's penalties are:\n";
        for (i = 0; i < foePenalty.size(); i++) {
            std::cout << foePenaltyTextQuantity[i] << " - " << foePenaltyText[i] << " - Dealing " << foePenalty[i] << " less damage.\n";
        }
    }

    return totalFoePenalty;

}

// Informs the damage done by the foe, and reduces your life:

void receivesDamage(int foeDamage, int &life) {

    if (foeDamage > 0) {
        std::cout << "Receiving " << foeDamage << " of damage.\n";
        life -= foeDamage;
        std::cout << "Your current life is: " << life << "\n\n";
    } else {
        std::cout << "Don't receiving any damage.\n";
        std::cout << "Your current life is: " << life << "\n\n";
    }
}

// Informs the damage done by you, and reduces the foes' life:

void dealsDamage(int characterDamage, int &foesLife) {

    if (characterDamage > 0) {
        std::cout << "Dealing " << characterDamage << " of damage.\n";
        foesLife -= characterDamage;
        std::cout << "The foes current life is: " << foesLife << "\n\n";
    } else {
        std::cout << "Don't dealing any damage.\n";
        std::cout << "The foes current life is: " << foesLife << "\n\n";
    }
}