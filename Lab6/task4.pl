my_flatten([], []). % Базовый случай: пустой список не требует дополнительной обработки.

my_flatten([Head|Tail], Flattened) :-
    is_list(Head), % Если голова списка является списком,
    !, % то предпримем операции со вложенным списком.
    my_flatten(Head, FlattenedHead), % "Расплющиваем" вложенный список.
    my_flatten(Tail, FlattenedTail), % Продолжаем "расплющивать" оставшуюся часть списка.
    append(FlattenedHead, FlattenedTail, Flattened). % Объединяем "расплющенную" голову списка с "расплющенным" хвостом.
    
my_flatten([Head|Tail], [Head|FlattenedTail]) :-
    % Если голова списка не является списком, добавляем ее к "расплющенному" хвосту.
    % Затем рекурсивно "расплющиваем" оставшуюся часть списка.
    \+ is_list(Head),
    my_flatten(Tail, FlattenedTail).

:- begin_tests(my_flatten).

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
