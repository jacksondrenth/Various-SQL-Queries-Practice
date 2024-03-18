# part 1 
# 1 - inserted
# 2 
INSERT INTO `customer` (first_name, last_name, phone)
VALUES ("Jackson", "Drenth", "000-000-0000");

INSERT INTO ITEM (description, price)
VALUES ("BATMAN'S LAST OPTION", 3.0);

INSERT INTO invoice (date_in, customer_id)
VALUES ("2023-02-26", 51);

INSERT INTO invoice_item (invoice_id, item_id, quantity)
VALUES (201,14,1);

# 3
DESCRIBE Customer;
# or 
EXPLAIN customer;

# 4 
UPDATE customer
Set phone = "712-883-6006"
where customer_id = 13;

# 5
update item
set price = price + price * .14
where item_id = 8;

# 6
select *
from item
where price > 2.5 and price < 5;

# 7 
select first_name, last_name, phone
from customer
where last_name not like 'G%' and phone like '_13%';

# 8
select *
from customer
where email is not null
order by last_name asc, first_name DESC;

# 9
select count(*), max(price), min(price), ROUND(AVG(price),2)
from item;

# 10 
select email, MAX(length(email))
from customer;

# 11 
select DATEDIFF(now(), date_out)
from invoice;

# 12
SELECT date_in, COUNT(*)
FROM invoice
GROUP BY date_in
HAVING date_in > STR_TO_DATE('2019-06-01', '%Y-%m-%d');

# 13
select item_id, sum(quantity) as `total_quantity`
from invoice_item
group by item_id
Having total_quantity >= 200;

# 14
delete from item
where description = 'Formal Gown';

# part 2
# 1 
GRANT ALL PRIVILEGES 
ON customer 
to OWNER;
GRANT INSERT, UPDATE, DELETE 
ON CUSTOMER 
TO MANAGER;
GRANT SELECT, UPDATE 
ON CUSTOMER 
TO EMPLOYEE;
REVOKE SELECT 
on customer 
from HUMAN RESOURCES;

# 2
GRANT ALL PRIVILEGES 
on `invoice_item` 
to jst22941
with grant option;

# 3
GRANT SELECT 
ON *
to gfw95285;

# 4
REVOKE ALL, GRANT OPTION
on `invoice_item` 
from jst22941;

Revoke Select 
on *
from gfw95285;



