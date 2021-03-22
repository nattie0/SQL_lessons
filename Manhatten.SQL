WITH q AS(
SELECT MIN(LAT_N), MIN(LONG_W), MAX(LAT_N), MAX(LONG_W)
FROM STATION)

SELECT ROUND(
        SQRT (
            POWER(LAT_N -(
                    SELECT MIN(LAT_N) FROM q), 2) + 
            POWER(LONG_W - (
                    SELECT MIN(LONG_W) FROM q), 2)), 
        4), 
    ROUND(
        SQRT (
            POWER((SELECT MAX(LAT_N) FROM q) - LAT_N, 2) + 
            POWER((SELECT MAX(LONG_W) FROM q) - LONG_W, 2)), 
    4)
FROM STATION
