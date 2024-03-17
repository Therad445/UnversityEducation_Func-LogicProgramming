split([], [], []).
split([H|T], [H|Pos], NonPos) :-
    H > 0, !,
    split(T, Pos, NonPos).
split([H|T], Pos, [H|NonPos]) :-
    split(T, Pos, NonPos).
