CREATE DATABASE db;

USE db;

SHOW DATABASES;

SHOW TABLES;

-- DDL (Data Definition Language)
-- create
CREATE TABLE employee(
E_Id INT PRIMARY KEY,
E_name VARCHAR(255),
Dept VARCHAR(30),
Salary INT
);

ALTER TABLE employee
 MODIFY COLUMN Dept CHAR(10) ;

SELECT * FROM employee;

RENAME TABLE employee TO employees;

ALTER TABLE employees RENAME employeeofindia;

ALTER TABLE employeeofIndia RENAME employee;


-- DML Commands (Data Manipulative/Modification Language)



-- insert
INSERT INTO employee (E_id,E_name,Dept,Salary)
VALUES
(1,"Ram","HR",20000),
(2,"Amrit","MRKT",10000),
(3,"Ravi","HR",40000),
(4,"Nitin","MRKT",30000),
(5,"Varun","IT",50000);

 SET SQL_SAFE_UPDATES = 0; -- to disable the safe mode temporarily

-- delete
 
DELETE FROM employee WHERE Salary >= 20000;

-- if where clause is not given in the delete statement the whole table will be deleted 

DELETE FROM employee;
-- this will delete every tuple(row)

-- to handle referential integrity

-- ON DELETE CASCADE

CREATE TABLE Orders (
order_id INT,
emp_id INT,
order_loc VARCHAR(40),
FOREIGN KEY(emp_id) REFERENCES employee(e_id) ON DELETE CASCADE
);
-- ON DELETE NULL - (can FK have null values?)

CREATE TABLE Orders (
order_id INT,
emp_id INT,
order_loc VARCHAR(40),
FOREIGN KEY(emp_id) REFERENCES employee(e_id) ON DELETE SET NULL
);



-- update 
UPDATE employee
SET Salary = 50000 
WHERE Dept = "HR";
-- in the above example salary of HR dept is set to 50000

-- if where clause is not given in the update statement the whole table will be updated
UPDATE employee 
SET Dept = "BUSNS";

-- every dept name will be updated to busns

--  REPLACE
-- Primarily used for already present tuple in a table.
--  As UPDATE, using REPLACE with the help of WHERE clause in PK, then that row will be replaced.
-- As INSERT, if there is no duplicate data new tuple will be inserted.
-- REPLACE INTO student (id, class) VALUES(4, 3);
-- REPLACE INTO table SET col1 = val1, col2 = val2;
-- replace can behave in two ways either it can update the data if the data is present else it can insert the data if it is not present






-- CONSTRAINTS 

-- Different types of constraints are 
-- DEFAULT
-- NOT NULL i.e., you can't keep that column null if not null is assigned to that row 
-- CHECK for checking certain conditions beforing inserting the elements like CHECK acc_bal(bal > 1000) 
-- UNIQUE if this is set then the columns has to be unique no duplicate statements would be allowed 
-- PRIMARY KEY unique identifies the table and is unique and is not null -->> (UNIQUE + NOT NULL) and there is only one primary key in the table. Out of the many candidate keys only 1 primary key is to be selected 
-- FOREIGN KEY is an attribute or set of attributes that  references to the primary key of the same or another table (concept of referential integrity comes into play)

-- we just need to assign most of the above constraints while creating the table and after writing the datatype generally 

-- will create a child table/referencing table that will point to the employee table(parent table/referenced table)

CREATE TABLE Orders (
order_id INT,
emp_id INT,
order_loc VARCHAR(40),
FOREIGN KEY(emp_id) REFERENCES employee(e_id)
);

INSERT INTO Orders (order_id,emp_id,order_loc)
VALUES
(1,1,"Kolkata"),
(2,2,"Bihar"),
(3,3,"UP"),
(4,4,"Gujarat"),
(5,5,"Pune");

SELECT * FROM Orders;

-- view is basically a virtual table which is actually the resultant set of a query it has no values of its own and changes on the actual table can be seen in the view 
-- it is generally used to combine one or more tables without complex subqueries or complex join operations 
-- it also provides security by letting the user to access only a certain part of it 

-- CREATE VIEW view_name AS SELECT columns FROM tables [WHERE conditions];
CREATE VIEW v AS SELECT e_id FROM employee WHERE e_id > 2;

SELECT * FROM v;

-- ALTER VIEW view_name AS SELECT columns FROM table WHERE conditions;

-- DROP VIEW IF EXISTS view_name;
DROP VIEW IF EXISTS v;

-- CREATE VIEW Trainer AS SELECT c.course_name, c.trainer, t.email FROM courses c, contact t WHERE c.id = t.id; (View using Join clause)
CREATE VIEW v_2 AS SELECT e.e_id,e.e_name,e.dept,o.order_id,o.order_loc FROM employee e, orders o WHERE e.e_id = o.emp_id;

SELECT * FROM v_2;