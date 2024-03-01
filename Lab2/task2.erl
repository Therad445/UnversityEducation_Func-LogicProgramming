-module(task2).
-export([takewhile/2]).

takewhile(_, []) -> [];
takewhile(Pred, [Head | Tail]) ->
    case Pred(Head) of
        true -> [Head | takewhile(Pred, Tail)];
        false -> []
    end.

% task2:takewhile(fun(X) -> X < 10 end, [1,3,9,11,6]).
% [1,3,9]