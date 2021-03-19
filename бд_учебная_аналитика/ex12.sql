/*
Online курс обучающиеся могут проходить по различным траекториям, проследить за которыми можно 
по способу решения ими заданий шагов курса. Большинство обучающихся за несколько попыток  
получают правильный ответ 
и переходят к следующему шагу. Но есть такие, что остаются на шаге, выполняя несколько верных 
попыток, или переходят к следующему, оставив нерешенные шаги.

Выделив эти "необычные" действия обучающихся, можно проследить их траекторию работы с курсом 
и проанализировать задания, для которых эти действия выполнялись, а затем их как-то изменить. 

Для этой цели необходимо выделить группы обучающихся по способу прохождения шагов:

I группа - это те пользователи, которые после верной попытки решения шага делают неверную 
(скорее всего для того, чтобы поэкспериментировать или проверить, как работают примеры);
II группа - это те пользователи, которые делают больше одной верной попытки для одного шага 
(возможно, улучшают свое решение или пробуют другой вариант);
III группа - это те пользователи, которые не смогли решить задание какого-то шага (у них все 
попытки по этому шагу - неверные).
Вывести группу (I, II, III), имя пользователя, количество шагов, которые пользователь выполнил 
по соответствующему способу. Столбцы назвать Группа, Студент, Количество_шагов. Отсортировать 
информацию по возрастанию номеров групп, потом по убыванию количества шагов и, наконец, по имени 
студента в алфавитном порядке.
*/

WITH aright as (
SELECT student_name , student_id, step_id , COUNT(*) as c, MAX(submission_time) AS lastr, MIN(submission_time) AS minr
FROM student JOIN step_student USING (student_id)
WHERE result = 'correct'
GROUP BY step_id, student_id, student_name),

awrong as(
SELECT student_name , student_id, step_id , COUNT(*), MAX(submission_time) AS lastwr
FROM student JOIN step_student USING (student_id)
WHERE result <> 'correct'
GROUP BY step_id, student_name, student_id)

SELECT 'I' as Группа, student_name as Студент, COUNT(*) as Количество_шагов
FROM (
    SELECT student_name, step_id
    FROM aright JOIN awrong USING (student_name, step_id)
    WHERE lastwr > minr) q1
GROUP BY student_name

UNION ALL

SELECT 'II', student_name, COUNT(*)
FROM (
    SELECT student_name, step_id
    FROM aright
    WHERE c > 1) q2
GROUP BY student_name

UNION ALL

SELECT 'III', student_name, COUNT(*)
FROM awrong LEFT JOIN aright USING (student_name , step_id, student_id)
WHERE lastr IS NULL 
GROUP BY student_name
        
ORDER BY 1, 3 DESC, 2
