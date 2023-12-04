SELECT * FROM orders;
CREATE TABLE orders (
id Integer,
	account_id Int,
	standerd_qty integer,
	occured_at timestamp without time zone,
	poster_qty integer,
	total int,
	gloss_amt numeric,
	standard_amt_usd numeric,
  total_amt_usd numeric,
	poster_amt_qty numeric,
FOREIGN KEY (account_id)REFERENCES account(id)
	);
	CREATE TABLE region(
id INT  PRIMARY KEY,
	name Varchar,
	sales_rep varchar
	);
	
----Question 1---
SELECT 
    web_events.occurred_at,
    web_events.channel,
    accounts.name,
    accounts.primary_poc
FROM 
    web_events
JOIN 
    accounts ON web_events.account_id = accounts.id
WHERE 
    accounts.name = 'Walmart';
	---Question 2---------

Provide a table that provides the region for each sales_rep along with their associated accounts. 
Your final table should include three columns: the region name, the sales rep name, and t
he account name. Sort the accounts alphabetically (A-Z) according to account name.

SELECT region.name AS region_name, 
accounts.name AS
account_name,
sales_reps.name
AS sales_reps_name
FROM 
sales_reps
JOIN
region ON region.id = sales_reps.region_id
JOIN 
accounts ON sales_reps.id = accounts.sales_rep_id
ORDER BY
accounts.name ASC;
___Question 3-----------
Provide the name for each region for every order, as well as the account name and the unit price
they paid (total_amt_usd/total) for the order. Your final table should have 3 columns: region name, 
account name, and unit price. A few accounts have
0 for total, so I divided by (total + 0.01) to assure not dividing by zero.

SELECT
region.name AS region_name,
accounts.name AS account_name,
orders.total_amt_usd / NULLIF(orders.total, 0) AS unit_price
 FROM
 orders
JOIN accounts ON  orders.account_id = accounts.id
JOIN sales_reps ON accounts.sales_rep_id = sales_reps.id
JOIN region ON sales_reps.region_id = region.id;
    
--------Q4-----------------
Provide a table that provides the region for each sales_rep along with their associated accounts.
This time only for the Midwest region. Your final table should include three columns: the region name, 
the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.

SELECT region.name AS region_name,
accounts.name AS account_name,
sales_reps.name AS sales_reps_name
FROM region
JOIN 
sales_reps ON region.id = sales_reps.region_id
JOIN 
accounts ON sales_reps.id = accounts.sales_rep_id
WHERE region.name = 'Midwest'
ORDER BY
accounts.name ASC 
LIMIT 1000;


_____Q5________________________________
Provide a table that provides the region for each sales_rep along with their associated accounts.
This time only for accounts where the sales rep has a first name starting with S and in the Midwest region. 
Your final table should include three columns: the region name, the sales rep name, and the account name. 
Sort the accounts alphabetically (A-Z) according to account name. 
 
 SELECT 
    sales_reps.name AS sales_reps_name,
    region.name AS region_name,
    accounts.name AS account_name
FROM 
    sales_reps
JOIN 
    region ON region.id = sales_reps.region_id
JOIN 
    accounts ON sales_reps.id = accounts.sales_rep_id
WHERE 
    region.name = 'Midwest' AND 
    sales_reps.name LIKE 'S%'
ORDER BY 
    accounts.name ASC;

-------Q6--------------------------------
Provide a table that provides the region for each sales_rep along with their associated accounts. 
This time only for accounts where the sales rep has a last name starting with K and in the Midwest region.
Your final table should include three columns: the region name, the sales rep name, and the account name. 
Sort the accounts alphabetically (A-Z) according to account name.


SELECT 
    sales_reps.name AS sales_reps_name,
    region.name AS region_name,
    accounts.name AS account_name
FROM 
    sales_reps
JOIN 
    region ON region.id = sales_reps.region_id
JOIN 
    accounts ON sales_reps.id = accounts.sales_rep_id
WHERE 
    region.name = 'Midwest' AND 
    sales_reps.name LIKE 'K%'
ORDER BY 
    accounts.name ASC;
------------Q7---------------------------

Provide the name for each region for every order,
as well as the account name and the unit price they paid (total_amt_usd/total) for the order. 
However, you should only provide the results if the standard order quantity exceeds 100. 
Your final table should have 3 columns: region name, account name, and unit price.
In order to avoid a division by zero error, 
adding .01 to the denominator here is helpful total_amt_usd/(total+0.01).

SELECT
    region.name AS region_name,
    accounts.name AS account_name,
    orders.total_amt_usd / (orders.total + 0.01) AS unit_price
FROM
    orders
JOIN
    accounts ON accounts.id = orders.account_id
JOIN
    sales_reps ON sales_reps.id = accounts.sales_rep_id
JOIN
    region ON region.id = sales_reps.region_id
WHERE
    orders.standard_qty > 100
ORDER BY
    account_name, region_name ASC;
	
 
 --------------- Q8--------------------------
 Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. 
 However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. 
 Your final table should have 3 columns: region name, account name, and unit price. 
 Sort for the smallest unit price first. In order to avoid a division by zero error, 
adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).

											   
SELECT	
    region.name AS region_name,
    accounts.name AS account_name,
    orders.total_amt_usd / (orders.total + 0.01) AS unit_price
FROM
    orders
JOIN
    accounts ON accounts.id = orders.account_id
JOIN
    sales_reps ON sales_reps.id = accounts.sales_rep_id
JOIN
    region ON region.id = sales_reps.region_id
WHERE
    orders.standard_qty > 100 AND poster_qty > 50
ORDER BY
    account_name, region_name ASC 
LIMIT 100;
												
												
	-------Q9------------------
What are the different channels used by account id 1001? Your final table should have only 2 columns: 
account name and the different channels. You can try SELECT DISTINCT to narrow down the results 
to only the unique values.
 
SELECT DISTINCT
    accounts.name AS account_name,
    web_events.channel AS channels
FROM
    accounts
JOIN
   web_events ON accounts.id = web_events.account_id
WHERE
    accounts.id = 1001;		   
											   
											   
											   
											   
											 
											   
											   
											   

											   
											   

											   
											   
											   
											   
											   
											   
											   
											   
											   
											   
											   
											   
												
												
												
 
	