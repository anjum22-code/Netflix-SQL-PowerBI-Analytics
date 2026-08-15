-- Netflix Movies & TV Shows Analytics
-- Cast / Actor Analysis

USE netflix_db;

-- Create normalized cast table
CREATE TABLE IF NOT EXISTS netflix_cast (
    show_id VARCHAR(20),
    actor VARCHAR(150)
);

-- Populate the cast table by splitting
-- comma-separated actor names
INSERT INTO netflix_cast (show_id, actor)
WITH RECURSIVE cast_split AS (

    SELECT
        show_id,
        TRIM(SUBSTRING_INDEX(casts, ',', 1)) AS actor,
        CASE
            WHEN INSTR(casts, ',') > 0
            THEN TRIM(SUBSTRING(casts, INSTR(casts, ',') + 1))
            ELSE ''
        END AS remaining
    FROM netflix
    WHERE casts IS NOT NULL
      AND TRIM(casts) <> ''

    UNION ALL

    SELECT
        show_id,
        TRIM(SUBSTRING_INDEX(remaining, ',', 1)) AS actor,
        CASE
            WHEN INSTR(remaining, ',') > 0
            THEN TRIM(SUBSTRING(remaining, INSTR(remaining, ',') + 1))
            ELSE ''
        END AS remaining
    FROM cast_split
    WHERE remaining <> ''
)

SELECT
    show_id,
    actor
FROM cast_split
WHERE actor <> '';

-- Check number of actor records
SELECT COUNT(*) AS total_cast_records
FROM netflix_cast;

-- Top 10 actors
SELECT
    actor,
    COUNT(*) AS appearances
FROM netflix_cast
GROUP BY actor
ORDER BY appearances DESC
LIMIT 10;

-- Top 10 directors
SELECT
    director,
    COUNT(*) AS total_titles
FROM netflix
WHERE director IS NOT NULL
  AND TRIM(director) <> ''
GROUP BY director
ORDER BY total_titles DESC
LIMIT 10;
