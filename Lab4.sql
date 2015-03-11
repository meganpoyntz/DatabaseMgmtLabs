﻿-- Megan Poyntz
-- Database Management Lab 4: SQL Queries - The Subqueries Sequel

-- Question 1: Get the cities of agents booking an order for a customer whose cid is 'c006'.
SELECT city
FROM agents
WHERE aid in (
	SELECT aid
	FROM orders
	WHERE cid = 'c006')

-- Question 2: Get the pids of products ordered through any agent who takes at least one order from a customer in Kyoto, sorted by pid from highest to lowest. (This is not the same as asking for pids of products ordered by customers in Kyoto.)
SELECT distinct pid
FROM orders
WHERE aid in (
	SELECT aid
	FROM orders
	WHERE cid in(
		SELECT cid
		FROM customers
		WHERE city = 'Kyoto'))
order by pid desc

-- Question 3: Get the cids and names of customers who did not place an order through agent a03.
SELECT cid, name
FROM customers
WHERE cid not in (
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

-- Question 5: Get the pids of products NOT ordered by any customers who placed any order through agent a05.--> don't know if this is correct
SELECT pid
FROM products
WHERE pid in(
	SELECT pid
	FROM orders
	WHERE cid not in(
		SELECT cid
		FROM orders
		WHERE aid = 'a05'))

-- Question 6: Get the name, discounts, and city for all customers who place orders through agents in Dallas or New York.
SELECT name, discount, city
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

-- Question 8: 