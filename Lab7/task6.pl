% Предикат для сложения многочленов
add_poly(poly(T1), poly(T2), poly(Sum)) :-
    append(T1, T2, Terms),
    group_terms(Terms, SumTerms),
    sort(SumTerms, Sorted),
    merge_similar(Sorted, Sum).

% Предикат для умножения многочленов
multiply_poly(poly(Terms1), poly(Terms2), poly(Product)) :-
    findall(Term, (member(Term1, Terms1), member(Term2, Terms2), multiply_term(Term1, Term2, Term)), ProductTerms),
    group_terms(ProductTerms, Grouped),
    merge_similar(Grouped, Product).

% Предикат для умножения одного терма на другой
multiply_term(term(Coeff1, Exp1), term(Coeff2, Exp2), term(Product, SumExp)) :-
    Product is Coeff1 * Coeff2,
    SumExp is Exp1 + Exp2.

% Предикат для группировки одинаковых термов
group_terms(Terms, Grouped) :-
    group_terms(Terms, [], Grouped).

group_terms([], Grouped, Grouped).
group_terms([term(Coeff, Exp) | Tail], Acc, Grouped) :-
    select(term(Coeff, Exp), Acc, Rest, Updated),
    NewCoeff is Coeff + Updated,
    group_terms(Tail, [term(NewCoeff, Exp) | Rest], Grouped).
group_terms([term(Coeff, Exp) | Tail], Acc, Grouped) :-
    group_terms(Tail, [term(Coeff, Exp) | Acc], Grouped).

% Предикат для объединения одинаковых термов
merge_similar([], []).
merge_similar([term(Coeff, Exp) | Tail], [term(Coeff, Exp) | Result]) :-
    merge_similar(Tail, Result), !.
merge_similar([term(Coeff1, Exp1), term(Coeff2, Exp2) | Tail], Result) :-
    Exp1 \= Exp2,
    merge_similar([term(Coeff2, Exp2) | Tail], Rest),
    Result = [term(Coeff1, Exp1) | Rest].

% Предикат для преобразования выражения в многочлен
polynomize(Expr, Poly) :-
    polynomize(Expr, poly([], []), Poly).

polynomize(X, poly([], [term(1, 1)]), poly([], [term(1, 1)])) :-
    var(X), !.
polynomize(N, poly([], [term(N, 0)]), poly([], [term(N, 0)])) :-
    number(N), !.
polynomize(X^N, poly([], [term(1, N)]), poly([], [term(1, N)])) :-
    var(X), integer(N), !.
polynomize(X^N, poly([], [term(1, N)]), poly([], [term(1, N)])) :-
    atom(X), integer(N), !.
polynomize(X + Y, poly([], [term(1, 1)]), Poly) :-
    polynomize(X, PolyX),
    polynomize(Y, PolyY),
    add_poly(PolyX, PolyY, Poly), !.
polynomize(X * Y, poly([], [term(1, 1)]), Poly) :-
    polynomize(X, PolyX),
    polynomize(Y, PolyY),
    multiply_poly(PolyX, PolyY, Poly), !.

% Необходимые правила для сложения и умножения констант и многочленов
polynomize(X + N, poly([], [term(1, 0)]), Poly) :-
    polynomize(X, PolyX),
    polynomize(N, PolyN),
    add_poly(PolyX, PolyN, Poly), !.
polynomize(N + X, poly([], [term(1, 0)]), Poly) :-
    polynomize(N, PolyN),
    polynomize(X, PolyX),
    add_poly(PolyN, PolyX, Poly), !.
polynomize(X * N, poly([], [term(1, 1)]), Poly) :-
    polynomize(X, PolyX),
    polynomize(N, NPoly),
    multiply_poly(PolyX, NPoly, Poly), !.
polynomize(N * X, poly([], [term(1, 1)]), Poly) :-
    polynomize(N, NPoly),
    polynomize(X, PolyX),
    multiply_poly(NPoly, PolyX, Poly), !.

% Также необходимо правило для преобразования числа в многочлен
polynomize(N, poly([], [term(N, 0)]), poly([], [term(N, 0)])).
