-module(task3).
-export([distinct/1]).

distinct([]) ->
    true;
distinct([Head | Tail]) ->
    lists:all(fun(X) -> X /= Head end, Tail),
    distinct(Tail).