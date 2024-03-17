% Базовый случай: если является атомом и значение в списке Values
eval_logic(X, Values) :-
    member(true(X), Values).

eval_logic(\+ Formula, Values) :-
    eval_logic(Formula, Values), !, fail. % Проверяем, что подформула ложна
eval_logic(\+ _, _).

eval_logic((Formula1 -> Formula2), Values) :-
    eval_logic(Formula1, Values),
    eval_logic(Formula2, Values).


% Конъюнкции
eval_logic((Formula1, Formula2), Values) :-
    eval_logic(Formula1, Values),
    eval_logic(Formula2, Values).

% Дизъюнкции
eval_logic((Formula1 ; _), Values) :-
    eval_logic(Formula1, Values).
eval_logic((_; Formula2), Values) :-
    eval_logic(Formula2, Values).

% Атомарных значений
eval_logic(true, _).
eval_logic(false, _) :- !, fail.
