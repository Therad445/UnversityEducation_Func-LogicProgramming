-module(task1).
-export([merge/2]).

% Определение типа для бинарного дерева
-type bin_tree() :: nil | {node, integer(), bin_tree(), bin_tree()}.

% Функция объединения двух бинарных деревьев
merge(Tree1, Tree2) ->
    case {Tree1, Tree2} of
        {nil, nil} -> nil;  % Если оба дерева пусты, возвращаем пустое дерево
        {nil, _} -> Tree2;  % Если первое дерево пусто, возвращаем второе дерево
        {_, nil} -> Tree1;  % Если второе дерево пусто, возвращаем первое дерево
        {{node, Key1, Left1, Right1}, {node, Key2, Left2, Right2}} ->
            % Если оба дерева не пусты, объединяем их и создаем новое дерево
            {node, Key1, merge(Left1, Tree2), merge(Right1, Tree2)};
        _ -> Tree1  % В остальных случаях возвращаем первое дерево
    end.
