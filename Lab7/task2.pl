mean(List, Mean) :-
    sum_list(List, Sum),
    length(List, Length),
    Mean is Sum / Length.