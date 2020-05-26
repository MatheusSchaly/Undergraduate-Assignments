adj(a,b).
adj(a,g).
adj(b,c).
adj(b,i).
adj(c,d).
adj(d,e).
adj(d,j).
adj(e,l).
adj(f,g).
adj(g,h).
adj(h,i).
adj(i,j).
adj(j,k).
adj(k,l).
adj(l,m).

color(red).
color(yellow).
color(blue).

generate(Gs, Cs) :-
	colorset(Gs, Cs),
	valid(Gs, Cs).

% Checks if the generated color set is valid
valid([], []).
valid([W|Ws], [C|Cs]) :-
	tryAdjs(W, Ws, C, Cs),
	valid(Ws, Cs).

% Checks if all the adj windows are valid
tryAdjs(_, [], _, []).
tryAdjs(W1, [W2|Ws], C1, [C2|Cs]) :-
	(	adj(W1, W2) ->
		C1 \= C2
	;
		true),
	tryAdjs(W1, Ws, C1, Cs).


diffadjcolor(W, C, Ws, Cs) :-
	tupleGenerator([W|Ws], [C|Cs], WCs),
	tester(WCs).

% Generates a structure like [(Window1, Color1), (Window2, Color2)...]
tupleGenerator([], [], []). 
tupleGenerator([W|Ws], [C|Cs], [(W, C)|WCs]) :-
	tupleGenerator(Ws, Cs, WCs).

% Testes all the combinations of windows
tester([]).
tester([WC| WCs]) :-
	checkAdjs(WC, WCs),
	tester(WCs).

% Checks all the adj windows
checkAdjs(_, []) :- !.
checkAdjs(WC, [WC2|WCs]) :-
	checkAdjs(WC, WCs),
	checkAdj(WC, WC2).
	
% Check a single adj window
checkAdj((W, C), (W2, C2)) :-
	(adj(W, W2) ->
		C \= C2;
		true).


colorset(Ws, C) :-
	colorGenerator(Ws, C).

% Generates all possible windows colors
colorGenerator([], []).
colorGenerator([_|Ws], [X|Q]) :-
	color(X),
	colorGenerator(Ws, Q).