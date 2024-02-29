-module(task6).
-export([intersect/2]).

intersect(List1, List2) ->
    lists:usort(lists:filter(fun(X) -> lists:member(X, List2) end, List1)).