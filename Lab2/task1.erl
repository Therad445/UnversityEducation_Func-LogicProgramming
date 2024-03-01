-module(task1).
-export([list_heads/1]).

list_heads(List) -> list_heads(List, []).

list_heads([], Heads) -> lists:reverse(Heads);
list_heads([Head | Tail], Heads) ->
    case Head of
        [H | _] -> list_heads(Tail, [H | Heads]);
        _ -> list_heads(Tail, Heads)
    end.

% task1:list_heads([[1,2,3], {true,3}, [4,5], []]).
% [1,4]