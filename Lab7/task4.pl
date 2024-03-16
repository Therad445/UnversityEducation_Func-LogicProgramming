eval_logic(true, _). % true всегда истинно.
eval_logic(false, _):- fail. % false всегда ложно.
eval_logic(\+ F, Values) :- eval_logic(F, Values), !, fail. % Негация ложной формулы -- истина.
eval_logic(\+ F, Values) :- !. % Негация истинной формулы -- ложь.
eval_logic(F1 /\ F2, Values) :- eval_logic(F1, Values), eval_logic(F2, Values). % Конъюнкция формул.
eval_logic(F1 \/ F2, Values) :- (eval_logic(F1, Values); eval_logic(F2, Values)). % Дизъюнкция формул.
eval_logic(X, Values) :- member(true(X), Values). % Проверяем, что атом X имеет значение true.
eval_logic(\+ X, Values) :- member(false(X), Values). % Проверяем, что атом X имеет значение false.
