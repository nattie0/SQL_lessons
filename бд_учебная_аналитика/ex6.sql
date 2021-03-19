/*
Вычислить прогресс пользователей по курсу. Прогресс вычисляется как отношение верно пройденных шагов 
к общему количеству шагов в процентах, округленное до целого. В нашей базе данные о решениях занесены 
не для всех шагов, поэтому общее количество шагов определить как количество различных шагов в таблице step_student.

Тем пользователям, которые прошли все шаги (прогресс = 100%) выдать "Сертификат с отличием". Тем, у 
кого прогресс больше или равен 80% - "Сертификат". Для остальных записей в столбце Результат задать пустую строку ("").

Информацию отсортировать по убыванию прогресса, затем по имени пользователя в алфавитном порядке.
*/

SET @n = (SELECT COUNT(DISTINCT step_id)/100 FROM step_student);

SELECT student_name AS Студент,
    ROUND(COUNT(DISTINCT step_id)/@n) AS Прогресс,
    CASE 
        WHEN COUNT(DISTINCT step_id)/@n = 100
        THEN 'Сертификат с отличием'
        WHEN COUNT(DISTINCT step_id)/@n >  80
        THEN 'Сертификат'
        ELSE ''
    END AS Результат
FROM student
    JOIN step_student USING (student_id)
WHERE result = 'correct'
GROUP BY student_name
ORDER BY Прогресс DESC, student_name
