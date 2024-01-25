-- Task: Create a table 'users' with specified attributes including an enumeration for 'country'
-- All your files should start by a comment describing the task

-- Create table users with specified attributes, including an enumeration for 'country'
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,      -- id, integer, never null, auto increment and primary key
    email VARCHAR(255) NOT NULL UNIQUE,     -- email, string (255 characters), never null and unique
    name VARCHAR(255),                      -- name, string (255 characters)
    country ENUM('US', 'CO', 'TN') NOT NULL DEFAULT 'US'  -- country, enumeration of countries: US, CO, and TN, never null
);

-- Your SQL queries should have a comment just before (i.e., syntax above)

-- Attempt to select all records from users table (will fail if the table doesn't exist)
-- SELECT * FROM users;

-- Insert a record into the users table with country specified as 'US'
-- INSERT INTO users (email, name, country) VALUES ("bob@dylan.com", "Bob", "US");

-- Insert another record into the users table with country specified as 'CO'
-- INSERT INTO users (email, name, country) VALUES ("sylvie@dylan.com", "Sylvie", "CO");

-- Attempt to insert a record with an invalid country value (should fail)
-- INSERT INTO users (email, name, country) VALUES ("jean@dylan.com", "Jean", "FR");

-- Insert a record into the users table without specifying the country (default will be 'US')
-- INSERT INTO users (email, name) VALUES ("john@dylan.com", "John");

-- Select all records from the users table
-- SELECT * FROM users;
