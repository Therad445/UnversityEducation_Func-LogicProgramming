-module(parallel).
-export([par_foreach/3]).

par_foreach(F, List, Options) ->
    {SublistSize, Processes, Timeout} = proplists:get_value(options, Options, {1, length(List), infinity}),
    Sublists = split_list(List, SublistSize),
    Pids = start_processes(F, Sublists, Processes),
    wait_for_completion(Pids, Timeout).

split_list(List, SublistSize) ->
    lists:reverse(split_list_acc(List, SublistSize, [])).

split_list_acc([], _, Acc) -> Acc;
split_list_acc(List, SublistSize, Acc) ->
    {Head, Tail} = lists:split(SublistSize, List),
    split_list_acc(Tail, SublistSize, [Head | Acc]).

start_processes(F, Sublists, NumProcesses) ->
    lists:map(fun(Sublist) ->
        spawn_link(fun() -> process_sublist(F, Sublist) end)
    end, lists:take(NumProcesses, Sublists)).

process_sublist(F, Sublist) ->
    lists:foreach(F, Sublist),
    ok.

wait_for_completion(Pids, Timeout) ->
    case erlang:monitor(process, Pids) of
        {_, _} ->
            receive
                {'DOWN', _Ref, process, Pid, _Reason} when Pid in Pids ->
                    case lists:keymember(Pid, 1, Pids) of
                        true ->
                            NewPid = spawn_link(fun() -> process_sublist(F, lists:nth(1, lists:dropwhile(fun(X) -> X /= Pid end, Pids))) end),
                            wait_for_completion(Pids ++ [NewPid], Timeout);
                        false ->
                            wait_for_completion(lists:delete(Pid, Pids), Timeout)
                    end
            after Timeout ->
                exit({timeout, Timeout})
            end;
        _ ->
            ok
    end.
