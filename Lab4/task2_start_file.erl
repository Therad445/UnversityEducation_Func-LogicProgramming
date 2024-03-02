-module(task2_start_file).
-export(my_function/0).
-import(task2, [start/1, send_to_child/2, stop/0]).

my_function() ->
    start(3),
    send_to_child(1, "Hello child!"),
    stop().
