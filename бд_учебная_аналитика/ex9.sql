/*
Вычислить рейтинг каждого студента относительно студента, прошедшего наибольшее количество шагов
в модуле (вычисляется как отношение количества пройденных студентом шагов к максимальному количеству 
пройденных шагов, умноженное на 100). Вывести номер модуля, имя студента, количество пройденных им шагов 
и относительный рейтинг. Относительный рейтинг округлить до одного знака после запятой. Столбцы назвать 
Модуль, Студент, Пройдено_шагов и Относительный_рейтинг  соответственно. Информацию отсортировать сначала 
по возрастанию номера модуля, потом по убыванию относительного рейтинга и, наконец, по имени студента в алфавитном порядке.
*/

WITH r (module_id, student_name, steps) AS (
  SELECT module_id, student_name, COUNT(DISTINCT step_id) AS  steps
  FROM lesson
    JOIN step USING (lesson_id)
    JOIN step_student USING (step_id)
    JOIN student USING (student_id)
  WHERE result = 'correct'
  GROUP BY module_id, student_name)
SELECT r.module_id AS Модуль,
  student_name AS Студент,
  steps AS Пройдено_шагов,
  ROUND(steps/MAX(steps) OVER (PARTITION BY module_id)*100, 1) AS Относительный_рейтинг
FROM r 
ORDER BY 1, 3 DESC, 2
