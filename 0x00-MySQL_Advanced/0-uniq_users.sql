-- Task: Create a table 'users' with specified attributes
-- All your files should start by a comment describing the task

-- Create table users with specified attributes
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- id, integer, never null, auto increment and primary key
    email VARCHAR(255) NOT NULL UNIQUE, -- email, string (255 characters), never null and unique
    name VARCHAR(255)                    -- name, string (255 characters)
);

-- Your SQL queries should have a comment just before (i.e., syntax above)

-- Attempt to select all records from users table (will fail if the table doesn't exist)
-- SELECT * FROM users;

-- Insert a record into the users table
-- INSERT INTO users (email, name) VALUES ("bob@dylan.com", "Bob");

-- Insert another record into the users table
-- INSERT INTO users (email, name) VALUES ("sylvie@dylan.com", "Sylvie");

-- Attempt to insert a record with a duplicate email (should fail due to the unique constraint)
-- INSERT INTO users (email, name) VALUES ("bob@dylan.com", "Jean");

-- Select all records from the users table
-- SELECT * FROM users;
