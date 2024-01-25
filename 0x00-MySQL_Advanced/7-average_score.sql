-- Task: Create a stored procedure ComputeAverageScoreForUser that computes and stores the average score for a student
-- All your files should start by a comment describing the task

-- Create the initial tables and data
-- cat 7-init.sql | mysql -uroot -p holberton;

-- Your SQL queries should have a comment just before (i.e., syntax above)

-- Create a stored procedure ComputeAverageScoreForUser
DELIMITER //
CREATE PROCEDURE ComputeAverageScoreForUser(
    IN p_user_id INT
)
BEGIN
    DECLARE total_score FLOAT;
    DECLARE total_projects INT;

    -- Calculate the total score and total number of projects for the user
    SELECT SUM(score), COUNT(DISTINCT project_id)
    INTO total_score, total_projects
    FROM corrections
    WHERE user_id = p_user_id;

    -- Calculate the average score and update the users table
    IF total_projects > 0 THEN
        UPDATE users
        SET average_score = total_score / total_projects
        WHERE id = p_user_id;
    ELSE
        UPDATE users
        SET average_score = 0
        WHERE id = p_user_id;
    END IF;
END;
//
DELIMITER ;

-- Show and compute average score
-- SELECT * FROM users;
-- SELECT * FROM corrections;

-- Compute average score for a specific user and display the updated users table
-- CALL ComputeAverageScoreForUser((SELECT id FROM users WHERE name = "Jeanne"));
-- SELECT "--";
-- SELECT * FROM users;
