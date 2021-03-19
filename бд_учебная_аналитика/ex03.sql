/*
Реализовать поиск по ключевым словам. Вывести шаги, с которыми связаны ключевые слова MIN и AVG одновременно. 
Для шагов указать номер модуля, номер урока, номер шага через точку, после номера шага перед заголовком - пробел. 
Столбец назвать Шаг. Информацию отсортировать по возрастанию сначала по порядковому номеру модуля, затем по 
порядковым номерам урока и шага соответственно.
*/

SELECT CONCAT(module_id, '.', lesson_position, '.', step_position, ' ', step_name) AS Шаг
FROM lesson 
    JOIN step USING (lesson_id)
    JOIN step_keyword USING (step_id)
    JOIN keyword USING (keyword_id)
WHERE keyword_name in ('AVG', 'MIN')
GROUP BY Шаг
HAVING COUNT(keyword_name) = 2
ORDER BY Шаг;
