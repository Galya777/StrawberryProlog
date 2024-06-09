% ???????? ?????

????(????, ???).
????(????, ????).

% dx(F, DF) - DF ? ???????????? ?? F ?? ???????????? x
%
% (???????? ?????????????)

dx(x, 1).
dx(y, 0).
dx(z, 0).
dx(t, 0).
dx(0, 0).
dx(1, 0).
dx(2, 0).
dx(-F, -DF) :- dx(F, DF).
dx(F+G, DF+DG) :- dx(F, DF), dx(G, DG).
dx(F-G, DF-DG) :- dx(F, DF), dx(G, DG).
dx(F*G, DF*G+F*DG) :- dx(F, DF), dx(G, DG).
dx(F/G, (DF*G-DG*F)/(G^2)) :- dx(F, DF), dx(G, DG).
dx(F^2, 2*F*DF) :- dx(F, DF).
dx(sin(F), cos(F)*DF) :- dx(F, DF).
dx(cos(F), -sin(F)*DF) :- dx(F, DF).

% ???????(F, G) - ??? ???????, ???????? ????? F ?? ????????? ?? G

???????(0+F, F).
???????(F+0, F).
???????(0*_, 0).
???????(_*0, 0).
???????(1*F, F).
???????(F*1, F).
???????(F+F, 2*F).

% ????????????_???????????(F, F1) - F1 ?? ???????? ?? F ???? ????????
%                                   ?????? ????? ??????? ??? ?????? F ???
%                                   ???? ?? ????

????????????_???????????(F, F1) :- ???????(F, F1).
????????????_???????????(F+G, F1+G) :- ????????????_???????????(F, F1).
????????????_???????????(G+F, G+F1) :- ????????????_???????????(F, F1).
????????????_???????????(F-G, F1-G) :- ????????????_???????????(F, F1).
????????????_???????????(G-F, G-F1) :- ????????????_???????????(F, F1).
????????????_???????????(F*G, F1*G) :- ????????????_???????????(F, F1).
????????????_???????????(G*F, G*F1) :- ????????????_???????????(F, F1).
????????????_???????????(F/G, F1/G) :- ????????????_???????????(F, F1).
????????????_???????????(G/F, G/F1) :- ????????????_???????????(F, F1).
????????????_???????????(-F, -F1) :- ????????????_???????????(F, F1).
????????????_???????????(sin(F), sin(F1)) :-
    ????????????_???????????(F, F1).
????????????_???????????(cos(F), cos(F1)) :-
    ????????????_???????????(F, F1).

% �??????? ????????� ?? ??????, ?????? ???????????? ????????????
%
% (??????? -> ???_?? ; ???_??)

% ???????????(F, G) - ??????? G ?? ???????? ?? F ???? ???????? ????????????
%                     ???????????? ?????? ????

???????????(F, G) :-
    (  ????????????_???????????(F, F1)
    -> ???????????(F1, G)
    ;  G = F ).

% ?????_????????(X, Y) - Y ? ?????? ?? ?????????? ?? ????? ??????? ?
%                        ??????? X
%
% ???????: ???????? ? ??????????? ?????? ?? ????????? ?? X ??? Y

?????_????????([], []).
?????_????????([_], []).
?????_????????([_,B|X], [B|Y]) :- ?????_????????(X, Y).

% ???????_????????(X, Y) - Y ? ?????? ?? ?????????? ?? ??????? ??????? ?
%                          ??????? X
%
% ???????: ???????? ? ??????????? ?????? ?? ????????? ?? X ??? Y

???????_????????(F, G) :- ?????_????????([0|F], G).


% ???????(A, X) - A ? ??????? ?? ??????? X
%
% ???????: ???????? ? ??????????? ?????? ?? ???? ?? ?????????? ?? X

% ??:
% ???????(A, []) :- fail.

% ???????(A, [B|X]) :- A = B ; ???????(A, X).

???????(A, [A|_]).
???????(A, [_|X]) :- ???????(A, X).

% ??? ??????? member ?????? ???????

% ??????(X, Y, Z) - ???????? Z ? ???????????? ?? X ? Y
%
% ???????: ???????? ? ??????????? ?????? ?? ????????? ?? X ??? ? ????????
%          ??????????? ?????? ?? ????????? ?? Z

??????([], X, X).
??????([A|X], Y, [A|Z]) :- ??????(X, Y, Z).

