:- discontiguous prime_factors/2.

% Является ли число простым
is_prime([]) :- !, fail.
is_prime([]) :- !, fail.
is_prime(2) :- !.
is_prime(N) :-
    N > 2,
    N mod 2 =\= 0,
    is_prime(N, 3).


% Поиск простых делителей
prime_factors(Num, Factors) :-
    prime_factors(Num, 2, Factors).

prime_factors(1, _, []) :- !.
prime_factors(Num, Factor, [factor(Factor, Count) | Factors]) :-
    Num mod Factor =:= 0,
    Count is 1,
    NewNum is Num // Factor,
    reduce_factors(NewNum, Factor, NewFactor),
    prime_factors(NewFactor, NewFactors),
    append(NewFactors, Factors, Factors).
prime_factors(Num, Factor, Factors) :-
    \+ (Num mod Factor =:= 0),
    NextFactor is Factor + 1,
    prime_factors(Num, NextFactor, Factors).

% Уменьшения числа путем деления на простой делитель
reduce_factors(1, _, 1) :- !.
reduce_factors(Num, Factor, Result) :-
    NewNum is Num // Factor,
    reduce_factors(NewNum, Factor, Result).


% Упрощения списка множителей
simplify_factors([], []).
simplify_factors([H | T], [H | T1]) :-
    simplify_factors(T, T1),
    \+ member(H, T1).
simplify_factors([H | T], T1) :-
    simplify_factors(T, T1),
    member(H, T1).

count([], _, 0).
count([H | T], H, N) :-
    count(T, H, N1),
    N is N1 + 1.
count([_ | T], X, N) :-
    count(T, X, N).

% Списка факторов
format_factors([], []).
format_factors([H | T], [factor(H, Count) | T1]) :-
    count([H | T], H, Count),
    format_factors(T, T1).

% Основной предикат
prime_factors(Num, Factors) :-
    findall(X, (prime_factors(Num, X), is_prime(X)), RawFactors),
    simplify_factors(RawFactors, UniqueFactors),
    format_factors(UniqueFactors, Factors).
