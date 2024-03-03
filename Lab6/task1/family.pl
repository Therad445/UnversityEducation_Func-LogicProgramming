% База фактов о родственных связях

предок_потомок(алексей, сергей).
предок_потомок(сергей, петр).
предок_потомок(сергей, мария).
предок_потомок(петр, анна).

предок_потомок(мария, елена).
предок_потомок(петр, василий).
предок_потомок(алексей, екатерина).

% Тесты для базы данных
:- begin_tests(family).

test(предок_потомок_существует) :-
    предок_потомок(алексей, сергей),
    предок_потомок(сергей, петр).

test(предок_потомок_не_существует, fail) :-
    предок_потомок(алексей, анна).

:- end_tests(family).

% [family].
% run_tests(family).


% ?- [family].
% true.

% ?- run_tests(family).
% % PL-Unit: family .. passed 0.000 sec
% % All 2 tests passed
% true.

