-module(task6).
-export([sortBy/2]).

% task6:sortBy([1,30],[2]).

merge([], L) -> L;
merge(L, []) -> L;
merge([H1 | T1], [H2 | T2]) ->
    case compare(H1, H2) of
        less -> [H1 | merge(T1, [H2 | T2])];
        equal -> [H1 | merge(T1, T2)];
        greater -> [H2 | merge([H1 | T1], T2)]
    end.

compare(X, Y) when X < Y -> less;
compare(X, Y) when X > Y -> greater;
compare(_, _) -> equal.

split(List) ->
    split(List, List).

split([_, _ | Tail], [First | Rest]) ->
    {First, Rest1} = split(Tail, Rest),
    {Rest1, First};
split([_], Rest) ->
    {[], Rest};
split([], Rest) ->
    {[], Rest}.

sortBy(Comparator, List) ->
    case List of
        [] -> [];
        [_] -> List;
        _ ->
            {FirstHalf, SecondHalf} = split(List),
            SortedFirstHalf = sortBy(Comparator, FirstHalf),
            SortedSecondHalf = sortBy(Comparator, SecondHalf),
            merge(SortedFirstHalf, SortedSecondHalf)
    end.
