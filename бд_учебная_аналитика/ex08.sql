/*
Посчитать среднее время, за которое пользователи проходят урок по следующему алгоритму:

для каждого пользователя вычислить время прохождения шага как сумму времени, потраченного на каждую попытку (время попытки - это разница между временем отправки задания и временем начала попытки), при этом попытки, которые длились больше 4 часов не учитывать, так как пользователь мог просто оставить задание открытым в браузере, а вернуться к нему на следующий день;
для каждого студента посчитать общее время, которое он затратил на каждый урок;
вычислить среднее время выполнения урока в часах, результат округлить до 2-х знаков после запятой;
вывести информацию по возрастанию времени, пронумеровав строки, для каждого урока указать номер модуля и его позицию в нем.
Столбцы результата назвать Номер, Урок, Среднее_время
*/

WITH time_les (student_id, module_id, lesson_position, lesson_name, time) AS 
(SELECT student_id, module_id, lesson_position, lesson_name, SUM(submission_time - attempt_time)
FROM step_student
    JOIN step USING (step_id)
    JOIN lesson USING (lesson_id)
WHERE (submission_time - attempt_time)/3600 <=4
GROUP BY student_id, module_id, lesson_position, lesson_name)

SELECT ROW_NUMBER() OVER (ORDER BY AVG(time)) AS Номер,
CONCAT(module_id, '.', lesson_position, ' ', lesson_name) AS Урок,
ROUND(AVG(time)/3600, 2) AS Среднее_время
FROM time_les
GROUP BY module_id, lesson_position, lesson_name
