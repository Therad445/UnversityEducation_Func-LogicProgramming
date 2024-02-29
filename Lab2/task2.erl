-module(task2).
-export([takewhile/2]).

takewhile(_, []) -> [];
takewhile(Pred, [Head | Tail]) ->
    case Pred(Head) of
        true -> [Head | takewhile(Pred, Tail)];
        false -> []
    end.
