SELECT
    SUBSTR(first_name, 1) || ' ' || last_name AS "Employee Name",
    salary AS "Salary",
    CASE
        WHEN commission_pct IS NULL THEN 'No'
        ELSE 'Yes'
    END AS "Commission"
FROM
    employees;


CREATE TABLE copy_employees
AS (SELECT * FROM employees);

CREATE TABLE copy_departments
AS (SELECT * FROM departments);

SELECT * FROM copy_departments;

INSERT INTO copy_departments
(department_id, department_name, manager_id, location_id)
VALUES (200,'Human Resources', 205, 1500);

INSERT INTO copy_departments
VALUES
(210,'Estate Management', 102, 1700);

ALTER TABLE copy_employees
ADD COLUMN phone_number VARCHAR(20)

INSERT INTO copy_employees
(id, first_name, last_name, phone_number,
hire_date,
id_job, salary)
VALUES
(302,'Grigorz','Polanski', '8586667641', '15-Jun-2017',
'IT_PROG',4200);

ALTER TABLE copy_employees
ADD COLUMN email VARCHAR(100);

INSERT INTO copy_employees
(id, first_name, last_name, email, phone_number,
hire_date, id_job, salary)
VALUES
(302,'Grigorz','Polanski', 'gpolanski', '', '15-Jun-2017',
'IT_PROG',4200);

INSERT INTO copy_employees
(id, first_name, last_name, email, phone_number,
 hire_date, id_job, salary)
VALUES
(304, 'Test', 'User', 't_user@example.com', '4159982810', NOW(),
'ST_CLERK', 2500);

SELECT first_name, TO_CHAR(hire_date,'Month, fmdd, yyyy')
FROM employees
WHERE id = 70;

INSERT INTO copy_employees
(id, first_name, last_name, email, phone_number,
hire_date, id_job, salary)
VALUES
(301,'Katie','Hernandez', 'khernandez','8586667641',
TO_DATE('July 8, 2017', 'Month fmdd, yyyy'),
'MK_REP',4200); 

INSERT INTO copy_employees
(id, first_name, last_name, email, phone_number,
hire_date, id_job, salary)
VALUES
(303,'Angelina','Wright', 'awright','4159982010',
TO_DATE('July 10, 2017 17:20', 'Month fmdd, yyyy HH24:MI'),
'MK_REP', 3600); 

SELECT first_name, last_name,
TO_CHAR(hire_date, 'dd-Mon-YYYY HH24:MI') As "Date and Time"
FROM copy_employees
WHERE id = 303;

-- Create the sales_reps table
CREATE TABLE sales_reps AS
SELECT
    id AS id, -- Assuming 'id' in your insert refers to employee_id
    last_name,
    salary,
    commission_pct
FROM
    employees
WHERE
    id_job LIKE '%REP%'; -- This condition selects employees with 'REP' in their job_id


UPDATE copy_employees
SET phone_number = '123456'
WHERE id = 303;

UPDATE copy_employees
SET phone_number = '654321', last_name = 'Jones'
WHERE id >= 303; 

UPDATE copy_employees
SET salary = (SELECT salary
FROM copy_employees
WHERE id = 30)
WHERE id = 20;

UPDATE copy_employees
SET salary = (SELECT salary
FROM copy_employees
WHERE id = 40)
WHERE id = 30;

UPDATE copy_employees
SET salary = (SELECT salary
FROM copy_employees
WHERE id = 20),
id_job = (SELECT id_job
FROM copy_employees
WHERE id = 30)
WHERE id = 40;

UPDATE copy_employees
SET salary = (SELECT salary
FROM employees
WHERE id = 40)
WHERE id = 20;

ALTER TABLE copy_employees
ADD COLUMN department_name VARCHAR(30);

UPDATE copy_employees
SET department_name = 'Default Department';

UPDATE copy_employees ce
SET department_name = d.department_name
FROM departments d
WHERE ce.department_id = d.department_id;

DELETE from copy_employees
WHERE id = 303;

DELETE FROM copy_employees
WHERE department_id =
(SELECT department_id
FROM departments
WHERE department_name = 'Shipping');

DELETE FROM copy_employees
WHERE manager_id IN (
    SELECT manager_id
    FROM copy_employees -- Reference the same table
    GROUP BY manager_id
    HAVING COUNT(department_id) < 2
);

UPDATE employees SET department_id = 15
WHERE id = 100;

DELETE FROM departments WHERE department_id = 10;

SELECT e.id, e.salary, d.department_name
FROM employees e
JOIN departments d USING (department_id)
WHERE id_job = 'ST_CLERK' AND location_id = 1200
ORDER BY e.id
FOR UPDATE;

CREATE TABLE my_employees (
    hire_date DATE DEFAULT NOW(), -- or CURRENT_TIMESTAMP
    first_name VARCHAR(15),
    last_name VARCHAR(15)
);

INSERT INTO my_employees
(hire_date, first_name, last_name)
VALUES
(DEFAULT, 'Angelina','Wright');

INSERT INTO my_employees
(first_name, last_name)
VALUES
('Angelina','Wright');

UPDATE my_employees
SET hire_date = DEFAULT
WHERE last_name = 'Wright';

MERGE INTO copy_employees c USING employees e
ON (c.id = e.id)
WHEN MATCHED THEN UPDATE
SET
last_name = e.last_name,
department_id = e.department_id
WHEN NOT MATCHED THEN INSERT
VALUES (e.id, e.last_name, e.department_id);

INSERT INTO my_employees (hire_date, first_name, last_name)
SELECT hire_date, first_name, last_name
FROM employees;

INSERT INTO copy_employees (hire_date, first_name, last_name)
SELECT hire_date, first_name, last_name
FROM employees;