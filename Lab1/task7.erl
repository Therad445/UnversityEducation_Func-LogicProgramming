% -module(task7).
% -export([is_date/3]).

% % Определяем дни недели с 0 (понедельник) до 6 (воскресенье)
% % 1 января 2000 года - суббота, поэтому у нас начальное смещение равно 5.
% % Смещение увеличивается на 1 для каждого нового дня.
% is_date(Day, Month, Year) ->
%     WeekdayOffset = weekday_offset(2000),
%     Days = days_in_month(Month, Year),
%     is_date_helper(Day, Month, WeekdayOffset, 1, Days, is_leap_year(Year)).

% % Рекурсивная функция, которая увеличивает смещение на 1 для каждого дня и проверяет,
% % не дошли ли мы до искомой даты.
% is_date_helper(Day, 1, WeekdayOffset, CurrentDay, _, LeapYear) ->
%     case Day of
%         CurrentDay -> WeekdayOffset rem 7;
%         _ -> is_date_helper(Day, 12, WeekdayOffset + 1, CurrentDay + 1, days_in_month(12, LeapYear), LeapYear)
%     end;
% is_date_helper(Day, Month, WeekdayOffset, CurrentDay, Days, LeapYear) ->
%     case Day of
%         CurrentDay -> WeekdayOffset rem 7;
%         _ -> is_date_helper(Day, Month - 1, WeekdayOffset + 1, CurrentDay + 1, days_in_month(Month - 1, LeapYear), LeapYear)
%     end.

% % Функция определяет количество дней в месяце.
% days_in_month(2, true) -> 29;
% days_in_month(2, false) -> 28;
% days_in_month(Month, _) when Month rem 2 == 0 -> 30;
% days_in_month(_, _) -> 31.

% % Функция определяет начальное смещение дня недели для заданного года.
% weekday_offset(Year) ->
%     ((Year - 2000) * 365 + (Year - 2000) div 4 - (Year - 2000) div 100 + (Year - 2000) div 400).

% % Проверка, является ли год високосным.
% is_leap_year(Year) ->
%     (Year rem 4 == 0) and ((Year rem 100 /= 0) or (Year rem 400 == 0)).

-module(task7).
-export([is_date/3]).

is_date(DayOfMonth, MonthOfYear, Year) ->
    DayOfWeek = 1 + (DayOfMonth + 13 * (MonthOfYear - 1) + 15 * (Year - 1900) + 1900) rem 7,
    DayOfWeek.