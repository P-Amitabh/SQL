-- SQL Course [Code with Mosh]

-- Chapter 3 [Retrieving data from multiple tables]

-- 3.1 [Inner joins]

USE sql_store;

SELECT order_id, o.customer_id, first_name, last_name
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id;
    
-- Exercise

SELECT order_id, oi.product_id, quantity, oi.unit_price
FROM order_items oi
JOIN products p
	ON oi.product_id = p.product_id;
    
-- 3.2 [Joining across databases]

SELECT *
FROM order_items oi
JOIN sql_inventory.products p
	ON oi.product_id = p.product_id;
    
-- 3.3 [Self joins]

USE sql_hr;

SELECT
	e.employee_id,
    e.first_name,
    m.first_name AS manager
FROM employees e
JOIN employees m
	ON e.reports_to = m.employee_id;

-- 3.4 [Joining multiple tables]

USE sql_store;

SELECT
	o.order_id,
    o.order_date,
    c.first_name,
    c.last_name,
    os.name AS status
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
JOIN order_statuses os
	ON o.status = os.order_status_id;

-- Exercise

USE sql_invoicing;

SELECT
	p.date,
    p.invoice_id,
    p.amount,
    c.name,
    pm.name
FROM clients c
JOIN payments p
	ON c.client_id = p.client_id
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id;
    
-- 3.5 [Compound join conditions]

USE sql_store;

SELECT *
FROM order_items oi
JOIN order_item_notes oin
	ON oi.order_id = oin.order_id
    AND oi.product_id = oin.product_id;

-- 3.6 [Implicit join syntax]

-- Watched the tutorial. Note: Remember to include the WHERE clause or else you'll end up getting a cross join

-- 3.7 [Outer joins]

USE sql_store;

-- LEFT JOIN

SELECT
	c.customer_id,
    c.first_name,
    o.order_id
FROM customers c
LEFT JOIN orders o -- There are two types of outer joins - left join & right join
	ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

-- RIGHT JOIN

SELECT
	c.customer_id,
    c.first_name,
    o.order_id
FROM customers c
RIGHT JOIN orders o -- There are two types of outer joins - left join & right join
	ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

-- Exercise

SELECT
	p.product_id,
    name,
    quantity
FROM products p
LEFT JOIN order_items oi
	ON p.product_id = oi.product_id;

-- 3.8 [Outer joins between multiple tables]

SELECT
	c.customer_id,
    c.first_name,
    o.order_id,
    sh.name AS shipper
FROM customers c
LEFT JOIN orders o
	ON c.customer_id = o.customer_id
LEFT JOIN shippers sh
	ON o.shipper_id = sh.shipper_id
ORDER BY c.customer_id;

-- Exercise

SELECT
	o.order_date,
    o.order_id,
    c.first_name,
    s.name AS shipper,
    os.name AS status
FROM orders o
JOIN customers c
	ON c.customer_id = o.customer_id
LEFT JOIN shippers s
	ON o.shipper_id = s.shipper_id
JOIN order_statuses os
	ON o.status = os.order_status_id;

-- 3.9 [self outer joins]

USE sql_hr;

SELECT
	e.employee_id,
    e.first_name,
    em.first_name AS manager
FROM employees e
LEFT JOIN employees em
	ON e.reports_to = em.employee_id;

-- 3.10 [The USING clause]

USE sql_store;

SELECT
	o.order_id,
    c.first_name,
    s.name AS shipper
FROM orders o
JOIN customers c
	-- ON o.customer_id = c.customer_id
	USING (customer_id) -- Only works on columns that have the same name, you can even combine multiple join conditions
LEFT JOIN shippers s
	USING (shipper_id);

-- Exercise

USE sql_invoicing;

SELECT
	p.date,
    c.name AS client,
    p.amount,
    pm.name
FROM payments p
JOIN clients c
	USING (client_id)
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id;

-- 3.11 [Natural joins]

USE sql_store;

SELECT *
FROM orders o
NATURAL JOIN customers c;

-- 3.12 [Cross joins]

SELECT
	c.first_name AS customer,
    p.name AS product
FROM customers c -- Implicit syntac for a cross join would be FROM customers c, products p
CROSS JOIN products p
ORDER BY c.first_name;

-- Exercise

-- Explicit syntax

SELECT
	s.name AS shipper,
    p.name AS product
FROM shippers s
CROSS JOIN products p
ORDER BY s.name;

-- Implicit syntax

SELECT
	s.name AS shipper,
    p.name AS product
FROM shippers s, products p
ORDER BY s.name;

-- 3.13 [Unions]
-- Union helps to combine results from multiple queries

SELECT
	order_id,
    order_date,
    'Active' AS status
FROM orders
WHERE order_date >= '2019-01-01'
UNION
SELECT
	order_id,
    order_date,
    'Archive' AS status
FROM orders
WHERE order_date < '2019-01-01';

-- Exercise

SELECT
	customer_id,
    first_name,
    points,
	'Bronze' AS type
FROM customers
WHERE points < 2000
UNION
SELECT
	customer_id,
    first_name,
    points,
	'Silver' AS type
FROM customers
WHERE points BETWEEN 2000 AND 3000
UNION
SELECT
	customer_id,
    first_name,
    points,
	'Gold' AS type
FROM customers
WHERE points > 3000
ORDER BY points DESC;
