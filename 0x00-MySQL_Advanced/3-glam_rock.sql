-- Task: List all bands with Glam rock as their main style, ranked by their longevity
-- All your files should start by a comment describing the task

-- Create the necessary table by importing the provided SQL dump
-- cat metal_bands.sql | mysql -uroot -p holberton;

-- Your SQL queries should have a comment just before (i.e., syntax above)

-- List all bands with Glam rock as their main style, ranked by their longevity
-- and display the band_name and lifespan (in years until 2022)
SELECT
    band_name,
    IFNULL(YEAR(2022) - CAST(SUBSTRING_INDEX(splitted, '-', 1) AS UNSIGNED), 0) AS lifespan
FROM metal_bands
WHERE FIND_IN_SET('Glam rock', styles) > 0
ORDER BY lifespan DESC, band_name;
