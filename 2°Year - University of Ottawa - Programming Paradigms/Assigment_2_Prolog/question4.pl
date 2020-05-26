divisible([H|T], N) :-
	N mod H =:= 0;
	divisible(T, N),
	!.
	
generateList(IL, N, OL) :-
	generateRange(0, N, R),
	Nn is N + 1, !,
	generateListH(IL, R, 1, Nn, OL).

% Helper function which considers every possible combination
% by considering the range list [1, 2, 3, 4, 5]
generateListH(_, _, N, N, []) :- !.
generateListH(IL, R, Rank, N, [I|OL]) :-
	member(I, R), 				% This garantees that all possibilites will be tasted
	not(divisible(IL, I)), 		% Checks if not divisible
	I =< Rank, 					% Checks if the element I from list R is less than current Rank
	RankN is Rank + 1, 			% Increases rank
	generateListH(IL, R, RankN, N, OL).
	
% Generates a list that ranges from 1 to N. In the.
% example case, the list created will be [1, 2, 3, 4, 5]
generateRange(S, S, []).
generateRange(I, S, [In|R]) :-
	In is I + 1,
	generateRange(In, S, R).
	