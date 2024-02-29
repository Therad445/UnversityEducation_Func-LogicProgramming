-module(sublist_util).
-export([sublist/3]).

sublist(List, N, M) when N > M -> [];
sublist(List, N, M) when N > 0, M > 0 -> sublist(List, N, M, 1, []).

sublist([], _, _, _, Acc) -> lists:reverse(Acc);
sublist([Head | Tail], N, M, CurrentIndex, Acc) when CurrentIndex >= N, CurrentIndex =< M ->
    sublist(Tail, N, M, CurrentIndex + 1, [Head | Acc]);
sublist([_ | Tail], N, M, CurrentIndex, Acc) ->
    sublist(Tail, N, M, CurrentIndex + 1, Acc).
