% База предикатов для работы со списками

my_member(Element, [Element|_]).
my_member(Element, [_|Tail]) :-
    my_member(Element, Tail).

my_length([], 0).
my_length([_|Tail], Length) :-
    my_length(Tail, TailLength),
    Length is TailLength + 1.

my_append([], List, List).
my_append([Head|Tail1], List2, [Head|Result]) :-
    my_append(Tail1, List2, Result).

% Тесты для базы данных
:- begin_tests(lists).

test(член_списка_существует) :-
    my_member(1, [3, 2, 1, 4]),
    !.

test(член_списка_не_существует, fail) :-
    my_member(5, [3, 2, 1, 4]),
    !.

:- end_tests(lists).

% [lists].
% run_tests(lists).


% ?- [lists].
% true.

% ?- run_tests.
% % PL-Unit: lists .. passed 0.000 sec
% % All 2 tests passed
% true.