% ???????(X, Y) - X ? ??????? ?? Y
%
% ???????: ???????? ? ??????????? ?????? ?? ????????? ?? X ??? ?? Y

???????(X, Y) :- ??????(X, _, Y).

% ??????(X, Y) - X ? ?????? ?? Y
%
% ???????: ???????? ? ??????????? ?????? ?? ????????? ?? Y

??????(X, Y) :- ??????(_, X, Y).

???????2(A, X) :- ??????(_, [A|_], X).

% ??????????(X, Y) - X ? ?????????? ?? Y
%
% ???????: ???????? ? ??????????? ?????? ?? ????????? ?? X

??????????([], []).
??????????([A|X], Z) :- ??????????(X, Y), ????(A, Y, Z).

% ???? ???? ?? ?????? (?? ???????):
??????????2([], []).
??????????2([A|X], Z) :- ????(A, Y, Z), ??????????2(X, Y).

% ????(?, Y, Z) - Z ?? ???????? ?? Y ???? ??????? A ?? ?????????? ???????
%
% ???????: ???????? ? ??????????? ?????? ?? ????????? ?? Y

????(A, Y, Z) :- ??????(Y1, Y2, Y), ??????(Y1, [A|Y2], Z).

??????????3([], []).
??????????3(Z, [A|X]) :- ?????(Z, A, Y), ??????????3(Y, X).

% ?????(Z, A, X) - X ?? ???????? ???? ???????? ?? Z ?????????? ??????? A
%
% ???????: ???????? ? ??????????? ?????? ?? ????????? ?? Z

?????(Z, A, X) :- ??????(Y1, [A|Y2], Z), ??????(Y1, Y2, X).

:- use_module(library(clpfd)).

% ???????(X, N) - N ? ????????? ?? ??????? X
%
% ???????: ???????? ? ??????????? ?????? ?? ????????? ?? X ?? ?????????? ??
%          N

???????([], N) :- N #= 0.
???????([_|X], N) :- N #> 0, N #= M + 1, ???????(X, M).

% ????(X, N) - N ?????? ?? ?????????? ?? ??????? X
%
% ???????: ???????? ? ??????????? ?????? ?? ????????? ?? X

????([], N) :- N #= 0.
????([A|X], N) :- N #= K + A, ????(X, K).

% nth(X, N, A) - ? e N-???? ??????? ?? X
%
% ???????: ???????? ? ??????????? ?????? ?? ????????? ?? X ??? ??
%          ?????????? ?? N

nth([A|_], N, A) :- N #= 1.
nth([_|X], N, A) :- N #> 1, N1 #= N - 1, nth(X, N1, A).

% label([A,B,C,D]) - �??????????? ?? ?????????�, ?? ? ????? ?? ???? ????
% ?????????? ????????? ? ??????????? ??????? A, B, C ? D

% ??????(A,B,N,K) - ? N ? K ???????? ???????????? ?? ??????? ? ?????? ?
%                   ??????? A ? B.

% ??????(A,B,N,K) - (N,K) ?? ??????????? ?????????? ?? ????? ? ???????? ?
%                   ??????? A ? B
%
% ???????: A ? B ?? ????????

??????(A,B,N,K) :- B^2*N^2+A^2*K^2 #< A^2*B^2, label([N,K]).

% ?????????(N, F) - F = N!

?????????(0,1).
?????????(N, F) :- N #> 0, F #= N*F1, N1 #= N - 1, ?????????(N1, F1).

nat(N) :- N #= 0 ; nat(N-1).

% ??????(A,B) - ???????? ???????? (A,B) ?? ?????????? ?????

% ?? ????!!!
% ??????(A,B) :- nat(A), nat(B).

??????(A,B) :- nat(N), N #= A+B, A #>= 0, B #>= 0, label([A,B]).

% ??????_??????????(X) - ???????? ? X ?????? ??????? ?? ?????????? ?????

??????_??????????(X) :- nat(N),
			??????? + ???? #= N,
			??????? #>= 0, ???? #>= 0,
			???????(X, ???????),
			????(X, ????),
			??????????(X),
			label(X).

% ??????????(X) - ?????????? ?? X ?? ?????????? ?????
%
% ???????: ???????? ? ??????????? ?????? ?? ????????? ?? X

??????????([]).
??????????([A|X]) :- A #>= 0, ??????????(X).

% ??????_???????_??????????(XX) - ???????? ?????? ?? ?????? ??????? ??
%                                 ??????? ?? ?????????? ?????

