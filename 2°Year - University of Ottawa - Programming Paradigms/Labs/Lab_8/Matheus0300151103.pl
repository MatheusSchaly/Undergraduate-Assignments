sumNodes(T,L) :- sumNodes( T, SS , L, AA).

sumNodes(nil,L,L,_) :-!.

sumNodes(t(Root,Left,Right), SS , LL , [Root]) :-
    SS is Root + 0,
    sumNodes(Left, SS, LL , AA),
    sumNodes(Right, SS , LL , AA),
    append( LL , SS , LLA).