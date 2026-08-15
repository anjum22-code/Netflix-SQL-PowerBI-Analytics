-- Netflix Movies & TV Shows Analytics
-- Genre Analysis

USE netflix_db;

-- Create normalized genre table
CREATE TABLE IF NOT EXISTS netflix_genres (
    show_id VARCHAR(20),
    genre VARCHAR(100)
);

-- Populate the genre table
INSERT INTO netflix_genres (show_id, genre)
SELECT
    n.show_id,
    TRIM(j.genre)
FROM netflix AS n
JOIN JSON_TABLE(
    CONCAT(
        '["',
        REPLACE(
            COALESCE(n.listed_in, ''),
            ', ',
            '","'
        ),
        '"]'
    ),
    '$[*]' COLUMNS (
        genre VARCHAR(100) PATH '$'
    )
) AS j
WHERE n.listed_in IS NOT NULL
  AND TRIM(n.listed_in) <> '';

-- Check number of genre records
SELECT COUNT(*) AS total_genre_records
FROM netflix_genres;

-- Top 10 genres
SELECT
    genre,
    COUNT(*) AS total_titles
FROM netflix_genres
GROUP BY genre
ORDER BY total_titles DESC
LIMIT 10;

-- Number of titles by genre
SELECT
    genre,
    COUNT(DISTINCT show_id) AS total_titles
FROM netflix_genres
GROUP BY genre
ORDER BY total_titles DESC;
