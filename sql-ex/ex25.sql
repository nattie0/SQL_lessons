/* Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым 
быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker */

WITH minram AS (
SELECT model , speed 
FROM PC
WHERE ram = (SELECT MIN(ram) FROM PC)),

m AS(
SELECT model 
FROM minram
WHERE speed = (SELECT MAX(speed) FROM minram))

SELECT DISTINCT maker
FROM Product p JOIN m ON p.model = m.model
INTERSECT
SELECT DISTINCT maker
FROM Product
WHERE type = 'Printer'
