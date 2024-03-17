neq(X, Y) :-
    (X == Y -> !, fail ; true).
