% Example queries:
% ?- get_3x3_matrices_1(Rows, Colors), straights(Rows, Colors).
% ?- get_4x4_matrices_1(Rows, Colors), straights(Rows, Colors).
% ?- get_5x5_matrices_1(Rows, Colors), straights(Rows, Colors).
% ?- get_5x5_matrices_2(Rows, Colors), straights(Rows, Colors).
% ?- get_6x6_matrices_1(Rows, Colors), straights(Rows, Colors).
% ?- get_9x9_matrices_1(Rows, Colors), straights(Rows, Colors).

% Examples matrices:

% 3x3 example matrices
get_3x3_matrices_1(Rows, Colors) :- 
Rows = [[_,2,_],
		[_,0,_],
		[_,_,3]],
Colors = [[0,1,0],
		  [0,1,0],
		  [0,0,0]].

% 4x4 example matrices
get_4x4_matrices_1(Rows, Colors) :- 
Rows = [[_,4,1,_],
		[0,_,_,_],
		[_,1,0,_],
		[_,_,0,_]],
Colors = [[0,1,0,0],
		  [1,0,0,0],
		  [0,0,1,0],
		  [0,0,1,0]].

% 5x5 example matrices
get_5x5_matrices_1(Rows, Colors) :- 
Rows =  [[_,3,0,_,2],
		 [3,_,_,_,5],
		 [_,0,_,2,_],
		 [1,_,4,0,_],
		 [0,_,_,_,0]],
Colors = [[0,0,1,0,1],
		  [0,0,0,0,0],
		  [0,1,0,1,0],
		  [1,0,0,1,0],
		  [1,0,0,0,1]].
		  
get_5x5_matrices_2(Rows, Colors) :- 
Rows =  [[4,_,3,_,5],
		 [0,_,_,_,1],
		 [0,0,5,0,0],
		 [0,_,_,4,_],
		 [1,_,0,_,0]],
Colors = [[0,0,0,0,1],
		  [1,0,0,0,0],
		  [1,1,1,1,1],
		  [1,0,0,0,0],
		  [1,0,1,0,1]].

% 6x6 example matrices
get_6x6_matrices_1(Rows, Colors) :- 	
Rows = [[0,_,_,1,0,0],
		[0,_,_,_,5,_],
		[0,_,1,_,_,_],
		[4,_,_,_,_,0],
		[_,6,5,_,_,0],
		[0,0,0,_,1,4]],
Colors = [[1,0,0,1,1,1],
		  [1,0,0,0,0,0],
		  [1,0,0,0,0,0],
		  [0,0,0,0,0,1],
		  [0,0,0,0,0,1],
		  [1,1,1,0,0,1]].
		  
% 9x9 example matrices
get_9x9_matrices_1(Rows, Colors) :- 	
Rows = [[0,0,_,5,0,1,_,3,0],
		[_,9,_,3,_,2,_,_,_],
		[7,_,1,_,_,_,0,_,5],
		[5,0,0,4,_,0,_,8,6],
		[0,_,_,_,_,_,_,_,0],
		[8,_,4,0,_,_,0,0,_],
		[_,1,0,_,_,_,5,4,_],
		[_,_,_,_,_,_,_,_,_],
		[0,7,_,9,0,5,6,0,0]],
Colors = [[1,1,0,0,1,0,0,1,1],
		  [0,0,0,0,0,0,0,0,0],
		  [0,0,1,0,0,0,1,0,0],
		  [0,1,1,0,0,1,0,0,1],
		  [1,0,0,0,0,0,0,0,1],
		  [1,0,0,1,0,0,1,1,0],
		  [0,0,1,0,0,0,1,0,0],
		  [0,0,0,0,0,0,0,0,0],
		  [1,1,0,0,1,0,0,1,1]].
		  
:- use_module(library(clpfd)).								% Used to apply constraint logic programming over finite domains

straights(Rows, Colors) :-
	write("\nMain matrix input:\n"),
	showMatrix(Rows),										% Shows main input matrix			
	write("\nColor matrix input:\n"),
	showMatrix(Colors),										% Shows color input matrix
	length(Rows, Upper_N),									% Gets number of rows
	fillBlacks(Rows, Colors, 0, Filled_Rows, Lower_N),		% Replaces black empty cells with progressively decresing negative numbers							
	
	append(Filled_Rows, Vs),								% Appends every list in Filled_Rows into a single list
	Vs ins Lower_N..Upper_N,								% Constraints main matrix to range from lowest matrix value to its lenght
	maplist(all_distinct, Filled_Rows),						% Constraints each row to contain only distinct values
	transpose(Filled_Rows, Filled_Columns),					% Transposes the main matrix
	maplist(all_distinct, Filled_Columns),					% Constraints each column to contain only distinct values
	transpose(Colors, ColorsT),								% Transposes the color matrix
	testWhites(Filled_Rows, Colors),						% Checks, in each row, if every sequence of white cells is valid
	testWhites(Filled_Columns, ColorsT),					% Checks, in each column, if every sequence of white cells is valid
	
	maplist(label, Filled_Rows),							% Gets a valid solid (without range) solution
	write("\nPossible solution:\n"),
	showMatrix(Rows).										% Shows a solution

