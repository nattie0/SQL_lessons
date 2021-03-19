/*
Для студента с именем student_59 вывести следующую информацию по всем его попыткам:

информация о шаге: номер модуля, символ '.', позиция урока в модуле, символ '.', позиция шага в модуле;
порядковый номер попытки для каждого шага - определяется по возрастанию времени отправки попытки;
результат попытки;
время попытки (преобразованное к формату времени) - определяется как разность между временем отправки 
попытки и времени ее начала, в случае если попытка длилась более 1 часа, то время попытки заменить на 
среднее время всех попыток пользователя по всем шагам без учета тех, которые длились больше 1 часа;
относительное время попытки  - определяется как отношение времени попытки (с учетом замены времени попытки) 
к суммарному времени всех попыток  шага, округленное до двух знаков после запятой  .
Столбцы назвать  Студент,  Шаг, Номер_попытки, Результат, Время_попытки и Относительное_время. Информацию 
отсортировать сначала по возрастанию id шага, а затем по возрастанию номера попытки (определяется по времени отправки попытки).

Важно. Все вычисления производить в секундах, округлять и переводить во временной формат только для вывода результата.
*/

WITH a as (
SELECT student_name, student_id, ROUND(AVG(submission_time-attempt_time)) as avtime
FROM student JOIN step_student USING (student_id)
WHERE student_name = 'student_59'
    AND submission_time-attempt_time <= 3600
GROUP by student_name, student_id),

q as (  
SELECT submission_time, student_name, ss.step_id, student_id, module_id, lesson_position, step_position, IF(submission_time-attempt_time<3600, submission_time-attempt_time, avtime) AS dtime, avtime, result
FROM a
    JOIN step_student ss USING(student_id)
    JOIN step USING (step_id)
    JOIN lesson USING (lesson_id)),

w as (
    SELECT q.student_id, q.step_id, SUM(dtime) AS stime
FROM step_student ss JOIN q ON ss.student_id=q.student_id AND ss.submission_time=q.submission_time
GROUP BY student_id, step_id)

SELECT student_name AS Студент, 
    CONCAT(module_id, '.', lesson_position, '.', step_position) AS Шаг,
    ROW_NUMBER() OVER (PARTITION BY CONCAT(module_id, '.', lesson_position, '.', step_position) ORDER BY submission_time) AS Номер_попытки,
    result AS Результат,
    SEC_TO_TIME(dtime) AS Время_попытки,
    ROUND(dtime/stime*100, 2) AS Относительное_время
FROM q JOIN w ON q.student_id=w.student_id AND q.step_id=w.step_id
ORDER BY module_id, lesson_position, step_position, submission_time;
