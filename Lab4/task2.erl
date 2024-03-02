-module(task2).
-export([start/1, send_to_child/2, stop/0]).

start(N) ->
    ParentPid = self(),
    spawn_link(fun() -> parent(N, ParentPid) end),
    spawn_children(N).

send_to_child(I, Msg) ->
    ParentPid = whereis(parent),
    ParentPid ! {send_to_child, I, Msg}.

stop() ->
    ParentPid = whereis(parent),
    ParentPid ! stop.

spawn_children(0) -> ok;
spawn_children(N) ->
    spawn_link(fun() -> child(N) end),
    spawn_children(N - 1).

parent(N, ParentPid) ->
    register(parent, self()),
    loop(N, ParentPid, []).

loop(N, ParentPid, Children) ->
    receive
        {send_to_child, I, Msg} when I > 0, I =< length(Children) ->
            lists:nth(I, Children) ! Msg,
            loop(N, ParentPid, Children);
        stop ->
            lists:foreach(
                fun(ChildPid) -> ChildPid ! stop end,
                Children
            ),
            ok;
        Msg ->
            io:format("Parent received message: ~p~n", [Msg]),
            loop(N, ParentPid, [spawn_link(fun() -> child(N) end) | Children])
    end.

child(N) ->
    loop(N).

loop(N) ->
    receive
        stop ->
            ok;
        die ->
            exit(die);
        Msg ->
            io:format("Child ~p received message: ~p~n", [self(), Msg]),
            loop(N)
    end.

% 1> c(task2).
% {ok,task2}
% 2> task2:start(3).
% true
% 3> task2:send_to_child(1, "Hello, child 1!").
% Parent received message: {send_to_child,1,"Hello, child 1!"}
% {send_to_child,1,"Hello, child 1!"}
% 4> task2:stop().
% stop
