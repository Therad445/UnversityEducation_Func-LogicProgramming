has_grandson(X) :-
    parent(X, Y),
    parent(Y, Z),
    male(Z).
