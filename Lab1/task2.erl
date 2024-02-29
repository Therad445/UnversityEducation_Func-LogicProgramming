-module(task2).
-export([min/1]).

min([]) ->
    throw(empty_list);
min([H | T]) ->
    min(H, T).

min(H, []) ->
    H;
min(H, [H1 | T]) when H < H1 ->
    min(H, T);
min(_, [H1 | T]) ->
    min(H1, T).
