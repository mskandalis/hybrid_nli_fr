:- module(pp, [pp/1, ppnl/1]).

pp(X) :-
    pp_term(X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MAIN DISPATCH
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pp_term(T) :-
    var(T), !,
    write_term(T, [quoted(true)]).

pp_term('Goal') :- !,
    write('Goal').

pp_term('\"') :- !,
    write('\\\"').

pp_term(T) :-
    atomic(T), !,
    write_term(T, [quoted(true)]).
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% LISTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pp_term([]) :- !, write([]).

pp_term([H|T]) :- !,
    write('['),
    pp_list(H,T),
    write(']').

pp_list(H,[]) :-
    pp_term(H).
pp_list(H,[X|Xs]) :-
    pp_term(H),
    write(','),
    pp_list(X,Xs).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FORMULAS -- align with pp.pl portray/1 output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pp_term(p(I,A,B)) :- !,
    format('( ~p *~p ~p )', [A,I,B]).

pp_term(dl(I,A,B)) :- !,
    format('( ~p \\~p ~p )', [A,I,B]).

pp_term(dr(I,A,B)) :- !,
    format('( ~p /~p ~p )', [A,I,B]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% QUANT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pp_term(quant(Q,X,F)) :- !,
    write_term(Q, [quoted(true)]), write(' '),
    pp_term(X),
    write('['),
    pp_term(F),
    write(']').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% BOOL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pp_term(bool(A,Op,B)) :- 
    member(Op, [>, <, 'overlaps', 'subseteq', 'intersect', 'empty_intersect', 'atomic_sub', 'neq', 'starts', 'leq', 'approx', 'simeq', 'neg', 'abuts']),
    !,
    write_term(Op, [quoted(true)]), write('('),
    pp_term(A),
    write(', '),
    pp_term(B),
    write(')').

pp_term(bool(A, is_at(E), B)) :-
    !,
    write('is_at('),
    pp_term(E),
    write(','),
    pp_term(A),
    write(','),
    pp_term(B),
    write(')').

pp_term(bool(A,Op,B)) :- 
    member(Op, [\/]),
    !,
    write('('),
    pp_term(A),
    write(' | '),
    pp_term(B),
    write(')').

pp_term(bool(A,Op,B)) :- !,
    write('('),
    pp_term(A),
    write(' '), write_term(Op, [quoted(true)]), write(' '),
    pp_term(B),
    write(')').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% APPLICATIONS (match pp.pl ordering for nested appl)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pp_term(appl(appl(appl(appl(appl(F,V),W),Z),Y),X)) :-
    atom(F), !,
    pp_term(F), write('('),
    pp_term(X), write(','), pp_term(Y), write(','), pp_term(Z), write(','), pp_term(W), write(','), pp_term(V),
    write(')').

pp_term(appl(appl(appl(appl(F,W),Z),Y),X)) :-
    atom(F), !,
    pp_term(F), write('('),
    pp_term(X), write(','), pp_term(Y), write(','), pp_term(Z), write(','), pp_term(W),
    write(')').

pp_term(appl(appl(appl(F,Z),Y),X)) :-
    atom(F), !,
    pp_term(F), write('('),
    pp_term(X), write(','), pp_term(Y), write(','), pp_term(Z),
    write(')').

pp_term(appl(appl(F,Y),X)) :-
    atom(F), !,
    pp_term(F), write('('),
    pp_term(X), write(','), pp_term(Y),
    write(')').

pp_term(appl(X,Y)) :- !,
    pp_term(X), write('('), pp_term(Y), write(')').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% LAMBDA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pp_term(lambda(X,B)) :- !,
    write('^'),
    pp_term(X),
    write('.'),
    pp_term(B).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PAIRS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pp_term(pair(A,B)) :- !,
    write('<'),
    pp_term(A),
    write(','),
    pp_term(B),
    write('>').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PROJECTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pp_term(pi1(X)) :- !,
    write('pi1('),
    pp_term(X),
    write(')').

pp_term(pi2(X)) :- !,
    write('pi2('),
    pp_term(X),
    write(')').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MODAL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pp_term(dia(X,F)) :- !,
    write('<>'), write_term(X, [quoted(true)]), write(' '),
    pp_term(F).

pp_term(box(X,F)) :- !,
    write('[]'), write_term(X, [quoted(true)]), write(' '),
    pp_term(F).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% LITERALS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pp_term(lit(s(A))) :- var(A), !, write(s).
pp_term(lit(n(A))) :- var(A), !, write(n).
pp_term(lit(A)) :- A = n(p), !, write(np).
pp_term(lit(n(_))) :- !, write(n).
pp_term(lit(X)) :- !, write(X).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% QUALIA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pp_term(qualia(A,B,C,D)) :- !,
    write('{const:'),
    pp_term(A),write(',form:'),
    pp_term(B),write(',telic:'),
    pp_term(C),write(',agentive:'),
    pp_term(D),
    write('}').

pp_term(N-x(P,F,I,_,L,_)) :- !,
    format('(~w) ', [N]),
    pp_term(P),
    pp_term(F), write('('), pp_term(I), write(')'), write('  '),
    pp_term(L).

pp_term(Form-at(Node,_,_,_,_,_)) :- !,
    pp_term(Form), write('('), pp_term(Node), write(')').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TREES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pp_term(empty) :- !, pp_portray_btreef(empty).
pp_term(tree(A,B,C,D,E)) :- !, pp_portray_btreef(tree(A,B,C,D,E)).
pp_term(black(A,B,C,D)) :- !, pp_portray_btreef(black(A,B,C,D)).
pp_term(red(A,B,C,D)) :- !, pp_portray_btreef(red(A,B,C,D)).
pp_term(two(A,B,C,D)) :- !, pp_portray_btreef(two(A,B,C,D)).
pp_term(three(A,B,C,D,E,F,G)) :- !, pp_portray_btreef(three(A,B,C,D,E,F,G)).
pp_term(four(A,B,C,D,E,F,G,H,I,J)) :- !, pp_portray_btreef(four(A,B,C,D,E,F,G,H,I,J)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ARRAYS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pp_term(array(A,B)) :- !,
    pp_portray_array(array(A,B)).

pp_term(contract(Ps,Qs,_,C0,_,_,_,_,_)) :- !,
    keysort(C0, C),
    write('contract('),
    pp_portray_list(Ps),
    pp_portray_list(Qs),
    pp_portray_list(C),
    write(')'), nl.

pp_term(replace(A,B,C,D,_,_,_,_,_,_)) :- !,
    format('~w := ~w~n', [B, C]),
    pp_portray_list(A),
    pp_portray_list(D),
    nl.

pp_term(expand_component(A0,A1,_,_,_,_,_,_,_)) :- !,
    ( var(A1) -> keysort(A0,A) ; keysort(A1,A) ),
    write('expand_component('),
    pp_portray_list(A),
    write(')'), nl.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FALLBACK
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pp_term(T) :-
    T =.. [F|Args],
        write_term(F, [quoted(true)]),
    ( Args = [] -> true
    ; write('('),
      pp_args(Args),
      write(')')
    ).

pp_args([A]) :- pp_term(A).
pp_args([A|R]) :-
    pp_term(A),
    write(','),
    pp_args(R).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Array and balanced-tree printing helpers (from pp.pl)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pp_portray_array(array($(A0,A1,A2,A3),Size)) :-
    N is Size-2,
    write('< '),
    pp_portray_subarray(A0, 0, N, 0),
    pp_portray_subarray(A1, 1, N, 0),
    pp_portray_subarray(A2, 2, N, 0),
    pp_portray_subarray(A3, 3, N, 0),
    write('>').
pp_portray_array(array($(A0,A1,A2,A3,A4,A5,A6,A7),Size)) :-
    N is Size-3,
    write('< '),
    pp_portray_subarray(A0, 0, N, 0),
    pp_portray_subarray(A1, 1, N, 0),
    pp_portray_subarray(A2, 2, N, 0),
    pp_portray_subarray(A3, 3, N, 0),
    pp_portray_subarray(A4, 4, N, 0),
    pp_portray_subarray(A5, 5, N, 0),
    pp_portray_subarray(A6, 6, N, 0),
    pp_portray_subarray(A7, 7, N, 0),
    write('>').
pp_portray_array(array($(A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15),Size)) :-
    N is Size-4,
    write('< '),
    pp_portray_subarray( A0,  0, N, 0),
    pp_portray_subarray( A1,  1, N, 0),
    pp_portray_subarray( A2,  2, N, 0),
    pp_portray_subarray( A3,  3, N, 0),
    pp_portray_subarray( A4,  4, N, 0),
    pp_portray_subarray( A5,  5, N, 0),
    pp_portray_subarray( A6,  6, N, 0),
    pp_portray_subarray( A7,  7, N, 0),
    pp_portray_subarray( A8,  8, N, 0),
    pp_portray_subarray( A9,  9, N, 0),
    pp_portray_subarray(A10, 10, N, 0),
    pp_portray_subarray(A11, 11, N, 0),
    pp_portray_subarray(A12, 12, N, 0),
    pp_portray_subarray(A13, 13, N, 0),
    pp_portray_subarray(A14, 14, N, 0),
    pp_portray_subarray(A15, 15, N, 0),
    write('>').

pp_portray_subarray($, _, _, _) :- !.
pp_portray_subarray($(A0,A1,A2,A3), K, N, M) :-
    N > 0,
    !,
    N1 is N-2,
    M1 is (K+M) << 2,
    pp_portray_subarray(A0, 0, N1, M1),
    pp_portray_subarray(A1, 1, N1, M1),
    pp_portray_subarray(A2, 2, N1, M1),
    pp_portray_subarray(A3, 3, N1, M1).
pp_portray_subarray($(A0,A1,A2,A3,A4,A5,A6,A7), K, N, M) :-
    N > 0,
    !,
    N1 is N-3,
    M1 is (K+M) << 3,
    pp_portray_subarray(A0, 0, N1, M1),
    pp_portray_subarray(A1, 1, N1, M1),
    pp_portray_subarray(A2, 2, N1, M1),
    pp_portray_subarray(A3, 3, N1, M1),
    pp_portray_subarray(A4, 4, N1, M1),
    pp_portray_subarray(A5, 5, N1, M1),
    pp_portray_subarray(A6, 6, N1, M1),
    pp_portray_subarray(A7, 7, N1, M1).
pp_portray_subarray($(A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15), K, N, M) :-
    N > 0,
    !,
    N1 is N-4,
    M1 is (K+M) << 4,
    pp_portray_subarray( A0,  0, N1, M1),
    pp_portray_subarray( A1,  1, N1, M1),
    pp_portray_subarray( A2,  2, N1, M1),
    pp_portray_subarray( A3,  3, N1, M1),
    pp_portray_subarray( A4,  4, N1, M1),
    pp_portray_subarray( A5,  5, N1, M1),
    pp_portray_subarray( A6,  6, N1, M1),
    pp_portray_subarray( A7,  7, N1, M1),
    pp_portray_subarray( A8,  8, N1, M1),
    pp_portray_subarray( A9,  9, N1, M1),
    pp_portray_subarray(A10, 10, N1, M1),
    pp_portray_subarray(A11, 11, N1, M1),
    pp_portray_subarray(A12, 12, N1, M1),
    pp_portray_subarray(A13, 13, N1, M1),
    pp_portray_subarray(A14, 14, N1, M1),
    pp_portray_subarray(A15, 15, N1, M1).
pp_portray_subarray(Item, K, 0, M) :-
    N is K+M,
    format('~p-~p ', [N, Item]).

pp_portray_btreef(Tree) :- pp_portray_btreef(Tree, user_output).
pp_portray_btreef(A, Stream) :-
    format(Stream, '{', []),
    pp_portray_btree1f(A, Stream),
    format(Stream, ' }', []).

pp_portray_btree1f('*VAR*', Stream) :- !, print(Stream, '*VAR*').
pp_portray_btree1f(empty, _).
pp_portray_btree1f(tree(K,V,_,L,R), Stream) :-
    pp_portray_btree1f(L, Stream),
    format(Stream, ' ~p', [K-V]),
    pp_portray_btree1f(R, Stream).
pp_portray_btree1f(red(K,V,L,R), Stream) :-
    pp_portray_btree1f(L, Stream),
    format(Stream, ' ~p', [K-V]),
    pp_portray_btree1f(R, Stream).
pp_portray_btree1f(black(K,V,L,R), Stream) :-
    pp_portray_btree1f(L, Stream),
    format(Stream, ' ~p', [K-V]),
    pp_portray_btree1f(R, Stream).
pp_portray_btree1f(two(K,V,L,R), Stream) :-
    pp_portray_btree1f(L, Stream),
    format(Stream, ' ~p', [K-V]),
    pp_portray_btree1f(R, Stream).
pp_portray_btree1f(three(A,B,C,D,E,F,G), Stream) :-
    pp_portray_btree1f(E, Stream),
    format(Stream, ' ~p', [A-B]),
    pp_portray_btree1f(F, Stream),
    format(Stream, ' ~p', [C-D]),
    pp_portray_btree1f(G, Stream).
pp_portray_btree1f(four(A,B,C,D,E,F,G,H,I,J), Stream) :-
    pp_portray_btree1f(G, Stream),
    format(Stream, ' ~p', [A-B]),
    pp_portray_btree1f(H, Stream),
    format(Stream, ' ~p', [C-D]),
    pp_portray_btree1f(I, Stream),
    format(Stream, ' ~p', [E-F]),
    pp_portray_btree1f(J, Stream).

% = pp_portray_list(+List)
% prints the elements of List one item per line (same as pp.pl's portray_list)
pp_portray_list(List) :- pp_portray_list(List, user_output).
pp_portray_list([], Stream) :- format(Stream, '[]~n', []).
pp_portray_list([X|Xs], Stream) :- format(Stream, '[~n', []), pp_portray_list(Xs, X, Stream).
pp_portray_list([], X, Stream) :- format(Stream, ' ~p~n]~n', [X]).
pp_portray_list([X|Xs], Y, Stream) :- format(Stream, ' ~p,~n', [Y]), pp_portray_list(Xs, X, Stream).