-module(task7).
-export([is_date/3]).

% Функция для определения високосного года
is_leap_year(Year) when Year rem 4 =:= 0, Year rem 100 =/= 0; Year rem 400 =:= 0 -> true;
is_leap_year(_) -> false.

% Функция для определения количества дней в месяце
days_in_month(2, Year) when is_leap_year(Year) -> 29;
days_in_month(2, _) -> 28;
days_in_month(Month, _) when Month rem 2 =:= 0, Month =< 7 -> 30;
days_in_month(Month, _) -> 31.

% Функция для определения номера дня недели по заданной дате
is_date(DayOfMonth, MonthOfYear, Year) ->
    is_date(DayOfMonth, MonthOfYear, Year, 0, 0, 2000, 6).

is_date(1, 1, 2000, _, _, _, DayOfWeek) -> DayOfWeek;
is_date(Day, Month, Year, DayOfWeekAcc, DayOfMonthAcc, YearAcc, DayOfWeek) ->
    DaysInMonth = days_in_month(MonthOfYear, Year),
    case {Day, Month, Year, DayOfWeekAcc} of
        {_, _, _, 6} -> is_date(Day, Month, Year, 0, DayOfMonthAcc, YearAcc + 1, DayOfWeek);
        {_, _, _, _} -> 
            case {Day, Month, Year, DayOfWeekAcc} of
                {DayOfMonthAcc, MonthOfYear, YearAcc, _} ->
                    is_date(Day, Month, Year, DayOfWeekAcc + 1, 1, YearAcc, DayOfWeek);
                {_, _, _, _} ->
                    is_date(Day + 1, Month, Year, DayOfWeekAcc + 1, DayOfMonthAcc + 1, YearAcc, DayOfWeek)
            end
    end.
