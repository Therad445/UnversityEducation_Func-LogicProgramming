-module(task3_start).
-compile([export_all]).

-include("task3.erl").

start() ->
    List = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
    Options = [{sublist_size, 2}, {processes, 3}],
    task3:par_foreach(fun test_function/1, List, Options).

test_function(Item) ->
    io:format("Processing item: ~p~n", [Item]).
