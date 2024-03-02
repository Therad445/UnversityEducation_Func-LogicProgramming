-module(test).
-export([min/1]).
-export([fac/1]).
-export([len/1]).
-export([tail_fac/1]).
-export([duplicate/2]).
-export([tail_duplicate/2]).
-export([reverse/1]).

min(_) -> 0.

fac(N) when N == 0 -> 1;
fac(N) when N > 0 -> N* fac(N-1).

len([]) -> 0;
len([_|T]) -> 1 + len(T).

tail_fac(N) -> tail_fac(N, 1).

tail_fac(0, All) -> All;
tail_fac(N, All) when N > 0 -> tail_fac(N-1, N*All).

duplicate(0, _) -> [];
duplicate(N, Elem) when N > 0 -> [Elem | duplicate(N-1, Elem)].

tail_duplicate(I,Elem) -> tail_duplicate(I, Elem, []).
tail_duplicate(I, _, Str) when I == 0 -> Str;
tail_duplicate(I, Elem, Str) when I > 0 -> tail_duplicate(I-1, Elem, [Elem | Str]).

reverse()