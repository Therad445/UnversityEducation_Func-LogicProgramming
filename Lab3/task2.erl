-module(multiset).
-export([new/0, add/2, remove/2, count/2, elements/1, union/2, intersection/2, difference/2]).

% Создание пустого мультимножества
new() -> dict:new().

% Добавление элемента в мультимножество с указанием его количества
add(Element, Count, Multiset) -> dict:update_counter(Element, Count, 1, Multiset).

% Удаление элемента из мультимножества
remove(Element, Count, Multiset) -> dict:update_counter(Element, -Count, 1, Multiset).

% Получение количества элементов в мультимножестве
count(Element, Multiset) -> dict:fetch(Element, Multiset, 0).

% Получение всех элементов мультимножества
elements(Multiset) -> dict:fold(fun(Element, Count, Acc) -> [{Element, Count} | Acc] end, [], Multiset).

% Объединение двух мультимножеств
union(Multiset1, Multiset2) -> dict:merge(fun(_, Count1, Count2) -> Count1 + Count2 end, Multiset1, Multiset2).

% Пересечение двух мультимножеств
intersection(Multiset1, Multiset2) -> dict:fold(fun(Element, Count1, Acc) -> NewCount = min(Count1, count(Element, Multiset2)), dict:update(Element, NewCount, Acc) end, dict:new(), Multiset1).

% Разность двух мультимножеств
difference(Multiset1, Multiset2) -> dict:fold(fun(Element, Count1, Acc) -> NewCount = Count1 - count(Element, Multiset2), dict:update(Element, NewCount, Acc) end, dict:new(), Multiset1).
