-module(task5).
-export([for/4]).

% task5:for(4, fun(X) -> X =< 10 end, fun(X) -> X + 2 end, fun(X) -> io:format("~p~n", [X]) end).
% .
% 4
% 6
% 8
% 10
% done

for(Init, Cond, Step, Body) ->
    for_loop(Init, Cond, Step, Body).

for_loop(I, Cond, Step, Body) ->
    case Cond(I) of
        true -> 
            Body(I),
            for_loop(Step(I), Cond, Step, Body);
        false -> 
            done
    end.