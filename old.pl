% Это факты
older(sasha, lesha, fact). % Саша старше Лёши
older(misha, sasha, fact). % Миша старше Саши
older(misha, dasha, fact). % Миша старше Даши
older(masha, misha, fact). % Маша старше Миши

% Это правило
older(X,Y, rule) :- older(X, Z, fact), older(Z,Y, _).

% X старше Y, если X старше Z и Z старше Y
% Проще: X > Y, если X > Z и Z > Y
%
% X, Y, Z - это переменные. 
% Вместо X, Y, Z подставляются конкретные значения: misha, dasha, sasha, lesha
% Main idea: если Пролог найдет среднего Z, который между X и Y, то X старше Y.