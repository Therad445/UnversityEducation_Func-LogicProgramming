-module(task1).
-export([merge/2, insert/2, in_order_traversal/1]).

-record(node, {value, left = nil, right = nil}).

%% Функция merge для объединения двух бинарных деревьев
merge(Tree1, nil) ->
    Tree1;
merge(nil, Tree2) ->
    Tree2;
merge(Tree1, Tree2) ->
    %% Получаем значения всех узлов первого дерева в виде списка
    Values1 = in_order_traversal(Tree1),
    %% Вставляем каждое значение из первого дерева во второе дерево
    MergedTree = lists:foldl(fun(Value, AccTree) ->
                                insert(Value, AccTree)
                             end, Tree2, Values1),
    MergedTree.

%% Функция вставки элемента в бинарное дерево
insert(Value, nil) ->
    #node{value = Value};
insert(Value, #node{value = NodeValue, left = Left, right = Right} = Node) ->
    case Value < NodeValue of
        true ->
            Node#node{left = insert(Value, Left)};
        false ->
            Node#node{right = insert(Value, Right)}
    end.

%% Функция обхода бинарного дерева в порядке возрастания значений
in_order_traversal(nil) ->
    [];
in_order_traversal(#node{value = Value, left = Left, right = Right}) ->
    in_order_traversal(Left) ++ [Value] ++ in_order_traversal(Right).




%     1> c(task1).

% {ok,tree}

% 2> Tree1 = task1:insert(5, task1:insert(3, task1:insert(7, nil))).
% 
% {node,7,{node,3,nil,{node,5,nil,nil}},nil}
% 
% 3> Tree2 = task1:insert(8, task1:insert(2, nil)).
%
% {node,2,nil,{node,8,nil,nil}}
% 
% 4> MergedTree = task1:merge(Tree1, Tree2).
% 
% {node,2,nil,{node,8,{node,3,nil,{node,5,nil,{node,7,nil,nil}}},nil}}
