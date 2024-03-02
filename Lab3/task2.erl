-module(task2).
-export([new/0, add/2, remove/2, count/2, elements/1]).

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




% 1> c(multiset).
% {ok,multiset}
% 2> Multiset1 = task2:new().
% #multiset{dict = #{}}  % Создали новое пустое мультимножество
% 3> Multiset2 = task2:add(a, Multiset1).
% #multiset{dict = #{a => 1}}  % Добавили элемент 'a' в мультимножество
% 4> Multiset3 = task2:add(b, Multiset2).
% #multiset{dict = #{a => 1,b => 1}}  % Добавили элемент 'b' в мультимножество
% 5> Multiset4 = task2:add(a, Multiset3).
% #multiset{dict = #{a => 2,b => 1}}  % Добавили еще один раз элемент 'a'
% 6> task2:count(a, Multiset4).
% 2  % Количество вхождений элемента 'a' в мультимножество
% 7> task2:count(c, Multiset4).
% 0  % Элемент 'c' не присутствует в мультимножестве
% 8> Multiset5 = task2:remove(a, Multiset4).
% #multiset{dict = #{a => 1,b => 1}}  % Удалили одно вхождение элемента 'a'
% 9> task2:elements(Multiset5).
% [b,a]  % Получили все элементы мультимножества в виде списка
