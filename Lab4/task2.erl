-module(parent_children).
-export([start/1, send_to_child/2, stop/0]).

start(N) ->
    Parent = self(),
    Children = [spawn_link(fun() -> child(Parent) end) || _ <- lists:seq(1, N)],
    loop(Parent, Children).

send_to_child(I, Msg) ->
    Parent = self(),
    Parent ! {send, I, Msg}.

stop() ->
    Parent = self(),
    Parent ! stop.

loop(Parent, Children) ->
    receive
        {send, I, Msg} ->
            case lists:nth(I, Children) of
                Pid when is_pid(Pid) -> Pid ! Msg;
                _ -> io:format("Child ~p does not exist~n", [I])
            end,
            loop(Parent, Children);
        stop ->
            io:format("Parent stopping~n"),
            lists:foreach(fun(Pid) -> Pid ! stop end, Children),
            exit(normal);
        {'EXIT', Child, Reason} ->
            io:format("Child ~p died with reason ~p~n", [Child, Reason]),
            NewChild = spawn_link(fun() -> child(Parent) end),
            NewChildren = lists:map(fun(Pid) -> if Pid == Child -> NewChild; true -> Pid end end, Children),
            loop(Parent, NewChildren);
        Msg ->
            io:format("Parent received unexpected message: ~p~n", [Msg]),
            loop(Parent, Children)
    end.

child(Parent) ->
    loop(Parent).

loop(Parent) ->
    receive
        stop ->
            io:format("Child ~p stopping~n", [self()]),
            exit(normal);
        die ->
            io:format("Child ~p dying~n", [self()]),
            exit(die);
        Msg ->
            io:format("Child ~p received: ~p~n", [self(), Msg]),
            loop(Parent)
    end.
