-- Megan Poyntz
-- Database Management Lab 3: Getting Started with SQL Queries

-- Question 1: List the ordno and dollars of all orders
SELECT *
FROM orders;

SELECT "ordno", "dollars"
FROM orders

-- Question 2: List the name and city of agents named Smith
SELECT *
FROM agents;

SELECT "name", "city"
FROM agents
WHERE name = 'Smith'

-- Question 3: List the pid, name, and priceUSD of products with quantity more than 200,000
SELECT *
FROM products

SELECT "pid", "name", "priceusd"
FROM products
WHERE quantity > 200000

-- Question 4: List the names and cities of customers in Dallas
SELECT *
FROM customers

SELECT "name", "city"
FROM customers
WHERE city = 'Dallas'

-- Question 5: List the names of agents not in New York and not in Tokyo
SELECT *
FROM agents

SELECT "name", "city"
FROM agents
WHERE city != 'New York' AND city != 'Tokyo'

-- Question 6: List all data for products not in Dallas or Duluth that cost US$1 or more
SELECT *
FROM products

SELECT *
FROM products
WHERE city != 'Dallas' AND city != 'Duluth' AND priceusd > 1

-- Question 7: List all data for orders in January or May
SELECT *
FROM orders

SELECT *
FROM orders
WHERE mon = 'jan' OR mon = 'may'

-- Question 8: List all data for orders in February more than us$500
SELECT *
FROM orders

SELECT *
FROM orders
WHERE mon = 'feb' AND dollars > 500

-- Question 9: List all orders from the customer whose cid is C005
SELECT *
FROM orders

SELECT *
FROM orders
WHERE cid = 'c005'