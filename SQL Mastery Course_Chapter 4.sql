-- SQL Course [Code with Mosh]

-- Chapter 4 [Inserting, Updating, and Deleting Data]

-- 4.1 [Column attributes]

-- Watched the explainer video explaining each component while viewing a table in design mode

-- 4.2 [Inserting a row]

USE sql_store;

INSERT INTO customers (
	first_name,
    last_name,
    birth_date,
    address,
    city,
    state)
VALUES (
-- DEFAULT, -- Since we have supplied the column names we want to input date into, we've commented out any DEFAULT or NULL values
	'John',
	'Smith',
	'1990-01-01',
-- NULL,
	'address',
	'city',
	'CA');

-- 4.3 [Inserting multiple rows]

-- We'll be using the SHIPPERS table for this
-- Since shipper_id is an auto-increment column, we aren't required to do anything.
-- We'll make additions to the name column.

INSERT INTO shippers (NAME)
VALUES ('Shipper 1'), 
		('Shipper 2'),
        ('Shipper 3');

-- Exercise

INSERT INTO products
	(name,
    quantity_in_stock,
    unit_price)
VALUES
	('Prodcut 1',10, 1.95),
    ('Prodcut 2',10, 1.95),
    ('Prodcut 3',10, 1.95);

-- 4.4 [Inserting hierarchical rows]

INSERT INTO orders
	(customer_id,
    order_date,
    status)
VALUES (
	1, -- Both customer_id and status columns require valid values
    '2019-01-02',
    1 -- Both customer_id and status columns require valid values
	);

INSERT INTO order_items
VALUES
	(LAST_INSERT_ID(), 1,1,2.95),
	(LAST_INSERT_ID(), 2,1,3.95);
    
-- 4.5 [Creating a copy of a table]
    
-- CREATE TABLE orders_archived AS -- We've truncated this table, as the data present isn't what we require
-- SELECT * 
-- FROM orders;

INSERT INTO orders_archived
SELECT *
FROM orders
WHERE order_date < '2019-01-01'; -- Selecting all the orders before 2019

-- Exercise

USE sql_invoicing;

CREATE TABLE invoices_archived AS
SELECT
	i.invoice_id,
    i.number,
    c.name AS client,
    i.invoice_total,
    i.payment_total,
    i.invoice_date,
    i.payment_date,
    i.due_date
FROM invoices i
JOIN clients c
	USING (client_id)
WHERE payment_date IS NOT NULL;

-- 4.6 [Updating a single row]

UPDATE invoices -- selecting the table from which to update
SET payment_total = 10, payment_date = '2019-03-01' -- specifiying the columns in which to update the values
WHERE invoice_id = 1; -- specifying the exact row to which the update must be made

-- In case you have made a mistake while updating a value, you can use the DEFAULT keyword to revert back

-- 4.7 [Updating multiple rows]

UPDATE invoices
SET
	payment_total = invoice_total * 0.5,
    payment_date = due_date
WHERE client_id = 3; -- updating values for the same client 
-- WHERE client_id IN (3,4) -- use the IN operator when you want to update for multiple specified values

-- Exercise

USE sql_store;

UPDATE customers
SET points = points + 50
WHERE birth_date < '1990-01-01';

-- 4.8 [Using subqueries in updates]

USE sql_invoicing;

UPDATE invoices
SET
	payment_total = invoice_total * 0.5,
    payment_date = due_date
WHERE client_id =
-- WHERE client_id IN
			(SELECT client_id		-- A subquery is a SELECT statement within another statement
            FROM clients
            WHERE name = 'Myworks');
            -- WHERE state IN ('CA','NY')

-- Exercise

USE sql_store;

UPDATE orders
SET comments = 'Gold Customer'
WHERE customer_id IN
	(SELECT customer_id
    FROM customers
    WHERE points > 3000);

-- 4.9 [Deleting rows]

USE sql_invoicing;

DELETE FROM invoices
-- WHERE invoice_id = 1 -- For deleting specified rows
WHERE client_id = (
			SELECT *
            FROM clients
            WHERE name = 'Myworks'
)

-- 4.10 [Restoring the databases]

-- Followed the instructions in the video tutorial, we used the original script used to create the databases, to restore them.
