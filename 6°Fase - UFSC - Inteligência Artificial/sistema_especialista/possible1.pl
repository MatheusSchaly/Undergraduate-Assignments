/*
# bordeaux_blanc
# sauvignon_Blanc
# riesling
# rosé_de_Provence
# pinot_Noir
# chianti_novo
# chianti_Reserva
# cabernet_Sauvignon
# merlot
# champagne_Rosé
*/
:- use_module(library(readutil)).


wine(bordeaux_blanc).
wine(sauvignon_Blanc).
wine(riesling).
wine(rosé_de_Provence).
wine(pinot_Noir).
wine(chianti_novo).
wine(chianti_Reserva).
wine(cabernet_Sauvignon).
wine(merlot).
wine(champagne_Rosé).

/* ############################ COLORS #######################*/
/*White*/
white(bordeaux_blanc).
white(sauvignon_Blanc).
white(riesling).

/*Rosé*/
rose(rosé_de_Provence).
rose(champagne_Rosé).

/*Tinto*/
red(pinot_Noir).
red(chianti_novo).
red(chianti_Reserva).
red(cabernet_Sauvignon).
red(merlot).

/* ############################ TYPE #######################*/
/*Seco*/
dry(bordeaux_blanc).
dry(sauvignon_Blanc).
dry(pinot_Noir).
dry(chianti_novo).
dry(chianti_Reserva).
dry(cabernet_Sauvignon).
dry(merlot).
dry(champagne_Rosé).

/*Demi-Seco*/
demi_sec(riesling).
demi_sec(rosé_de_Provence).

/* ############################ BODY #######################*/
/*Corpo: leve*/
light_bodied(bordeaux_blanc).
light_bodied(sauvignon_Blanc).
light_bodied(riesling).
light_bodied(rosé_de_Provence).
light_bodied(champagne_Rosé).

/*Corpo: medio*/
medium_bodied(chianti_novo).
medium_bodied(merlot).

/*Corpo: Encorpado*/
full_bodied(pinot_Noir).
full_bodied(chianti_Reserva).
full_bodied(cabernet_Sauvignon).

/* ############################ ACIDITY #######################*/
/*Acidez: leve*/
low_acidity(riesling).
low_acidity(rosé_de_Provence).
low_acidity(chianti_Reserva).
low_acidity(champagne_Rosé).

/*Acidez: media*/
medium_acidity(bordeaux_blanc).
medium_acidity(merlot).
medium_acidity(pinot_Noir).
medium_acidity(chianti_novo).

/*Acidez: alta*/
high_acidity(cabernet_Sauvignon).
high_acidity(sauvignon_Blanc).

/* AROMA FRUITY? */

fruity(riesling).
fruity(rosé_de_Provence).

showNameListWithCode() :- atomics_to_string(
    ["P1 = Peixes ao vapor ou camarões ou mexilhões",
    "P2 = Frutos do mar ou peixes fritos ou grelhados",
    "P3 = Peixes defumados",
    "L1 = Com legumes e molhos delicados",
    "L2 = Legumes como beringela e abobrinha",
    "M1 = Massas com molho de tomates",
    "M2 = Massas com molhos mais gordurosos e encorpados",
    "M3 = Massas ao alho e óleo",
    "CB1 = Carne de porco e aves cozidas",
    "CV1 = Com carnes vermelhas grelhadas",
    "CV2 = Se a carne é servida com molhos ou assada",
    "S1 = Sobremesas com frutas"], '\n', String), writeln(String). 

% Chamar esta função
/* Exemplo de consulta 
?- suggest(P).
Dish code: ex P1, P2,... then [enter]
|: P2
P = rosé_de_Provence ;
false.
*/
suggest(X) :- showNameListWithCode(), write("Dish code: ex P1 then [enter]"), nl, read_line_to_string(user_input, P), getWine(P, X).

getWine("P1", X) :- white(X), dry(X), light_bodied(X).
getWine("P2", X) :- rose(X), fruity(X).
getWine("P3", X) :- white(X), dry(X), high_acidity(X).
getWine("L1", X) :- white(X), low_acidity(X), fruity(X).
getWine("L2", X) :- red(X), full_bodied(X).
getWine("M1", X) :- red(X), full_bodied(X).
getWine("M2", X) :- red(X), high_acidity(X).
getWine("M3", X) :- red(X), medium_bodied(X).
getWine("CB1", X) :- light_bodied(X), medium_acidity(X).
getWine("CV1", X) :- red(X), dry(X), medium_acidity(X).
getWine("CV2", X) :- full_bodied(X), high_acidity(X).
getWine("S1", X) :- fruity(X), (white(X) ; rose(X)).


