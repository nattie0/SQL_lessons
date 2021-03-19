/*
Проанализировать, в каком порядке и с каким интервалом пользователь отправлял последнее верно 
выполненное задание каждого урока. В базе занесены попытки студентов  для трех уроков курса, 
поэтому анализ проводить только для этих уроков.

Для студентов прошедших как минимум по одному шагу в каждом уроке, найти последний пройденный шаг
каждого урока - крайний шаг, и указать:

имя студента;
номер урока, состоящий из номера модуля и через точку позиции каждого урока в модуле;
время отправки  - время подачи решения на проверку;
разницу во времени отправки между текущим и предыдущим крайним шагом в днях, при этом для первого
шага поставить прочерк ("-"), а количество дней округлить до целого в большую сторону.
Столбцы назвать  Студент, Урок,  Макс_время_отправки и Интервал  соответственно. Отсортировать 
результаты по имени студента в алфавитном порядке, а потом по возрастанию времени отправки.
*/

WITH q AS (
SELECT student_name, module_id, lesson_position, MAX(submission_time) AS mtime
FROM student
    JOIN step_student ss USING (student_id)
    JOIN step USING (step_id)
    JOIN lesson USING (lesson_id)
WHERE result = 'correct' AND ss.student_id IN (
    SELECT student_id
    FROM step_student
        JOIN step USING (step_id)
    WHERE result = 'correct'
    GROUP BY student_id
    HAVING COUNT(DISTINCT lesson_id) = 3)
GROUP BY student_name, module_id, lesson_position)

SELECT  student_name AS Студент, 
    CONCAT(module_id, '.', lesson_position) AS Урок,
    FROM_UNIXTIME(mtime) AS Макс_время_отправки,
    IFNULL(CEILING((mtime - LAG(mtime) OVER (PARTITION BY student_name ORDER BY mtime)) / 86400), '-') AS Интервал
FROM q;
