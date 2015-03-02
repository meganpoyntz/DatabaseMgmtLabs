﻿
select avg(dollars)
from orders
where mon = 'mar'
-- count (*) gives you the number of (e.g.) orders where the month is march
-- select * -- count ordno gives you with null
-- sum(qyt) gives you total quantity
-- sum(dollars) gives you total dollar amount
-- avg(dollars) gives you average dollar amount
-- sum, avg, max, min are all aggregates. need to specify by aggregates when you are "grouping by"

select mon,
       sum(dollars) as "total sales"
from orders
group by mon
order by "total sales" DESC
-- this is better becuase you don't have to restate the aggregation
-- postgres double quotes for column names
-- order by can also be written as: order by total_sales DESC (so there is no quotations) --> ONLY can do this in order by

select mon,
       sum(dollars) as "total sales"
from orders
where aid != 'a04'
group by mon
having sum(dollars) < 1000
-- not allowed to use the alias (total_sales) in "having" in postgres --> you need to use the aggregate which is sum(dollars)
order by total_sales DESC

select *
from orders

-- sales report of all agents, by agent by month
select aid,
       mon,
       sum(dollars) as total_sales
from orders
group by mon, aid
order by aid ASC, mon ASC
-- ordering by the output/what we want. order by the cloumns you're grouping by, and order them in the same order, going from general to specific
-- this makes for better information presentation
-- if aid is more important, put aid first in "select" / if month is more important, put mon first in "select"

select *
from
(select aid,
       mon,
       sum(dollars) as total_sales
 from orders
 group by mon, aid
 order by aid ASC, mon ASC) sub1
where total_sales > 1000

select *
from orders
order by ordno
-- hitting F7 gives you the "plan" of what postgres is going to do

select *
from orders, customers
-- taking every customer (1 thru 6) and combining it (multiplying it) by all orders (1 thru 14)
-- cartesian product of customers, orders (multiplying the two)
-- rows labeled 2, 3, 4, 5, and 6, are wrong (they were multiplied, they did not really happen)
-- need to write it correctly so it doesn't multiply:

select *
from orders, customers
where customers.cid = orders.cid
-- primary key is customers --> that's why it comes first
-- in the where clause there is a joined condiditon
-- alternate syntax: on the primary key joining the foreign key
select *
from customers inner join orders
on customers.cid = orders.cid
-- this code is better

-- is it possible to join primary keys with tables that don't have a foreign key? yes
-- just because you can, doesn't mean you shouldn't
-- SHOULD you join primary keys with tables that don't have a goreign key?
-- only do the above if you know what you're doing. you may end up with data that is completely meaningless and leads to no conclusion
-- 96% of the time, there are relationships between the primary key and foreign key that you're joining
select *
from customers inner join agents
on customers.city = agents.city
-- 1st spot: table (e.g. customers or agents), 2nd spot: column/field (e.g. city)

select *
from orders, customers, agents
where customers.cid = orders.cid
  and agents.aid = orders.aid
-- we still have exactly 14 rows, we have customer, order and agent data
-- three-way join that contains 3 tables and 2 join conditions (must have at least 2 join condiditons if you are going to join 3 tables)

-- joining all four tables:
select *
from orders, customers, agents, products
where orders.cid = customers.cid
  and orders.aid = agents.aid
  and orders.pid = products.pid
  
  and (orders.mon = 'feb'or orders.mon = 'mar')
-- we have exactly 14 rows and we are including infromation from all tables. all primary and foreign keys are matching
-- putting orders.___ first is a good way to present the data
-- if you do not put () around the "and 'feb' or 'mar'" condition, it will start multiplying again

select *
from orders o,
     customers c,
     agents a,
     products p
where o.cid = c.cid
  and o.aid = a.aid
  and o.pid = p.pid
  and (o.mon = 'feb'or o.mon = 'mar')
-- giving names of tables a shorter alias

-- another way to write this:
select *
from customers inner join orders on customers.cid = orders.cid
               inner join products on products.pid = orders.pid
               inner join agents on agents.aid = orders.aid
-- this is equivalent to the previous query
-- essentially joining the first two, taking those results and joining with the next one, taking those results and joining again, etc.





