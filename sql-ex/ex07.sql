/* Найдите номера моделей и цены всех имеющихся в продаже продуктов 
(любого типа) производителя B (латинская буква). */

WITH p AS (
SELECT p.model
FROM Product p 
WHERE maker = 'B')

SELECT p.model, price
FROM p JOIN PC ON p.model = PC.model
UNION
SELECT p.model,price
FROM p JOIN Laptop ON p.model = Laptop.model
UNION 
SELECT p.model,price
FROM p JOIN Printer ON p.model = Printer.model
