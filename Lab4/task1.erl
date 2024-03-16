-module(task1).
-export([star/2]).

star(N, M) ->
    Self = self(),
    io:format("Current process is ~p~n", [Self]),
    Center = spawn_link(fun() -> center(Self, N, M) end),
    io:format("Created ~p (center)~n", [Center]),
    create_processes(Center, N).

create_processes(_, 0) ->
    ok;
create_processes(Center, N) ->
    Pid = spawn_link(fun() -> process(Center, N) end),
    io:format("Created ~p~n", [Pid]),
    create_processes(Center, N - 1).

center(Parent, N, M) ->
    receive
        {message, From, 0} ->
            io:format("~p received 0 from ~p~n", [self(), From]),
            Parent ! {reply, self(), 1},
            center(Parent, N, M);
        {message, From, Num} when Num < M ->
            io:format("~p received ~p from ~p~n", [self(), Num, From]),
            Parent ! {reply, self(), Num + 1},
            center(Parent, N, M);
        {message, From, M} ->
            io:format("~p received ~p from ~p~n", [self(), M, From]),
            Parent ! {reply, self(), M},
            ok
    end.

process(Center, N) ->
    Center ! {message, self(), 0},
    receive
        {reply, From, Num} ->
            io:format("~p received ~p from ~p~n", [self(), Num, From]),
            process(Center, N)
    end.
