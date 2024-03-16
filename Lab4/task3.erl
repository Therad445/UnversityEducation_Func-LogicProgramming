-module(task3).
-export([par_foreach/3]).

par_foreach(F, List, Options) ->
    %% Создаем список процессов для выполнения функции F параллельно
    Pids = [spawn_link(fun() -> F(Item) end) || Item <- List],

    %% Устанавливаем мониторинг для каждого процесса
    [erlang:monitor(process, Pid) || Pid <- Pids],

    %% Ожидаем завершения всех процессов
    wait_for_pids(Pids).

wait_for_pids([]) ->
    ok;
wait_for_pids(Pids) ->
    receive
        {'DOWN', _MonitorRef, process, Pid, Reason} ->
            io:format("Process ~p exited with reason: ~p~n", [Pid, Reason]),
            wait_for_pids(lists:delete(Pid, Pids))
    end.



    % task3:par_foreach(fun(X) -> io:format("~p~n", [X]) end, [1, 2, 3, 4, 5], []).
