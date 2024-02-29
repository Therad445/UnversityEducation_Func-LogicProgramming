-module(task5).
-export([for/4]).

for(Init, Cond, Step, Body) ->
    for_loop(Init, Cond, Step, Body).

for_loop(Init, Cond, Step, Body) when not Cond(Init) -> ok;
for_loop(Init, Cond, Step, Body) ->
    Body(Init),
    Next = Step(Init),
    for_loop(Next, Cond, Step, Body).
