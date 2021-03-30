/*
В предположении, что приход и расход денег на каждом пункте приема фиксируется не чаще 
одного раза в день [т.е. первичный ключ (пункт, дата)], написать запрос с выходными данными 
(пункт, дата, приход, расход). Использовать таблицы Income_o и Outcome_o.
*/

SELECT ISNULL(i.point, o.point), ISNULL(i.date, o.date), inc, out
FROM Income_o i FULL JOIN Outcome_o o ON i.point=o.point AND i.date=o.date
