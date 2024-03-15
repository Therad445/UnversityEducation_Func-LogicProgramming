-module(task4).
-export([new/0, add/2, remove/2, count/2, elements/1, union/2]).

-record(multiset, {pairs = []}).

%% Функция создания нового пустого мультимножества
new() ->
    #multiset{pairs = []}.

%% Функция добавления элемента в мультимножество
add(Element, Multiset) ->
    UpdatedPairs = add_pair(Element, Multiset#multiset.pairs),
    Multiset#multiset{pairs = UpdatedPairs}.

add(Element, Multiset, Count) when Count > 0 ->
    UpdatedPairs = add_pair(Element, Multiset#multiset.pairs, Count),
    Multiset#multiset{pairs = UpdatedPairs}.

%% Вспомогательная функция добавления пары {Element, Count} в список пар
add_pair(Element, Pairs) ->
    case lists:keymember(Element, 1, Pairs) of
        true ->
            lists:map(fun({E, C}) ->
                              case E =:= Element of
                                  true -> {E, C + 1};
                                  false -> {E, C}
                              end
                      end, Pairs);
        false ->
            Pairs ++ [{Element, 1}]
    end.

add_pair(Element, Pairs, Count) when Count > 0 ->
    case lists:keymember(Element, 1, Pairs) of
        true ->
            lists:map(fun({E, C}) ->
                              case E =:= Element of
                                  true -> {E, C + Count};
                                  false -> {E, C}
                              end
                      end, Pairs);
        false ->
            Pairs ++ [{Element, Count}]
    end.


%% Функция удаления элемента из мультимножества
remove(Element, Multiset) ->
    UpdatedPairs = remove_pair(Element, Multiset#multiset.pairs),
    Multiset#multiset{pairs = UpdatedPairs}.

%% Вспомогательная функция удаления пары {Element, Count} из списка пар
remove_pair(Element, Pairs) ->
    lists:filter(fun({E, _}) -> E =/= Element end, Pairs).

%% Функция получения количества вхождений элемента в мультимножество
count(Element, Multiset) ->
    case lists:keyfind(Element, 1, Multiset#multiset.pairs) of
        false -> 0;
        {_, Count} -> Count
    end.

%% Функция получения всех элементов мультимножества
elements(Multiset) ->
    lists:flatmap(fun({E, C}) -> lists:duplicate(C, E) end, Multiset#multiset.pairs).

%% Функция объединения двух мультимножеств
union(Multiset1, Multiset2) ->
    %% Объединяем списки пар
    AllPairs = Multiset1#multiset.pairs ++ Multiset2#multiset.pairs,
    %% Сортируем список пар по элементам
    SortedPairs = lists:usort(AllPairs),
    %% Создаем новое мультимножество
    UnionMultiset = lists:foldl(fun({Element, Count}, AccMultiset) ->
                                      UpdatedMultiset = add(Element, AccMultiset, Count),
                                      UpdatedMultiset
                              end, new(), SortedPairs),
    UnionMultiset.



% 6> Multiset1_task4 = task4:add(a, task4:add(b, task4:add(a, task4:new()))).
% #multiset{pairs = [{a,2},{b,1}]}
% 7> Multiset2_task4 = task4:add(a, task4:add(c, task4:new())).
% #multiset{pairs = [{a,1},{c,1}]}
% 8> UnionMultiset_task4 = task4:union(Multiset1_task4, Multiset2_task4).
% #multiset{pairs = [{a,3},{b,1},{c,1}]}