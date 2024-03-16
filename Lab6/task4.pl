my_flatten([], []). % Базовый случай
my_flatten([Head|Tail], Flattened) :-
    is_list(Head),
    !,
    my_flatten(Head, FlattenedHead), 
    my_flatten(Tail, FlattenedTail), 
    append(FlattenedHead, FlattenedTail, Flattened).
    
my_flatten([Head|Tail], [Head|FlattenedTail]) :-
    % Рекурсивно разбиваем оставшуюся часть
    \+ is_list(Head),
    my_flatten(Tail, FlattenedTail).

:- begin_tests(my_flatten).
% Тесты
test(empty_list) :-
    my_flatten([], []),
    !.

test(single_flat_list) :-
    my_flatten([a, b, c], [a, b, c]),
    !.

test(nested_list) :-
    my_flatten([a, [[b], c], [[d]]], [a, b, c, d]),
    !.

test(mixed_list) :-
    my_flatten([a, [b, [c, [d]], e]], [a, b, c, d, e]),
    !.

:- end_tests(my_flatten).



% ?- [task4].
% true.

% ?- run_tests.
% % PL-Unit: my_flatten .... passed 0.001 sec
% % All 4 tests passed
% true.
