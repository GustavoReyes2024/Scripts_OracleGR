CREATE TABLE DEPARTMENTS (
    DEPARTMENT_ID NUMERIC(4,0) PRIMARY KEY,
    DEPARTMENT_NAME VARCHAR(30),
    MANAGER_ID NUMERIC(6,0),
    LOCATION_ID NUMERIC(4,0)
);


INSERT INTO DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) VALUES
(10, 'Administration', 200, 1700),
(20, 'Marketing', 201, 1800),
(30, 'Purchasing', 202, 1700),
(40, 'Human Resources', 203, 1500),
(50, 'Shipping', 204, 1500);


SELECT department_id ||
department_name
FROM departments;

SELECT department_id ||' '||department_name
FROM departments;

SELECT department_id ||' '||
department_name AS " Department Info "
FROM departments;

SELECT first_name ||' '||
last_name AS "Employee Name"
FROM employees;

SELECT last_name || ' has a monthly
salary of ' || salary || '
dollars.' AS Pay
FROM employees;

SELECT last_name ||' has a '|| 1 ||' year salary of '||
salary*12 || ' dollars.' AS Pay
FROM employees;

SELECT ID
FROM employees;

SELECT ID
FROM employees;

SELECT DISTINCT ID
FROM employees;

SELECT ID, first_name,
last_name
FROM employees;

SELECT ID, first_name,
last_name
FROM employees
WHERE ID = 30;

SELECT first_name, last_name
FROM employees
WHERE last_name = 'doe';

SELECT last_name, salary
FROM employees
WHERE salary <= 3000;

SELECT last_name, salary
FROM employees
WHERE salary BETWEEN 1500 AND 3000;

SELECT city, state_province,
location_id
FROM locations
WHERE location_id IN(1400, 1500);

SELECT city, state_province, location_id
FROM locations
WHERE location_id IN(1600, 1700);


SELECT last_name
FROM employees
WHERE last_name LIKE '_o%';