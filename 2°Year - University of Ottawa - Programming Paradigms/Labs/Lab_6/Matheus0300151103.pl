addSecond(List, Answer) :- addSecond(List, 0, Answer).
addSecond([], X, X).
addSecond([_], X, X).
addSecond([_,H|T], X, S) :-
	Y is X + H,
	addSecond(T, Y, S).