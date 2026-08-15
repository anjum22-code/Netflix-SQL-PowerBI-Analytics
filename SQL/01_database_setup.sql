-- Netflix Movies & TV Shows Analytics
-- Database Setup

CREATE DATABASE IF NOT EXISTS netflix_db;

USE netflix_db;

CREATE TABLE IF NOT EXISTS netflix (
    show_id VARCHAR(20),
    type VARCHAR(20),
    title VARCHAR(255),
    director TEXT,
    casts TEXT,
    country TEXT,
    date_added DATE,
    release_year INT,
    rating VARCHAR(20),
    duration VARCHAR(50),
    listed_in TEXT,
    description TEXT
);
