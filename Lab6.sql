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
SELECT customers.name, agents.name, products.name
FROM customers, agents, products, orders
WHERE customers.cid = orders.cid
	AND agents.aid = orders.aid
	AND products.pid = orders.pid
	AND agents.city = 'Tokyo'

-- Question 6: Write a query to check the accuracy of the dollars column in the Orders table.
-- This means calculating Orders.dollars from data in other tables and comparing those values to the values in Orders.dollars.
-- Display all rows in Orders where Orders.dollars is incorrect, if any.
SELECT orders.dollars AS ORIGINAL , a.RECALCULATED
FROM orders
FULL OUTER JOIN (SELECT orders.ordno, (products.priceUSD * orders.qty ) - ((products.priceUSD * orders.qty )* (customers.discount / 100)) AS RECALCULATED
		 FROM customers , agents , products , orders
		 WHERE orders.cid = customers.cid
		 AND orders.aid = agents.aid
		 AND orders.pid = products.pid
		 GROUP BY orders.ordno, (products.priceUSD * orders.qty ) - ((products.priceUSD * orders.qty )* (customers.discount / 100))
		 ORDER BY ordno) AS a
ON orders.ordno = a.ordno

-- Question 7: What’s the difference between a LEFT OUTER JOIN and a RIGHT OUTER JOIN?
-- Give example queries in SQL to demonstrate. (Feel free to use the CAP2 database t make your points here.)





