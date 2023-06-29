-- SQL Course [Code with Mosh]

-- Chapter 1 [Getting started]
-- Basic overview of the MySQL workbench completed.

-- Chapter 2 [Retrieving data from a single table]

-- 2.1 [The SELECT statement]

USE sql_store;

SELECT *
FROM customers
-- WHERE customer_id = 1
ORDER BY first_name;

-- 2.2 [SELECT statement in detail]

SELECT first_name, last_name, points
FROM customers;

SELECT DISTINCT state -- To get the unique states
FROM customers;

-- Exercise

SELECT name, unit_price, unit_price * 1.1 AS 'new price'
FROM products;

-- 2.3 [The WHERE clause]

SELECT *
FROM customers
WHERE points > 3000;

SELECT *
FROM customers
WHERE state = 'VA';

-- Exercise

SELECT *
FROM orders
WHERE order_date >= '2019-01-01';

-- 2.4 [AND,OR,NOT operators]

SELECT *
FROM customers
WHERE birth_date > '1990-01-01' AND points > 1000;


SELECT *
FROM customers
WHERE birth_date > '1990-01-01' OR points > 1000; -- Satisfies either of the conditions


SELECT *
FROM customers
WHERE birth_date > '1990-01-01' OR 
	(points > 1000 AND state = 'VA');

-- Always be aware of the order of execution for logical operators. AND get's first preference.

SELECT *
FROM customers
WHERE NOT (birth_date > '1990-01-01' OR points > 1000);

-- Exercise

SELECT *
FROM order_items
WHERE order_id = 6 AND quantity * unit_price > 30;


-- 2.5 [The IN operator]

SELECT *
FROM customers
WHERE state IN ('VA','FL','GA');

SELECT *
FROM customers
WHERE state NOT IN ('VA','FL','GA');

-- Exercise

SELECT *
FROM products
WHERE quantity_in_stock IN (49,38,72);

-- 2.6 [The BETWEEN operator]

SELECT *
FROM customers
WHERE points BETWEEN 1000 AND 3000;

-- Exercise

SELECT *
FROM customers
WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';

-- 2.7 [The LIKE operator]

SELECT *
FROM customers
WHERE last_name LIKE 'b%'; -- % indicates any number of characters after the specified character/s

SELECT *
FROM customers
WHERE last_name LIKE '%b%'; -- %b% indicates any number of characters before or after the specified character/s

SELECT *
FROM customers
WHERE last_name LIKE '_____y'; -- The _y indicates the specific number of characters in a string that ends with y

SELECT *
FROM customers
WHERE last_name LIKE 'b____y';

-- Exercises

SELECT *
FROM customers
WHERE address LIKE '%trail%' OR 
		address LIKE '%avenue%';

SELECT *
FROM customers
WHERE phone LIKE '%9';

-- 2.8 [The REGEXP operator]

SELECT *
FROM customers
-- WHERE last_name LIKE '%field%'
WHERE last_name REGEXP 'field'; -- This is the exactsame as line 137

SELECT *
FROM customers
WHERE last_name REGEXP '^field'; -- The ^ symbol indicates that our last_name must start with the mentioned string

SELECT *
FROM customers
WHERE last_name REGEXP 'field$'; -- The $ symbol indicates that our last_name must end with the mentioned string

SELECT *
FROM customers
WHERE last_name REGEXP 'field|mac'; -- The | symbol indicates that either one of the strings should be present in the last_name column

SELECT *
FROM customers
WHERE last_name REGEXP 'field$|mac|rose'; -- Combining multiple special characters

SELECT *
FROM customers
WHERE last_name REGEXP '[gim]e'; -- We use [] to indicate characters that can come before the character indicated like, ge,ie,me

SELECT *
FROM customers
WHERE last_name REGEXP 'e[frg]';

SELECT *
FROM customers
WHERE last_name REGEXP '[a-h]e'; -- We can also supply a range of characters

-- Exercise

SELECT *
FROM customers
WHERE first_name REGEXP 'Elka|Ambur';

SELECT *
FROM customers
WHERE last_name REGEXP 'ey$|on$';

SELECT *
FROM customers
WHERE last_name REGEXP '^my|se';

SELECT *
FROM customers
WHERE last_name REGEXP 'b[ru]';

-- 2.9 [The IS NULL operator]

SELECT *
FROM customers
WHERE phone IS NULL;

SELECT *
FROM customers
WHERE phone IS NOT NULL;

-- Exercise

SELECT *
FROM orders
WHERE shipped_date IS NULL;

-- 2.10 [The ORDER BY clause]

SELECT *
FROM customers
ORDER BY state, first_name;

SELECT *
FROM customers
ORDER BY state DESC, first_name;

-- Exercise

SELECT *, quantity * unit_price AS total_price
FROM order_items
WHERE order_id = 2
ORDER BY total_price DESC;

-- 2.11 [The LIMIT clause]

SELECT *
FROM customers
LIMIT 3;

SELECT *
FROM customers
LIMIT 6,3; -- Here 6 is called the offset. Which means SQL will skip the first 6 entries and show the next 3

-- Exercise

SELECT *
FROM customers
ORDER BY points DESC
LIMIT 3; -- Remember that the limit clause always comes at the end
