-module(task1).
-export([star/2]).

% task1:star(3,2).
% Попробуй запустить на компьютере

star(N, M) ->
    CenterPid = spawn_link(fun() -> center(N, M) end),
    io:format("Current process is ~p~n", [self()]),
    Pids = spawn_processes(N, CenterPid, M),
    broadcast(Pids, self(), 0, M).

spawn_processes(0, _, _) ->
    [];
spawn_processes(N, CenterPid, M) ->
    Pid = spawn_link(fun() -> process(N, CenterPid, M) end),
    io:format("Created ~p~n", [Pid]),
    [Pid | spawn_processes(N - 1, CenterPid, M)].

center(N, M) ->
    loop(N, M, lists:duplicate(N, 0), 0).

loop(_, 0, _, _) ->
    ok;
loop(N, M, Counters, Round) ->
    io:format("~p received ~p from <0.~p.0>~n", [self(), Round, self()]),
    NextRound = Round + 1,
    io:format("~p received ~p from <0.~p.0>~n", [self(), Round, self()]),
    broadcast(Counters, self(), NextRound, M),
    loop(N, M - 1, [0 | lists:delete_first(Round, Counters)], NextRound).

broadcast([], _, _, _) ->
    ok;
broadcast([Pid | Pids], Sender, Round, M) ->
    Pid ! {Sender, Round, M},
    broadcast(Pids, Sender, Round, M).

process(N, CenterPid, M) ->
    loop(N, CenterPid, M).

loop(_, CenterPid, 0) ->
    CenterPid ! finished;
loop(N, CenterPid, M) ->
    receive
        {Sender, Round, MLeft} ->
            io:format("~p received ~p from ~p~n", [self(), Round, Sender]),
            NextRound = Round + 1,
            Sender ! {NextRound, MLeft - 1},
            loop(N, CenterPid, MLeft - 1)
    end.
