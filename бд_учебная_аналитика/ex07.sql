/*
Для студента с именем student_61 вывести все его попытки: название шага, результат и дату 
отправки попытки (submission_time). Информацию отсортировать по дате отправки попытки и указать, 
сколько минут прошло между отправкой соседних попыток. Название шага ограничить 20 символами и 
добавить "...". Столбцы назвать Студент, Шаг, Результат, Дата_отправки, Разница
*/

SELECT student_name AS Студент,
    CONCAT(LEFT(step_name, 20), '...') AS Шаг,
    result AS Результат,
    FROM_UNIXTIME(submission_time) AS Дата_отправки, 
    SEC_TO_TIME(IFNULL (submission_time - LAG(submission_time) OVER (ORDER BY FROM_UNIXTIME(submission_time)), 0))  AS Разница
FROM student
    JOIN step_student USING (student_id)
    JOIN step USING (step_id)
WHERE student_name = 'student_61'
