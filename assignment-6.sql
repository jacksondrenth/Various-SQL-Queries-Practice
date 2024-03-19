# Show item information for all items that have been included on an invoice. Show common columns only once.

SELECT i.invoice_id, l.*
FROM invoice i
INNER JOIN invoice_item ii on ii.invoice_id = i.invoice_id
INNER JOIN item l using(item_id);
# GROUP BY i.invoice_id;

# Show customers and their invoices. Include all customers whether or not they have an invoice.
SELECT *
FROM customer c
LEFT JOIN invoice i ON c.customer_id = i.customer_id;

# Show customers (first and last name) that picked up (date out) their dry cleaning between September 1, 2019 and September 30, 2019.

SELECT first_name, last_name, date_out
FROM customer
INNER JOIN invoice using(customer_id)
WHERE date_out BETWEEN '2019-09-01' and '2019-09-30';


# Using subqueries only, show the first name and last name of all customers who have had an invoice with an item named Dress Shirt. Present the results sorted by last name in ascending order and then first name in descending order.

SELECT c.first_name, c.last_name
FROM customer c
WHERE c.customer_id IN (
  SELECT i.customer_id
  FROM invoice i
  WHERE i.invoice_id IN (
	SELECT ii.invoice_id
	FROM invoice_item ii
	WHERE ii.item_id IN (
	  SELECT it.item_id
	  FROM item it
	  WHERE it.description = 'Dress Shirt'
	)
  )
)
ORDER BY c.last_name ASC, c.first_name DESC;

# Without entering table IDs except to connect the tables, use subqueries to change Jedidiah Bugbee's quantity of Dress Shirts included on his March 21, 2020 invoice from 6 to 3.

UPDATE invoice_item
SET quantity = 3
WHERE invoice_id = (
  SELECT i.invoice_id
  FROM invoice i 
  where i.customer_id = (
	SELECT c.customer_id
	FROM customer c
	where c.first_name = 'Jedidiah' and c.last_name	= 'Bugbee'
  )
  AND i.date_in = '2020-03-21'
)
AND item_id = (
  SELECT it.item_id
  FROM item it
  WHERE it.description = 'Dress Shirt'
);

# Show customers (first and last name) and their total number of invoices. Give the total column an alias of total_invoices.

SELECT c.first_name, c.last_name, (
  SELECT COUNT(*)
  FROM invoice i
  WHERE i.customer_id = c.customer_id
) as total_invoices
FROM customer c;

# Show customers (first and last name) that have had more than $500 worth of dry cleaning done. Give the total cost an alias of total_dry_cleaning.

SELECT c.first_name, c.last_name, SUM(it.price * ii.quantity) as total_dry_cleaning
from customer c
INNER JOIN invoice i using(customer_id)
INNER JOIN invoice_item ii USING(invoice_id)
INNER JOIN item it using(item_id)
GROUP BY c.customer_id
HAVING total_dry_cleaning > 500;

# Show the invoice id, subtotal (price times quantity), tax (subtotal times 7.5% tax rate), and total (subtotal plus tax) for all invoices where the subtotal is greater than $150. Set column aliases for subtotal, tax, and total. Sort by subtotal in descending order.

SELECT i.invoice_id, sum(it.price*ii.quantity) as subtotal, (sum(it.price*ii.quantity) * .075) as tax,
(sum(it.price*ii.quantity) * 1.075) as total
FROM invoice i
INNER join invoice_item ii using(invoice_id)
INNER JOIN ITEM it using(item_id)
GROUP BY i.invoice_id
Having subtotal > 150
ORDER BY subtotal DESC;

# Create a view called no_invoices. This view should display all information for customers who have no invoices. After creating this view, select from it and show only a list of customer emails.

CREATE VIEW no_invoices AS
SELECT c.*
FROM customer c 
LEFT JOIN invoice i ON c.customer_id = i.customer_id
WHERE i.customer_id is NULL;

SELECT email
FROM no_invoices;

# Create a view called invoice_summary. This view should display the invoice ID, date in, date out, description, quantity, and price. After creating this view, select from it while showing invoice summaries for those containing men's shirts where the date out was on or after October 1, 2019.

CREATE VIEW invoice_summary AS
SELECT i.invoice_id, i.date_in, i.date_out, it.description, 
ii.quantity, it.price
FROM invoice i
INNER JOIN invoice_item ii USING(invoice_id)
INNER JOIN item it USING(item_id);

SELECT *
FROM invoice_summary
WHERE description ='Men\'s Shirt' and date_out >= '';
