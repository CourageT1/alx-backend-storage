-- Task: Create a stored procedure AddBonus that adds a new correction for a student
-- All your files should start by a comment describing the task

-- Create the initial tables and data
-- cat 6-init.sql | mysql -uroot -p holberton;

-- Your SQL queries should have a comment just before (i.e., syntax above)

-- Create a stored procedure AddBonus
DELIMITER //
CREATE PROCEDURE AddBonus(
    IN p_user_id INT,
    IN p_project_name VARCHAR(255),
    IN p_score INT
)
BEGIN
    DECLARE project_id INT;

    -- Check if the project already exists
    SET project_id = (SELECT id FROM projects WHERE name = p_project_name);

    -- If the project doesn't exist, create it
    IF project_id IS NULL THEN
        INSERT INTO projects (name) VALUES (p_project_name);
        SET project_id = LAST_INSERT_ID();
    END IF;

    -- Add the bonus correction
    INSERT INTO corrections (user_id, project_id, score) VALUES (p_user_id, project_id, p_score);
END;
//
DELIMITER ;

-- Show and add bonus correction
-- SELECT * FROM projects;
-- SELECT * FROM corrections;

-- Add bonus corrections and display the updated projects and corrections
-- CALL AddBonus((SELECT id FROM users WHERE name = "Jeanne"), "Python is cool", 100);
-- CALL AddBonus((SELECT id FROM users WHERE name = "Jeanne"), "Bonus project", 100);
-- CALL AddBonus((SELECT id FROM users WHERE name = "Bob"), "Bonus project", 10);
-- CALL AddBonus((SELECT id FROM users WHERE name = "Jeanne"), "New bonus", 90);
-- SELECT "--";
-- SELECT * FROM projects;
-- SELECT * FROM corrections;
