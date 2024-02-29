-module(multiset).
-export([union/2]).

% Функция для объединения двух мультимножеств
union(Multiset1, Multiset2) ->
    union(Multiset1, Multiset2, dict:new()).

union(Multiset1, Multiset2, Result) ->
    case dict:to_list(Multiset1) of
        [] -> Result;
        [{Key, Count} | Tail] ->
            UpdatedResult = dict:update_counter(Key, Count, 1, Result),
            union(Tail, Multiset2, UpdatedResult)
    end.
    
union([], Multiset2, Result) ->
    Result;
union([{Key, Count} | Tail], Multiset2, Result) ->
    UpdatedResult = dict:update_counter(Key, Count, 1, Result),
    union(Tail, Multiset2, UpdatedResult).
