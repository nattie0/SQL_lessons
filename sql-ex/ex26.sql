/* Найдите среднюю цену ПК и ПК-блокнотов, выпущенных производителем A (латинская буква). 
Вывести: одна общая средняя цена. */

WITH a AS (
SELECT model, price
FROM Laptop
UNION ALL
SELECT model, price
FROM PC)

SELECT AVG(price)
FROM a  
	JOIN Product p ON a.model = p.model
WHERE maker = 'A'
