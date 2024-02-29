-module(task3).
-export([iterate/2]).

iterate(F, 0) -> fun(X) -> X end;
iterate(F, N) -> fun(X) -> iterate(F, N-1)(F(X)) end.
