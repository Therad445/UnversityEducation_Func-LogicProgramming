gray([0], [[0], [1]]).
gray(L, Code) :-
    length(L, Len),
    Len > 1,
    reverse(L, RevL),
    append_zero(L, LWithZero),
    append_one(RevL, LWithOne),
    append(LWithZero, LWithOne, Code).

append_zero([], []).
append_zero([H|T], [[0|H]|T1]) :-
    append_zero(T, T1).

append_one([], []).
append_one([H|T], [[1|H]|T1]) :-
    append_one(T, T1).



:- begin_tests(gray).

test(one_bit) :-
    gray([0], Code),
    reverse(Code, Expected),
    permutation(Code, Expected),
    !.

test(two_bits) :-
    gray([0, 0], Code),
    reverse(Code, Expected),
    permutation(Code, Expected),
    !.

test(three_bits) :-
    gray([0, 0, 0], Code),
    reverse(Code, Expected),
    permutation(Code, Expected),
    !.

test(mixed_bits) :-
    gray([1, 0, 1, 0], Code),
    reverse(Code, Expected),
    permutation(Code, Expected),
    !.

:- end_tests(gray).




% ?- [task5].
% true.

% ?- run_tests.
% % PL-Unit: gray .... passed 0.001 sec
% % All 4 tests passed
% true.

