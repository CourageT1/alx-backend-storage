-- Task: Create a trigger to decrease the quantity of an item after adding a new order
-- All your files should start by a comment describing the task

-- Create the initial tables and data
-- cat 4-init.sql | mysql -uroot -p holberton;

-- Your SQL queries should have a comment just before (i.e., syntax above)

-- Create a trigger to decrease the quantity of an item after adding a new order
DELIMITER //
CREATE TRIGGER decrease_quantity AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    UPDATE items
    SET quantity = quantity - NEW.number
    WHERE name = NEW.item_name;
END;
//
DELIMITER ;

-- Show and add orders
-- SELECT * FROM items;
-- SELECT * FROM orders;

-- Add orders and display the updated items and orders
-- INSERT INTO orders (item_name, number) VALUES ('apple', 1);
-- INSERT INTO orders (item_name, number) VALUES ('apple', 3);
-- INSERT INTO orders (item_name, number) VALUES ('pear', 2);
-- SELECT "--";
-- SELECT * FROM items;
-- SELECT * FROM orders;
