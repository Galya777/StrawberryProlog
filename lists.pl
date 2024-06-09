%append(A, B, R)
append([], B, B).
append([H|T], B, [H|R]) :- append(T,B,R). 

%mem1(X, A)
mem1(X, [X|_]).
mem1(X, [_|T]) :- mem1(X,T).

%mem2(X, A) using append
mem2(X,A) :- append(_, [X|_], A).

%remove1(X, A, R)
remove1(X, [X|T], T).
remove1(X, [H|T], [H|R]) :- remove1(X, T, R).

%remove2(X, A, R) using append
remove2(X, A, R) :- append(H, [X|T], A), append(H,T,R).

%add(X, A, R).
add(X,[],[X]).
add(X,[H|T], [H|R]) :- add(X, T, R). 

%add1(X, A, R) using append
add1(X,A,R) :- append(L1, L2, A), append(L1, [X|L2], R).

%add2(X, A, R) using remove
add2(X, A, R) :- remove1(X,R,A).

%reverse(A, R) using append
reverse([], []).
reverse([H|T], R) :- reverse(T,B), append(B, [H], R).

%reverse1(A, R) using add
reverse1([], []).
reverse1([H|T], R) :- reverse1(T,B), add(B, H, R).

%removeAll(X, A, R)
removeAll(_, [], []).
removeAll(X,[H|T],[H|R]) :- not(H=X), removeAll(X,T,R).
removeAll(X,[X|T],R) :- removeAll(X,T,R).