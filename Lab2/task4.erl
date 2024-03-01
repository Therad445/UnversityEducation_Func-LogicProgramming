-module(task4).
-export([integrate/2]).

integrate(F, N) ->
    Step = 1.0 / N,
    fun(A, B) ->
        Delta = (B - A) / N,
        Sum = lists:foldl(
            fun(I, Acc) ->
                X = A + I * Delta,
                Acc + F(X) * Delta
            end,
            0.0,
            lists:seq(0, N - 1)
        ),
        Sum
    end.

% F1 = task4:integrate(fun(X) -> X end, 100), F1(0, 1).
% 0.4949999999999999