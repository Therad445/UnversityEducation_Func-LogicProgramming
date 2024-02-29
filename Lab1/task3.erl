-module(task3).
-export([distinct/1]).

% Проверка, что элемента нет в списке
not_member(_, []) -> true;
not_member(X, [H|T]) when X /= H -> not_member(X, T);
not_member(_, _) -> false.

% Проверка, что все элементы списка уникальны
all_distinct([]) -> true;
all_distinct([H|T]) -> not_member(H, T) andalso all_distinct(T).

% Функция distinct/1
distinct(List) -> all_distinct(List).
