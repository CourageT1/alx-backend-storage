-- Task: Rank country origins of bands by the number of (non-unique) fans
-- All your files should start by a comment describing the task

-- Create the necessary table by importing the provided SQL dump
-- cat metal_bands.sql | mysql -uroot -p holberton;

-- Your SQL queries should have a comment just before (i.e., syntax above)

-- Rank country origins of bands by the number of (non-unique) fans
-- and store the result in the 'tmp_res' file
SELECT origin, COUNT(*) AS nb_fans
FROM metal_bands
GROUP BY origin
ORDER BY nb_fans DESC;

-- Note: The result will be stored in the 'tmp_res' file.
