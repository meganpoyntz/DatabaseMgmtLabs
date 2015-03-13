-- Megan Poyntz
-- Database Management Lab 6: Interesting and (very very) Painful Queries

-- Question 1: Display the name and city of customers who live in any city that makes the most different kinds of products.
-- (There are two cities that make the most different products. Return the name and city of customers from either one of those.)
SELECT customers.name, customers.city
FROM customers
WHERE city IN(
	SELECT products.city
	FROM products
	GROUP BY city
	HAVING COUNT(city) IN(
		SELECT MAX (num)
		FROM(SELECT COUNT(city) AS NUM
		     FROM products
		     GROUP BY products.city) AS A))

-- Question 2: Display the names of products whose priceUSD is below the average priceUSD, in alphabetical order.
SELECT products.name
FROM products
WHERE priceUSD < (
	SELECT avg(priceUSD) AS avg
	FROM products)
ORDER BY products.name ASC 

-- Question 3: Display the customer name, pid ordered, and the dollars for all orders, sorted by dollars from high to low.
SELECT distinct c.name, o.pid, o.dollars
FROM customers c
JOIN orders o
ON c.cid = o.cid
ORDER BY o.dollars DESC 

-- Question 4: Display all customer names (in reverse alphabetical order) and their total ordered, and nothing more. Use coalesce to avoid showing NULLs.
SELECT a.name, COALESCE (sum (dollars), 0) as TOTAL
FROM (SELECT customers.name, customers.cid, orders.dollars
      FROM orders
      FULL OUTER JOIN customers ON orders.cid = customers.cid) AS A
GROUP BY a.name, a.cid
ORDER BY a.name DESC

-- Question 5: Display the names of all customers who bought products from agents based in Tokyo along with the names of the products they ordered,
-- and the names of the agents who sold it to them.
SELECT customers.name AS "Customer Name", agents.name AS "Agent Name", products.name AS "Product Name"
FROM customers, agents, products, orders
WHERE customers.cid = orders.cid
	AND agents.aid = orders.aid
	AND products.pid = orders.pid
	AND agents.city = 'Tokyo'

-- Question 6: Write a query to check the accuracy of the dollars column in the Orders table.
-- This means calculating Orders.dollars from data in other tables and comparing those values to the values in Orders.dollars.
-- Display all rows in Orders where Orders.dollars is incorrect, if any.
SELECT o.ordno AS "Order Number", o.dollars "Price", ((p.priceUSD * o.qty) - (c.discount / 100) * (p.priceUSD * o.qty)) AS "Price Check"
FROM orders o, products p, customers c
WHERE o.cid = c.cid
AND o.pid = p.pid
AND o.dollars != ((p.priceUSD * o.qty) - (c.discount / 100) * (p.priceUSD * o.qty))
ORDER BY o.ordno ASC;

-- Question 7: What’s the difference between a LEFT OUTER JOIN and a RIGHT OUTER JOIN?
-- Give example queries in SQL to demonstrate. (Feel free to use the CAP2 database t make your points here.)

-- When it comes to outer joins, you take all of the rows from one or both of the tables you are joining and show the data from the other tables they match up to,
-- including NULLs from the tables where the data does not match up. In outer joins, all of the data is shown,
-- regardless of whether or not it can be cross-referenced or matched.
-- The difference between left and right outer joins lies in the way the query is written and its position.
-- Say you have written a query to combine the customers and orders table. If you are specifying the foreign key in each table (e.g. customers.cid and orders.cid),
-- then the command is broken up into two parts; the left being “customers” or “orders” and the right being “cid.”
-- In a left outer join, the words on the left of the statement (in this case, “customers” and “orders”) would be combined, and only those.
-- Similarly, if you were to do a right outer join, then the word(s) on the right of the statement would be combined.
-- Below are two queries that show a left and right outer join. 
-- Left outer join:
SELECT *
FROM customers c LEFT OUTER JOIN orders o ON o.cid = c.cid
-- this shows all the data from the left part of the statements (including NULLS)
-- Right outer join:
SELECT *
FROM customers c RIGHT OUTER JOIN orders o ON o.cid = c.cid
-- this shows the data for the right part of the statements
