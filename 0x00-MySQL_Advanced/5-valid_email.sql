-- Task: Create a trigger to reset the attribute valid_email only when the email has been changed
-- All your files should start by a comment describing the task

-- Create the initial tables and data
-- cat 5-init.sql | mysql -uroot -p holberton;

-- Your SQL queries should have a comment just before (i.e., syntax above)

-- Create a trigger to reset the attribute valid_email only when the email has been changed
DELIMITER //
CREATE TRIGGER reset_valid_email AFTER UPDATE ON users
FOR EACH ROW
BEGIN
    IF NEW.email <> OLD.email THEN
        SET NEW.valid_email = 0;
    END IF;
END;
//
DELIMITER ;

-- Show users and update (or not) email
-- SELECT * FROM users;

-- Update emails and display the updated users
-- UPDATE users SET valid_email = 1 WHERE email = "bob@dylan.com";
-- UPDATE users SET email = "sylvie+new@dylan.com" WHERE email = "sylvie@dylan.com";
-- UPDATE users SET name = "Jannis" WHERE email = "jeanne@dylan.com";
-- SELECT "--";
-- SELECT * FROM users;

-- Update an email to itself and display the users
-- UPDATE users SET email = "bob@dylan.com" WHERE email = "bob@dylan.com";
-- SELECT "--";
-- SELECT * FROM users;
