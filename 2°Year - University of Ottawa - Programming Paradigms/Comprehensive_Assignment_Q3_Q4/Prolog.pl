% Get lists
getListOfLists(Es_file, Ss_file, Es_lists, Ss_lists) :-
	readCsv(Es_file, Es_lists),
	readCsv(Ss_file, Ss_lists).
	
readCsv(Es_or_Ss, Lists) :-
	csv_read_file(Es_or_Ss, Rows),
	maplist(assert, Rows),
	rowsToLists(Rows, Lists).

rowsToLists(Rows, Lists):-
	maplist(rowToList, Rows, Lists).

rowToList(Row, List):-
	Row =.. [row|List].	

% Begin
findStableMatch(Es_file, Ss_file) :-					  % Used to add the M parameter
	findStableMatchHelper(Es_file, Ss_file, M),
	write(M). % Print the match

% Call stable matching
findStableMatchHelper(Es_file, Ss_file, M) :-
	getListOfLists(Es_file, Ss_file, Es_lists, Ss_lists), % Get the lists from the csv
	getM(Es_lists, M),									  % Get possible combination of matches
	test(M, _),											  % Test if the match is valid
	stableMatching(Es_lists, Ss_lists, M).				  % Test if the match is stable

test([], []).
test([M|Ms], [S|Ss]) :-
	!, 
	testHelper(M, S),
	test(Ms, Ss),
	not(member(S, Ss)).

testHelper([_|S], Sc) :-
	member(Sc, S).
	
getM([], []).
getM([E_Preferences|Es_Preferences], [M|L]) :-
	getMHelper(E_Preferences, M),
	getM(Es_Preferences, L).

getMHelper([E|Ss], L) :-
	member(S, Ss),
	L = [E, S].


% Stable matching algorithm
stableMatching(_, _, []).
stableMatching(L_employer_preference, L_student_preference, Ms) :-					% Used to duplicate Ms
	stableMatchingHelper(L_employer_preference, L_student_preference, Ms, Ms).

stableMatchingHelper(_, _, [], _).
stableMatchingHelper(L_employer_preference, L_student_preference, [M|Ms], AllMs) :-
	testM(L_employer_preference, L_student_preference, M, AllMs),					% Test if this particular match is a stable match
	stableMatchingHelper(L_employer_preference, L_student_preference, Ms, AllMs).	% Test the next match
	
testM(Es_preferences, Ss_preferences, [E|S], Ms) :-
	checkPreferred(Es_preferences, E, S, Ss_preferences, Ms),						% Check if employer has a stable student
	checkPreferred(Ss_preferences, S, E, Es_preferences, Ms).						% Check if student has a stable employer

checkPreferred(Es_or_Ss_preferences, E_or_S, S_or_E, Ss_or_Es_preferences, Ms) :-
	getPreferences(Es_or_Ss_preferences, E_or_S, [_|E_or_S_Preferences]), 			% Get employer//student list of preferences
	getDislikes(E_or_S_Preferences, S_or_E, Dislikes),	  		  					% Get how much the employer//student dislakes the current student//employer
	getPossibleMs(E_or_S_Preferences, Dislikes, PossibleMs),	  		  			% Get alternative of student//employer for the employer//student
	testPossibleMs(PossibleMs, Ss_or_Es_preferences, E_or_S, Ms).					% Test if the alternative is better than the current match

testPossibleMs([], _, _, _).
testPossibleMs([PossibleM|PossibleMs], Ss_or_Es_preferences, PossibleReM, Ms) :- 	
	getPreferences(Ss_or_Es_preferences, PossibleM, [_|S_or_E_Preferences]), 		% Get student//employer list of preferences
	getCurrentM(Ms, PossibleM, CurrentM),											% Get employer//student current match
	getDislikes(S_or_E_Preferences, CurrentM, DislikesCurrentM),					% Get how much the employer//student dislakes the current student//employer
	getDislikes(S_or_E_Preferences, PossibleReM, DislikesPossibleReM),				% Get how much the employer//student dislakes the possible new student//employer
	DislikesCurrentM < DislikesPossibleReM,											% If current match dislikes is smaller than possible new match dislikes, then try again
	testPossibleMs(PossibleMs, Ss_or_Es_preferences, PossibleReM, Ms).				% Try again

getCurrentM([M|Ms], PossibleM, CurrentM) :-											% Get the current match
	getCurrentMHelper(M, [PossibleM], CurrentM);   	
	getCurrentM(Ms, PossibleM, CurrentM), !.

getCurrentMHelper([CurrentM|PossibleM], PossibleM, CurrentM) :- !.
getCurrentMHelper([PossibleM|CurrentM], [PossibleM|_], CurrentM).
	
getPossibleMs(_, 1, []) :- !.
getPossibleMs([E_or_S_Preference|E_or_S_Preferences], Dislikes, [E_or_S_Preference|PossibleMs]) :- % Get the possible matches
	DislikesN is Dislikes - 1,
	getPossibleMs(E_or_S_Preferences, DislikesN, PossibleMs).

getDislikes([E_or_S_current|_], [E_or_S_current|_], 1) :- !.						% Get how much the employer//student dislikes the student//employer
getDislikes([E_or_S_current|_], E_or_S_current, 1) :- !.
getDislikes([_|Preferences], E_or_S_current, DislikesN) :-
	getDislikes(Preferences, E_or_S_current, Dislikes),
	DislikesN is Dislikes + 1.

getPreferences(Es_or_Ss_preferences, [S|_], Preferences) :-
	!, getPreferences(Es_or_Ss_preferences, S, Preferences).	
getPreferences(Es_or_Ss_preferences, E_or_S, Preferences) :-						% Get the preferences of the employer//student
	member(E_or_S_preference, Es_or_Ss_preferences),
	member(E_or_S, E_or_S_preference), !,
	Preferences = E_or_S_preference.