??????_???????_??????????(XX) :- nat(N),
				 N #= N1+ N2, N1 #>= 0, N2 #>= 0,
				 ???????(XX, N1),
				 ????_??_????_??_??(N2, XX).

% ????_??_????_??_??(N, XX) - ?????????? ?? XX ?? ??????? ? ??????? ??
%                             ??-?????? ?? N ? ?????????? ?? ?????????? ??
%                             XX ?? ???? ????? ????? 0 ? N
%
% ???????: ???????? ? ??????????? ?????? ?? ????????? ?? XX

????_??_????_??_??(_, []).
????_??_????_??_??(N, [X|YY]) :-
    M #=< N,
    ???????(X, M),
    ????_??_??(N, X), label(X),
    ????_??_????_??_??(N, YY).

% ????_??_??(N, X) - ?????????? ?? X ?? ???? ????? 0 ? N
%
% ???????: ???????? ? ??????????? ?????? ?? ????????? ?? X

????_??_??(_, []).
????_??_??(N, [A|X]) :- A #>= 0, A #=< N, ????_??_??(N, X).

% A in 5..10 ? ?????? ???? A #>= 5, A #=< 10

% X ins 5..10 - X ? ??????, ????? ???????? ?? ????? 5 ? 10
%
% ???????: ?????? ?? ???? ???????? ????????? ?? X

% ?? ?? ???????? ???????? ???????_8_??_10(X), ????? ??? ??????????????????
% ???????? ? X ?????? ??????? ? ??????? ????? 8 ? 10 ? ???????? ????? 8 ?
% 10.

% ???????_8_??_10(X) - X ? ?????? ? ??????? ????? 8 ? 10 ? ???????? ????? 8
%                      ? 10
%
% ???????: ????

???????_8_??_10(X) :- ? in 8..10, ???????(X, ?), X ins 8..10, label(X).

% ?????????

% \+ p(X) ??? not(p(X))
%
% ?????? ?? ??????????? p(X), ??? ????? � ???????, ????? ??????.

% ????_?????(X) - X ?? ??????? ????? ????????
%
% ???????: X ? ???????? ??????

????_?????(X) :- not((A #= 2*_, ???????(A,X), label([A]))).

% ?????? ??? ????????? 

% ????_?????2(X) - X ??????? ???? ??????? ????????
%
% ???????: ???????? ? ??????????? ?????? ?? ????????? ?? X

????_?????2([]).
????_?????2([A|X]) :- A #= 2*_K+1, ????_?????2(X).

% ??????????
%
% forall(p(X), q(X)) - ?? ?????? X, ?? ????? ? ????? p(X), ? ????? ? q(X)

% forall(P,Q) :- not(( P, not(Q) ))

????_?????3(X) :- forall(???????(A,X), (A #= 2*_K + 1, label([A]))).

% findall(A, p(A), X) - X ? ?????? ?? ?????? A, ?? ????? ? ????? p(A)
%                       ?????????? ?? X = {A : p(A)}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ??????(N) - N ? ?????? ?????
%
% ???????: N ? ???????? ?????

??????(N) :- N #> 1, forall( (A #> 0, A*_ #= N, label([A])),
			     (A #= 1 ; A #= N) ).

% pppp(X) - ?????????? ???? ????? ??????? ?? ????? ??????? ? X ? ??????
%           ?????, ????? ?? ????? ?? ??????? ??????? ? X
%
% ???????: X ? ???????? ?????? ?? ?????

pppp(X) :-
    forall( nth(X, 2*_, A),
	    ( ??????(A), not(nth(X, 2*_+1, A)) )).

% ?????_????(X, N) - N ? ???? ?? ??????? ???? ???????? ?? X
%
% ???????: ???????? ? ????????? ?? X ? ????, ?? ?????????? ?? X ??
%          ???????????

?????_????(X, N) :- N #> M, ???????(M, X), ???_????(X, N-M).
???_????(_, N) :- N #= 0.
???_????(X, N) :-  N #> M, ???????(M, X), ?????_????(X, N-M).

% ppppp(X) - ????? ????? ?? ????? ??????? ? X ? ???? ?? ??????? ???? ??????
%            ???????? ?? X
%
% ???????: ???????? ? X

ppppp(X) :-
    findall(A, (???????(A,X),??????(A)), ??????),
    forall( nth(X, 2*_, A),
	    ?????_????(??????, A) ).
