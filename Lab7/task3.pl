
dnf([]).

dnf([X]) :-
    literal(X).

dnf([Head|Tail]) :-
    (literal(Head); disjunction(Head)),
    dnf(Tail).

literal(X) :-
    atom(X).
literal(\+ X) :-
    atom(X).

disjunction(Or) :-
    is_list(Or),
    all_literals(Or).

all_literals([]).
all_literals([Head|Tail]) :-
    literal(Head),
    all_literals(Tail).
