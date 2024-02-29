-module(multiset).
-export([union/2]).

% Функция для объединения двух мультимножеств
union(Multiset1, Multiset2) ->
    Result = dict:merge(fun(_, Count1, Count2) -> Count1 + Count2 end, Multiset1, Multiset2),
    case Result of
        'ok' -> true;
        _ -> false
    end.
