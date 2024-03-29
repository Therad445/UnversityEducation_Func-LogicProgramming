Для оформления задачи 2 как OTP-приложение, мы будем использовать принципы OTP, такие как supervision (надзор), чтобы обеспечить надежную обработку ошибок и перезапуск дочерних процессов при необходимости.

В данной задаче у нас будет родительский процесс, управляющий N дочерними процессами, которые будут ожидать сообщения и обрабатывать их соответственно.

Файл `parent_children.app.src` (описание приложения):

```erlang
{application, parent_children,
 [
  {description, "Parent Children Application"},
  {vsn, "1.0.0"},
  {modules, [parent_children, parent_children_sup, child]},
  {registered, [parent_children_sup]},
  {applications, [kernel, stdlib]},
  {mod, {parent_children, []}},
  {env, []}
 ]}.
```

Файл `parent_children.app` (приложение):

```erlang
% Autogenerated file
{application, parent_children,
 [
  {description, "Parent Children Application"},
  {vsn, "1.0.0"},
  {registered, []},
  {applications,
   [kernel,
    stdlib
   ]},
  {env,[]},
  {modules, []}
 ]}.
```

Файл `parent_children_sup.erl` (supervisor):

```erlang
-module(parent_children_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
    Children = [{child, {child, start_link, []}, permanent, 5000, worker, [child]}],
    RestartStrategy = {one_for_one, 5, 10},
    {ok, {RestartStrategy, Children}}.
```

Файл `child.erl` (дочерний процесс):

```erlang
-module(child).
-behaviour(gen_server).

-export([start_link/0, init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
    {ok, []}.

handle_call(_Request, _From, State) ->
    Reply = ok,
    {reply, Reply, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info({stop}, _State) ->
    io:format("Child ~p stopping~n", [self()]),
    {stop, normal, ok};

handle_info({die}, _State) ->
    io:format("Child ~p dying~n", [self()]),
    exit(die);

handle_info(Msg, _State) ->
    io:format("Child ~p received: ~p~n", [self(), Msg]),
    {noreply, _State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.
```

Файл `parent_children.erl` (главный модуль):

```erlang
-module(parent_children).
-export([start/1, send_to_child/2, stop/0]).

start(N) ->
    supervisor:start_link({local, parent_children_sup}, parent_children_sup, []),
    lists:foreach(fun(_) -> spawn_link(fun() -> child:loop() end) end, lists:seq(1, N)).

send_to_child(I, Msg) ->
    supervisor:which_children(parent_children_sup),
    Child = lists:nth(I, supervisor:which_children(parent_children_sup)),
    case Child of
        {_, Pid, _, _, _} -> Pid ! Msg;
        _ -> io:format("Child ~p does not exist~n", [I])
    end.

stop() ->
    supervisor:terminate_child(parent_children_sup, child).
```

В данном решении `parent_children_sup` является супервизором, который наблюдает за дочерними процессами типа `child`. Каждый дочерний процесс `child` обрабатывает сообщения в цикле. Функции `start/1`, `send_to_child/2` и `stop/0` в модуле `parent_children` предоставляют интерфейс для запуска приложения, отправки сообщения дочернему процессу и остановки работы приложения соответственно.

Таким образом, данное решение представляет собой OTP-приложение, обеспечивающее управление над дочерними процессами и обработку возможных ошибок с помощью супервизора.