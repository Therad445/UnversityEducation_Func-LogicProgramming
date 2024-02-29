-module(task4).
-export([split_all/2]).

split_all(List, N) when length(List) =< N ->
    [List];
split_all(List, N) ->
    [lists:sublist(List, 1, N) | split_all(lists:nthtail(N, List), N)].