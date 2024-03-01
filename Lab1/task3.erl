-module(task3).
-export([distinct/1]).

not_member(_, []) -> true;
not_member(X, [H|T]) when X /= H -> not_member(X, T);
not_member(_, _) -> false.

all_distinct([]) -> true;
all_distinct([H|T]) -> not_member(H, T) andalso all_distinct(T).

distinct(List) -> all_distinct(List).
