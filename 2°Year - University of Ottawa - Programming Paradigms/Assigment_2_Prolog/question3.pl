choice(marie, [peru,greece,vietnam]).
choice(jean, [greece,peru,vietnam]).
choice(sasha, [vietnam,peru,greece]).
choice(helena,[peru,vietnam,greece]).
choice(emma, [greece,peru,vietnam]).

where([N|Ns], C) :-
	choice(N, Cs),
	buildBasicTuples(Cs, 3, Ts),
	addPoints(Ns, Ts, TsN),
	findMax(TsN, 0, Cn, C).

% Finds the country that has the most points considering the
% structure [(Country1, Points1), (Country2, Points2)]
findMax([], _, CC, CC).
findMax([(C1, V)|Cs], Max, C2, CC) :-
	Vn is max(V, Max),
	(	Vn > Max ->
		Cn = C1
	;
		Cn = C2
	),
	findMax(Cs, Vn, Cn, CC).

% Adds points to all the countries considering all the country lists
addPoints([], X, X).
addPoints([N|Ns], Ts, X) :-
	choice(N, Cs),
	addPointsH(Cs, 3, Ts, TsN),
	addPoints(Ns, TsN, X).

% Adds points to all the counstries considering a single country list
addPointsH([], _, _, []).
addPointsH([C|Cs], Vs, Ts, [(C, Vn)|TsN]) :-
	member((C, V), Ts),
	Vn is V + Vs,
	VsN is Vs - 1,
	addPointsH(Cs, VsN, Ts, TsN).

% Creates a structure like [(Country1, Points1), (Country2, Points2)],
% this structure is created based on the first name of the input list
buildBasicTuples([], _, []).
buildBasicTuples([C|Cs], Vs, [(C, Vs)|Ts]) :-
	VsN is Vs - 1,
	buildBasicTuples(Cs, VsN, Ts).