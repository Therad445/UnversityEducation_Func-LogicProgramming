% Первая реализация будет использовать модуль maps.
-module(task3).
-export([new/0, add/2, remove/2, count/2, elements/1, union/2]).

-record(multiset, {map = #{}}).

%% Функция создания нового пустого мультимножества
new() ->
    #multiset{map = #{}}.

%% Функция добавления элемента в мультимножество
add(Element, Multiset) ->
    UpdatedMap = maps:update_with(Element, fun(Count) -> Count + 1 end, 1, Multiset#multiset.map),
    Multiset#multiset{map = UpdatedMap}.

%% Функция удаления элемента из мультимножества
remove(Element, Multiset) ->
    case maps:is_key(Element, Multiset#multiset.map) of
        true ->
            Count = maps:get(Element, Multiset#multiset.map),
            case Count of
                1 ->
                    UpdatedMap = maps:remove(Element, Multiset#multiset.map),
                    Multiset#multiset{map = UpdatedMap};
                _ ->
                    UpdatedMap = maps:update_with(Element, fun(Count) -> Count - 1 end, Multiset#multiset.map),
                    Multiset#multiset{map = UpdatedMap}
            end;
        false ->
            Multiset
    end.

%% Функция получения количества вхождений элемента в мультимножество
count(Element, Multiset) ->
    maps:get(Element, Multiset#multiset.map, 0).

%% Функция получения всех элементов мультимножества
elements(Multiset) ->
    maps:fold(fun(Element, Count, Acc) ->
                   lists:duplicate(Count, Element) ++ Acc
               end, [], Multiset#multiset.map).

%% Функция объединения двух мультимножеств
union(Multiset1, Multiset2) ->
    %% Получаем все элементы и их кратности из обоих мультимножеств
    Elements1 = maps:to_list(Multiset1#multiset.map),
    Elements2 = maps:to_list(Multiset2#multiset.map),
    %% Объединяем списки элементов
    AllElements = Elements1 ++ Elements2,
    %% Создаем новое мультимножество, в котором кратности элементов складываются
    UnionMultiset = lists:foldl(fun({Element, Count}, AccMultiset) ->
                                      UpdatedMultiset = add(Element, AccMultiset),
                                      lists:foldl(fun(_Index, Acc) ->
                                                        UpdatedMultiset1 = add(Element, UpdatedMultiset),
                                                        Acc + 1
                                                end, 0, lists:seq(1, Count)),
                                      UpdatedMultiset
                              end, new(), AllElements),
    UnionMultiset.


% 1> c(task3).
% {ok,task3}
% 2> Multiset1 = task3:add(a, task3:add(b, task3:add(a, task3:new()))).
% #multiset{map = #{a => 2,b => 1}}
% 3> Multiset2 = task3:add(a, task3:add(c, task3:new())).
% #multiset{map = #{a => 1,c => 1}}
% 4> UnionMultiset = task3:union(Multiset1, Multiset2).
% #multiset{map = #{a => 3,b => 1,c => 1}}

