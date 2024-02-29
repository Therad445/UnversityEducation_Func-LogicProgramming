-module(task5). 
-export([sublist/3]).

sublist(_, N, M) when N > M -> [];
sublist([], _, _) -> [];

sublist([H|T], N, M) when N =< M, N > 1 -> sublist(T, N-1, M-1);
sublist([H|T], 1, M) when M > 0 -> [H | sublist(T, 1, M-1)];
sublist(_, _, 0) -> [].
