-- Netflix Movies & TV Shows Analytics
-- Country Analysis

USE netflix_db;

-- Create normalized country table
CREATE TABLE IF NOT EXISTS netflix_countries (
    show_id VARCHAR(20),
    country VARCHAR(100)
);

-- Populate the country table
INSERT INTO netflix_countries (show_id, country)
SELECT
    n.show_id,
    TRIM(j.country)
FROM netflix AS n
JOIN JSON_TABLE(
    CONCAT(
        '["',
        REPLACE(
            COALESCE(n.country, ''),
            ', ',
            '","'
        ),
        '"]'
    ),
    '$[*]' COLUMNS (
        country VARCHAR(100) PATH '$'
    )
) AS j
WHERE n.country IS NOT NULL
  AND TRIM(n.country) <> '';

-- Check number of country records
SELECT COUNT(*) AS total_country_records
FROM netflix_countries;

-- Top 10 countries
SELECT
    country,
    COUNT(*) AS total_titles
FROM netflix_countries
GROUP BY country
ORDER BY total_titles DESC
LIMIT 10;

-- Indian content
SELECT
    n.title,
    n.type,
    n.release_year,
    n.rating
FROM netflix AS n
JOIN netflix_countries AS c
    ON n.show_id = c.show_id
WHERE c.country = 'India'
ORDER BY n.release_year DESC;

-- Indian content by release year
SELECT
    n.release_year,
    COUNT(DISTINCT n.show_id) AS total_titles
FROM netflix AS n
JOIN netflix_countries AS c
    ON n.show_id = c.show_id
WHERE c.country = 'India'
GROUP BY n.release_year
ORDER BY n.release_year;
