-- Netflix Movies & TV Shows Analytics
-- Data Cleaning and Data Quality Checks

USE netflix_db;

-- Check total number of records
SELECT COUNT(*) AS total_records
FROM netflix;

-- Check for duplicate show IDs
SELECT
    show_id,
    COUNT(*) AS duplicate_count
FROM netflix
GROUP BY show_id
HAVING COUNT(*) > 1;

-- Check missing values
SELECT
    SUM(show_id IS NULL OR TRIM(show_id) = '') AS missing_show_id,
    SUM(title IS NULL OR TRIM(title) = '') AS missing_title,
    SUM(director IS NULL OR TRIM(director) = '') AS missing_director,
    SUM(casts IS NULL OR TRIM(casts) = '') AS missing_cast,
    SUM(country IS NULL OR TRIM(country) = '') AS missing_country,
    SUM(date_added IS NULL) AS missing_date_added,
    SUM(rating IS NULL OR TRIM(rating) = '') AS missing_rating,
    SUM(duration IS NULL OR TRIM(duration) = '') AS missing_duration
FROM netflix;

-- Check date range
SELECT
    MIN(date_added) AS earliest_date_added,
    MAX(date_added) AS latest_date_added
FROM netflix;

-- Check release year range
SELECT
    MIN(release_year) AS earliest_release_year,
    MAX(release_year) AS latest_release_year
FROM netflix;
