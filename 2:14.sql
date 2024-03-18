# DROP TABLE IF EXISTS CUSTOMER, ITEM;
# Problem 1
CREATE TABLE `CUSTOMER` (
  `customer_id` INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `first_name` VARCHAR(25) NOT NULL,
  `last_name` VARCHAR(25) NOT NULL,
  `street` VARCHAR(25) NOT NULL,
  `city` VARCHAR(25) NOT NULL,
  `state` CHAR(2) NOT NULL,
  `zipcode` CHAR(5) NOT NULL,
  `phone` VARCHAR(10) NOT NULL,
  `email` VARCHAR(50)
);

CREATE TABLE `ITEM` (
  `item_id` INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `item_description` VARCHAR(100) NOT NULL
);

CREATE TABLE `EMPLOYEE` (
  `employee_id` INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `first_name` VARCHAR(25) NOT NULL,
  `last_name` VARCHAR(25) NOT NULL,
  `street` VARCHAR(25) NOT NULL,
  `city` VARCHAR(25) NOT NULL,
  `state` CHAR(2) NOT NULL,
  `zipcode` CHAR(5) NOT NULL,
  `hire_date` DATE Not NUll,
  `manager_id` INTEGER,
  CONSTRAINT `employee_fk` FOREIGN KEY (`manager_id`) references `EMPLOYEE`(`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `COMPLAINT` (
  `complaint_id` INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `date` DATE NOT NULL,
  `details` TEXT NOT NULL,
  `customer_id` INTEGER NOT NULL,
  `item_id` INTEGER NOT NULL,
  CONSTRAINT `complaint_fk1` FOREIGN KEY (`customer_id`) references `CUSTOMER`(`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `complaint_fk2` FOREIGN KEY (`item_id`) references `ITEM`(`item_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `INVOICE` (
  `invoice_id` INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `date_in` DATE NOT NULL,
  `date_out`DATE,
  `customer_id` INTEGER NOT NULL,
  `employee_id` INTEGER NOT NULL,
  CONSTRAINT `invoice_fk` FOREIGN KEY (`employee_id`) references `EMPLOYEE`(`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `INVOICE_ITEM` (
  `item_id` INTEGER NOT NULL,
  `invoice_id` INTEGER NOT NULL,
  `quantity` INTEGER NOT NULL,
  PRIMARY KEY (`item_id`,`invoice_id`),
  CONSTRAINT `invoice_item_fk1` FOREIGN KEY (`item_id`) references `ITEM`(`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `invoice_item_fk2` FOREIGN KEY (`invoice_id`) references `INVOICE`(`invoice_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

# Problem 2
ALTER TABLE `ITEM` 
ADD `price` DOUBLE(6,2) NOT NULL,
CHANGE `item_description` `description` TEXT NOT NULL;

#Problem 3
ALTER TABLE `INVOICE`
ADD CONSTRAINT `invoice_fk2` FOREIGN KEY  (`customer_id`) references `CUSTOMER`(`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
DROP FOREIGN KEY `invoice_fk`,
DROP `employee_id`;

# Problem 4
DROP TABLE COMPLAINT;
DROP TABLE EMPLOYEE;