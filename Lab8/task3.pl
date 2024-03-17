delete_all([], _, []).
delete_all([X|T], X, Result) :-
    !,
    delete_all(T, X, Result).
delete_all([H|T], X, [H|Result]) :-
    delete_all(T, X, Result).
