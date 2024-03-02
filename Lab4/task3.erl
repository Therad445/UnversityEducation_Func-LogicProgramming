-module(task3).
-export([par_foreach/3]).

par_foreach(F, List, Options) ->
    SublistSize = proplists:get_value(sublist_size, Options, 1),
    NumProcesses = proplists:get_value(processes, Options, length(List)),
    Sublists = split_list(List, SublistSize),
    process_sublists(F, Sublists, NumProcesses).

split_list(List, SublistSize) ->
    split_list(List, SublistSize, []).

split_list([], _, Acc) ->
    lists:reverse(Acc);
split_list(List, SublistSize, Acc) when length(List) < SublistSize ->
    lists:reverse([List | Acc]);
split_list(List, SublistSize, Acc) ->
    {Head, Tail} = lists:split(SublistSize, List),
    split_list(Tail, SublistSize, [Head | Acc]).

process_sublists(_, [], _) ->
    ok;
process_sublists(F, [Sublist | Sublists], NumProcesses) ->
    Pids = spawn_processes(F, Sublist, NumProcesses),
    wait_for_processes(Pids),
    process_sublists(F, Sublists, NumProcesses).

spawn_processes(_, [], _) ->
    [];
spawn_processes(F, Sublist, NumProcesses) ->
    Pids = spawn_processes(F, Sublist, NumProcesses, []),
    wait_for_processes(Pids).

spawn_processes(_, [], _, Acc) ->
    Acc;
spawn_processes(F, Sublist, NumProcesses, Acc) ->
    Pid = spawn_link(fun() -> apply_functions(F, Sublist) end),
    spawn_processes(F, Sublist, NumProcesses - 1, [Pid | Acc]).

apply_functions(_, []) ->
    ok;
apply_functions(F, List) ->
    lists:foreach(F, List).


wait_for_processes([]) ->
    ok;
wait_for_processes([Pid | Pids]) ->
    receive
        {Pid, ok} ->
            wait_for_processes(Pids)
    end.
