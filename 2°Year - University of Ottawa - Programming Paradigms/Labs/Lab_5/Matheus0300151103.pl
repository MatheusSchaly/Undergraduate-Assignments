% Factorial from class
fact(0, 1).
fact(N, F) :- N > 0,
	N1 is N-1,
	fact(N1, F1),
	F is F1 * N.

% Calculate -1 ^ K
signCnt(0,1).
signCnt(K,S) :- K > 0,
	K1 is K - 1,
	signCnt(K1,S1),
	S is S1 * (-1).

% Base case
cosN(X,X,_,0).  % When K == N

% Recursive case
cosN(K,N,Z,Y) :- K < N,
				signCnt(K,S),  % S = (-1)^k
				K2 is 2 * K,  % K2 = (2k)
				fact(K2,F),  % F = (2k)!
				Yk is (S * Z**K2)/F,  % All
				K1 is K+1,
				cosN(K1,N,Z,Y2),
				Y is Y2 + Yk.
cosN(N,Z,Y) :- N>0, cosN(0,N,Z,Y).