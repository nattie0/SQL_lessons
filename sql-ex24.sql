--Перечислите номера моделей любых типов, имеющих самую высокую цену по всей имеющейся в базе данных продукции.

WITH prices AS (
SELECT model, price
FROM PC
UNION
SELECT model, price
FROM Laptop
UNION
SELECT model, price
FROM Printer)

SELECT model
FROM prices
WHERE price = (SELECT MAX(price) FROM prices)
