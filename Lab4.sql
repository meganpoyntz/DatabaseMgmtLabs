-- Megan Poyntz
-- Database Management Lab 4: SQL Queries - The Subqueries Sequel

-- Question 1: Get the cities of agents booking an order for a customer whose cid is 'c006'.
SELECT city
FROM agents
WHERE aid in (
	SELECT aid
	FROM orders
	WHERE cid = 'c006')

-- Question 2: Get the pids of products ordered through any agent who takes at least one order from a customer in Kyoto, sorted by pid from highest to lowest.
-- (This is not the same as asking for pids of products ordered by customers in Kyoto.)
SELECT distinct pid
FROM orders
WHERE aid in (
	SELECT aid
	FROM orders
	WHERE cid in(
		SELECT cid
		FROM customers
		WHERE city = 'Kyoto'))
ORDER BY pid DESC

-- Question 3: Get the cids and names of customers who did not place an order through agent a03.
SELECT cid, name AS "Customer Name"
FROM customers
WHERE cid NOT in (
	SELECT cid
	FROM orders
	WHERE aid in(
		SELECT aid
		FROM orders
		WHERE aid = 'a03'))

-- Question 4: Get the cids of customers who ordered both product p01 and p07.
SELECT cid
FROM customers
WHERE cid in (
	SELECT cid
	FROM orders
	WHERE pid = 'p01'
	intersect
	SELECT cid
	FROM orders
	WHERE pid = 'p07')

-- Question 5: Get the pids of products NOT ordered by any customers who placed any order through agent a05.
SELECT pid
FROM products
WHERE pid in (
	SELECT pid
	FROM orders
	WHERE cid not in(
		SELECT cid
		FROM orders
		WHERE aid = 'a05'))

-- Question 6: Get the name, discounts, and city for all customers who place orders through agents in Dallas or New York.
SELECT name AS "Customer Name", discount, city
FROM customers
WHERE cid in (
	SELECT cid
	FROM orders
	WHERE aid in (
		SELECT aid
		FROM agents
		WHERE city = 'Dallas' OR city = 'New York'))

-- Question 7: Get all customers who have the same discount as that of any customers in Dallas or London
SELECT *
FROM customers
WHERE discount in(
	SELECT discount
	FROM customers
	WHERE city = 'Dallas' OR city = 'London')

-- Question 8: Tell me about check constraints: What are they? What are they good for? What’s the advantage of putting that sort of thing inside the database?
-- Make up some examples of good uses of check constraints and some examples of bad uses of check constraints.
-- Explain the differences in your examples and argue your case.

-- Check constraints, as the textbook states, are simple limits on values.
-- Check constraints specify a certain requirement that must be met by each row in a table, and can be applied to either one or multiple columns within that table.
-- Check constraints follow the 'WHERE' clause in a regular query or the 'FROM' clause in a sub-query, depending on what relations you are referring to.
-- Check constraints are important because they can be used to help check whenever any tuple gets a new value for an attribute.
-- Whether the new value is introduced by an update or insert into the data, check constraints make sure that the value introduced is valid.
-- Newly introduced values are also rejected if the new value violates the constraint, so check constraints are necessary in ensuring that the data entered into the table will function.
-- One of the most important things to keep in mind with check constraints is that the check will only work (truly “check”) if the database modification changes the attribute with which the constraint is associated.
-- Being a business major, the best example I can think of that uses check constraints focuses around a company database that holds all the data about the employees of the company.
-- The company that I interned at last semester had a field for the data regarding the level of employment of every employee; 1 indicating C-level employees,
-- 2 indicated VP-level employees, all the way down to 7, which indicated an entry level employee.
-- The check constraint would be very useful here to make sure that each employee had a number either 1 to 7, and nothing less than or greater than those numbers.
-- It would also be useful to check to make sure that employees were actually labeled with a number, especially if they are new entries, since every employee, no matter their job, was assigned a number.
-- However, there are situations where a check wouldn't work. Say, for instance, the employees' titles were listed in the database.
-- We could limit the titles in a field to a certain character number, however there would be no way to check if the titles were valid because there are different and unique titles throughout the employees that cannot be limited.
-- The check condition, in that instance, would not work. 









