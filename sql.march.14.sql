PDOException: SQLSTATE[HY000]: General error: 1366 Incorrect string value: '\xDEsk%'\x0D...' for column 'details' at row 1 in C:\inetpub\wwwroot\functions.php:14348
Stack trace:
#0 C:\inetpub\wwwroot\functions.php(14348): PDOStatement->execute(Array)
#1 C:\inetpub\wwwroot\functions.php(8040): insertActivity(Object(PDO), 'jnd98092', 'Downloaded Quer...', 'SELECT *\r\nFROM ...', 2, NULL, '/index.php?sche...')
#2 C:\inetpub\wwwroot\index.php(204): downloadQueryText(Object(PDO), 'lecture354b', 'query-code.sql', 'SELECT *\r\nFROM ...')
#3 {main}SELECT *
FROM salesperson
NATURAL JOIN territory;

# natural join
SELECT description, payment_date, amount, comment
FROM payment
NATURAL JOIN payment_type
WHERE comment = 'Cash';

# inner join
SELECT *
FROM customer c 
INNER JOIN `order` o ON c.customer_id = o.customer_id;

select *
from customer
inner join `order` USING(customer_id);

SELECT employee_id, description
FROM employee_skill
INNER JOIN skill USING(skill_id)
WHERE description = "Router";

select *
from employee_skill es 
inner join skill s ON s.skill_id = es.skill_id
where description = 'Router';

SELECT name, COUNT(product_id)
FROM product_line
INNER JOIN product USING(product_line_id)
GROUP BY name;

# outer join 
SELECT *
FROM customer 
LEFT OUTER JOIN `ORDER` USING(customer_id);
# using is for exact same name
SELECT *
FROM product_line
LEFT OUTER JOIN product USING(product_line_id);

SELECT first_name, last_name
from salesperson
RIGHT OUTER JOIN `order` USING(salesperson_id)
where salesperson_id is null;

# self join
SELECT e.employee_id, e.first_name, e.last_name,
CONCAT(m.first_name, ' ', m.last_name) AS manager
FROM employee e
INNER JOIN employee m on e.supervisor = m.employee_id;

SELECT e.employee_id, e.first_name, e.last_name,
CONCAT(m.first_name, ' ', m.last_name) AS manager
FROM employee e
INNER JOIN employee m on e.supervisor = m.employee_id
WHERE m.supervisor IS NULL;

# howework 
SELECT w.location, p.description, p.product_id
FROM work_center w 
INNER JOIN wc_product c on w.work_center_id = c.work_center_id
INNER JOIN product p on p.product_id = c.product_id;

# version 2 
SELECT location, description
FROM work_center
NATURAL JOIN wc_product
NATURAL JOIN product;
# question 2 
SELECT s.description, es.qualify_date, CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM employee e
INNER JOIN employee_skill es ON e.employee_id = es.employee_id
INNER JOIN skill s on s.skill_id = es.skill_id
WHERE s.skill_id = 3;

# subqueries 
SELECT p.description, p.price, a.avg_price
FROM (
  SELECT AVG(price) as `avg_price`
  FROM product
) a, product p
WHERE p.price > a.avg_price;

SELECT `payment_date`, `amount`
FROM `payment`
WHERE `order_id` IN (
  SELECT `order_id`
  FROM `order`
  WHERE `customer_id` IN (
    SELECT `customer_id`
    FROM `customer`
    WHERE `name` = 'Contemporary Casuals'
  )
)
AND `payment_type_id` IN (
  SELECT `payment_type_id`
  FROM `payment_type`
  WHERE `description` = 'Deposit'
);


# 1, 3 
SELECT first_name, last_name
FROM EMPLOYEE
WHERE EMPLOYEE_ID IN (
	SELECT EMPLOYEE_ID
  FROM EMPLOYEE_SKILL
  WHERE SKILL_ID IN (
  	SELECT skill_id
	FROM skill
	where description = 'Router'
  )
);

SELECT p.description, p.price, m.max_price
FROM (
  SELECT MAX(price) AS max_price
  FROM product
  WHERE description LIKE '%bookcase%'
) m, product p
WHERE p.price > m.max_price;

CREATE OR REPLACE VIEW `invoice` AS
SELECT c.*, o.order_id, o.order_date, ol.quantity, p.description, p.price, (ol.quantity * p.price) AS `subtotal`
FROM `customer` c
INNER JOIN `order` o ON o.customer_id = c.customer_id
INNER JOIN `order_line` ol ON o.order_id = ol.order_id
INNER JOIN `product` p ON ol.product_id = p.product_id
WHERE o.order_id = 2;

SELECT *
from invoice;

CREATE OR REPLACE VIEW sales_rep AS
SELECT DISTINCT s.salesperson_id, first_name as salesperson_first_name, last_name as salesperson_lase, c.*
FROM salesperson s
INNER JOIN `order` o on o.salesperson_id = s.salesperson_id
INNER JOIN `customer` c on c.customer_id = o.customer_id;


# march 14th
SELECT e.first_name, e.last_name, location
From employee e 
INNER JOIN employee_wc using(employee_id)
INNER JOIN work_center USING(work_center_id);

SELECT p.*, name
FROM payment p
INNER JOIN `order` using(order_id)
INNER JOIN customer using(customer_id)
WHERE name like '%Co%';


SELECT first_name, last_name, name
FROM salesperson 
INNER JOIN territory USING(territory_id)
INNER JOIN `order` USING(salesperson_id)
where order_id = 19;

select c.name, t.name
from customer c
inner join customer_territory using(customer_id)
inner join territory t using(territory_id)
where t.name = 'Central';


SELECT c.name, COUNT(o.order_id) AS total_number, SUM(price*quantity) AS total_cost
FROM customer c 
INNER JOIN `order` o ON o.customer_id=c.customer_id
INNER JOIN order_line ol ON ol.order_id=o.order_id
INNER JOIN product p ON p.product_id=ol.product_id
WHERE p.description LIKE 'Þsk%'
OR p.description LIKE '%table%'
GROUP BY c.customer_id
HAVING total_cost BETWEEN 1500 AND 5000; 
# group by because of the aggregate 

DELETE p
FROM payment p
INNER JOIN `order` o on o.order_id = p.order_id
INNER JOIN customer c ON c.customer_id = o.customer_id
where comment ='Cash'
And name ='ABC Furniture Co.';
