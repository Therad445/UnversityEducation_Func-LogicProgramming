ordered([]).  % Пустой список считается упорядоченным
ordered([_]). % Список с одним элементом считается упорядоченным
ordered([X,Y|T]) :- 
    number(X), % Проверяем, что X является числом
    number(Y), % Проверяем, что Y является числом
    X =< Y,    % Проверяем, что X меньше или равен Y
    ordered([Y|T]). % Рекурсивно проверяем остальные элементы


:- begin_tests(ordered).

test(ordered_empty) :-
    ordered([]),
    !.

test(ordered_single_element) :-
    ordered([1]),
    !.

test(ordered_sorted_list) :-
    ordered([1, 2, 3]),
    !.

test(ordered_unsorted_list) :-
    \+ ordered([3, 2]),
    !.

test(ordered_mixed_list) :-
    \+ ordered([1, a]),
    !.

:- end_tests(ordered).

run_tests :-
    run_tests(ordered).


% ?- [ordered].
% true.

% ?- run_tests.
% % PL-Unit: ordered ..... passed 0.001 sec
% % All 5 tests passed
% true.
