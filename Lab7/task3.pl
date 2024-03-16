dnf(Formula) :-
    to_dnf(Formula, _),
    writeln('Yes').

% Пустая ДНФ означает, что формула является тождественной ложью.
dnf(_) :-
    writeln('No').