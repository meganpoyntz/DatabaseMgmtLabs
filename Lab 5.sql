-- Megan Poyntz
-- Database Management Lab 5: SQL Series - The Joins Three-quel

-- Question 1: Show the cities of agents booking an order for a customer whose cid is 'c006'. Use joins; no subqueries.


-- Question 2: Show the pids of products ordered through any agent who makes at least one order for a customer in Kyoto, sorted by pid from highest to lowest. Use joins; no subqueries.
SELECT distinct p.pid
FROM orders o
INNER JOIN customers c ON c.cid = o.cid AND c.city = 'Kyoto'
INNER JOIN orders o2 ON o.aid = o2.aid
INNER JOIN products p ON o2.pid = p.pid
ORDER BY p.pid

-- Question 3: Show the names of customers who have never placed an order. Use a subquery.
SELECT name
FROM customers
WHERE cid not in (
	SELECT distinct cid
	FROM orders)

-- Question 4: Show the names of customers who have never placed an order. Use an outer join.
SELECT c.name
FROM customers c
LEFT OUTER JOIN orders o ON o.cid=c.cid
WHERE ordno is null

-- Question 5: Show the names of customers who placed at least one order through an agent in their own city, along with those agent(s') names.
SELECT distinct c.name, a.name
FROM customers c
INNER JOIN orders o ON c.cid = o.cid
INNER JOIN agents a ON a.city = c.city

-- Question 6: Show the names of customers and agents living in the same city, along with the name of the shared city,
-- regardless of whether or not the customer has ever placed an order with that agent.
SELECT distinct c.name, a.name, c.city
FROM customers c, agents a
WHERE c.city = a.city
ORDER BY city;

-- Question 7: Show the name and city of customers who live in the city that makes the fewest different kinds of products.
-- (Hint: Use count and group by on the Products table.)
SELECT c.name, c.city
FROM customers c
WHERE c.city in (
	SELECT p.city
	FROM products p
	GROUP BY p.city
	ORDER BY count(p.city) ASC
	LIMIT 1)

