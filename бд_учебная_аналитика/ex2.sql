/*
Заполнить таблицу step_keyword следующим образом: если ключевое слово есть в названии шага, 
то включить в step_keyword строку с id шага и id ключевого слова. 
*/

INSERT INTO step_keyword (keyword_id, step_id)
SELECT keyword_id, step_id
FROM keyword
  CROSS JOIN step
WHERE step_name REGEXP CONCAT('\\b', keyword_name, '\\b'
)
