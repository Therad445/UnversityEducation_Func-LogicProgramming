remove_duplicates([], []).
remove_duplicates([X|Xs], Ys) :-
    member(X, Xs),
    !,
    remove_duplicates(Xs, Ys).
remove_duplicates([X|Xs], [X|Ys]) :-
    remove_duplicates(Xs, Ys).

:- begin_tests(remove_duplicates).

test(empty_list) :-
    remove_duplicates([], []),
    !.

test(no_duplicates) :-
    remove_duplicates([a, b, c], [a, b, c]),
    !.

test(duplicates_removed) :-
    remove_duplicates([a, b, a, b, c, c, a], X),
    permutation(X, [a, b, c]),
    !.

test(variables_in_different_places) :-
    remove_duplicates([a, b, c], X),
    X = [a, b, c],
    !.

test(duplicates_with_variables_in_different_places) :-
    remove_duplicates([a, b, a, b, c, c, a], X),
    permutation(X, [a, b, c]),
    !.

:- end_tests(remove_duplicates).


run_tests :-
    run_tests(remove_duplicates).



% ?- [dupl].
% true.

% ?- run_tests.
% % PL-Unit: remove_duplicates ..... passed 0.001 sec
% % All 5 tests passed
% true.
