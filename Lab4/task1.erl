-module(star).
-export([star/2, center/1, process/2]).

star(N, M) ->
    io:format("Current process is ~p~n", [self()]),
    Center = spawn(star, center, [[]]),
    lists:foreach(fun(_) -> spawn(star, process, [Center, M]) end, lists:seq(1, N)),
    center:loop(N, M).

center(Pids) ->
    io:format("Created ~p (center)~n", [self()]),
    loop(Pids).

process(Center, M) ->
    Self = self(),
    receive
        {send, Msg} ->
            io:format("~p received ~p from ~p~n", [Self, Msg, Center]),
            Center ! {reply, Msg + 1},
            process(Center, M - 1);
        stop ->
            io:format("~p finished~n", [Self])
    end,
    if M > 0 -> process(Center, M); true -> ok end.

loop([]) -> ok;
loop(Pids) ->
    Pids2 = lists:map(fun(Pid) -> Pid ! {send, 0} end, Pids),
    lists:foreach(fun(_) -> receive {reply, _} -> ok end end, Pids2),
    loop(Pids).

loop(0, _) ->
    lists:foreach(fun(Pid) -> Pid ! stop end, self()).
loop(N, M) ->
    loop(N - 1, M),
    Center = self(),
    Center ! {send, N}.
