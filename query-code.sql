DROP TABLE IF EXISTS certificate, employee, course;

create table `employee` (
  `employee_id` INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(500) NOT NULL DEFAULT 'John Doe',
  `birth_date` DATE NOT NULL
);

create table `course` (
  `course_id` INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `title` VARCHAR(150) NOT NULL,
  `description` TEXT
);

create table certificate (
  employee_id INTEGER NOT NULL,
  course_id INTEGER NOT NULL,
  completed DATETIME DEFAULT NOW(),
  PRIMARY KEY (employee_id, course_id),
  CONSTRAINT `certificate_fk1` FOREIGN KEY (employee_id) references employee(employee_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `certificate_fk2` FOREIGN KEY (course_id) references course(course_id) ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE `employee` 
ADD `last_name` varchar(100) NOT NULL, 
CHANGE `name` `first_name` varchar(100) NOT NULL,
ADD `salary` double(10,2) NOT NULL,
DROP `birth_date`;

ALTER TABLE `certificate`
DROP FOREIGN KEY `certificate_fk1`;

ALTER TABLE `certificate`
ADD CONSTRAINT `certificate_fk1` FOREIGN KEY (employee_id) references employee(employee_id) ON DELETE CASCADE ON UPDATE CASCADE;
