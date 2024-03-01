-module(task3).
-export([iterate/2]).

iterate(_, 0) ->
    fun(X) -> X end;
iterate(F, N) when N > 0 ->
    InnerFunction = iterate(F, N-1),
    fun(X) -> F(InnerFunction(X)) end.



% F1 = task3:iterate(fun(X) -> [X] end, 2).
% F1(1).

% 23> F1 = task3:iterate(fun(X) -> [X] end, 2).
% #Fun<task3.1.64988440>
% 24> F1(1).
% [[1]]