% Base case, both main and color matrices are empty
testWhites([], []) :- !.

% Recursive case, both main and color matrices still have rows to test
testWhites([H1|T1], [H2|T2]) :-
	testSubWhites(H1, H2, []),
	testWhites(T1, T2).

% Base case, both main and color rows are empty
testSubWhites([], [], []) :- !.

% Base case, both main and color rows are empty but Acc has elements to be checked
testSubWhites([], [], Acc) :- !,
	checkSequence(Acc).

% Recursive case, main row has a value and color matrix has a black cell
testSubWhites([_|T1], [1|T2], Acc) :- !,
	checkSequence(Acc),
	testSubWhites(T1, T2, []).

% Recursive case, main row has a value and color matrix has a white cell
% Applies a constraint which states that each value has to be greater than 0
testSubWhites([H1|T1], [0|T2], Acc) :-
	H1 #> 0,
	testSubWhites(T1, T2, [H1|Acc]).

% Base Case, list to check is empty
checkSequence([]) :- !.

% Base case, we reached the last element, which doesn't need to be checked
checkSequence([_|[]]) :- !.

% Checks if a sequence of white cells is valid
% Applies a contraint which states that the maximum and minimum value of the
% row has to be equal its length minus 1
checkSequence(Acc) :-
	constraint_list_min(Acc, Min),
	constraint_list_max(Acc, Max),
	length(Acc, N1),
	N2 = N1 - 1,
	Max - Min #= N2,
	constraint_min_max(Acc, Max, Min).

% Base case, no more number are left to check
constraint_min_max([], _, _) :- !.

% Recursive case, checks if each value is between (or equal) Max and Min value
% Applies two contraints which state that each element in a white strip has to be
% between (or equal) the maximum and minimum values of the string
constraint_min_max([H|T], Max, Min) :-
	H #=< Max,
	H #>= Min,
	constraint_min_max(T, Max, Min).

% Applies contraint_min to each element contained in the white strip
constraint_list_min([L|Ls], Min) :-
	foldl(constraint_min, Ls, L, Min).

% Applies a constraint and finds the minumum value between two values.
constraint_min(X, Y, Min) :-
	Min #= min(X, Y).

% Applies contraint_min to each element contained in the white strip
constraint_list_max([L|Ls], Max) :-
	foldl(constraint_max, Ls, L, Max).

% Applies a constraint and finds the maximum value between two values.
constraint_max(X, Y, Max) :-
	Max #= max(X, Y).
	
% Base case, we reached the end of the matrix
fillBlacks([], [], FR, [], FR) :- !.

% Recursive case, we fill each row of the matrix
fillBlacks([H1|T1], [H2|T2], F, [SubFRows|FRows], Lower_N) :-
	fillSubBlacks(H1, H2, F, SubFRows, FR),
	fillBlacks(T1, T2, FR, FRows, Lower_N).

% Base case, we reached the end of the row
fillSubBlacks([], [], F, [], F) :- !.

% Recursive case, we found a value in the main matrix and a white cell in the color matrix
fillSubBlacks([H1|T1], [0|T2], F, [H1|SubFRows], FR) :- !,
	fillSubBlacks(T1, T2, F, SubFRows, FR).

% Recursive case, we found a 0 in the main matrix and a black cell in the color matrix
fillSubBlacks([0|T1], [1|T2], F1, [F2|SubFRows], FR) :- !,
	F2 is F1 - 1,
	fillSubBlacks(T1, T2, F2, SubFRows, FR).

% Recursive case, we found a value in the main matrix and a black cell in the color matrix
fillSubBlacks([H1|T1], [1|T2], F1, [H1|SubFRows], FR) :-
	fillSubBlacks(T1, T2, F1, SubFRows, FR).
	
% Base case, matrix is empty
showMatrix([]) :- write("\n"), !.
	
% Recursive case, matrix still has rows to print
showMatrix([H|T]) :-
	write(H),
	write("\n"),
	showMatrix(T).