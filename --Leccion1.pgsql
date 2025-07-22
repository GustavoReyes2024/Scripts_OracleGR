CREATE TABLE Countries (
     COUNTRY_ID VARCHAR(2) PRIMARY KEY,
     COUNTRY_NAME VARCHAR(50),
     REGION_ID INT
);

INSERT INTO Countries (COUNTRY_ID, COUNTRY_NAME, REGION_ID) VALUES ('CA', 'Canada', 2);
INSERT INTO Countries (COUNTRY_ID, COUNTRY_NAME, REGION_ID) VALUES ('DE', 'Germany', 1);
INSERT INTO Countries (COUNTRY_ID, COUNTRY_NAME, REGION_ID) VALUES ('UK', 'United Kingdom', 1);
INSERT INTO Countries (COUNTRY_ID, COUNTRY_NAME, REGION_ID) VALUES ('US', 'United States of America', 2);


SELECT *
FROM countries;


SELECT country_id, country_name, region_id
FROM countries;


CREATE TABLE Locations (
     LOCATION_ID INT PRIMARY KEY,
     CITY VARCHAR(50),
     STATE_PROVINCE VARCHAR(50)
);

CREATE TABLE Employees (
     ID INT PRIMARY KEY,
     FIRST_NAME VARCHAR(50),
     LAST_NAME VARCHAR(50),
     SALARY INT,
);

ALTER TABLE Employees
ADD COLUMN id_job VARCHAR(10); -- Se asume VARCHAR(10) para el ID del puesto, ajústalo si es necesario.

-- Agrega la columna hire_date (fecha de contratación)
ALTER TABLE Employees
ADD COLUMN hire_date DATE;

-- Agrega la columna department_id
ALTER TABLE Employees
ADD COLUMN department_id NUMERIC(4,0); -- Coincide con el tipo de datos de DEPARTMENT_ID en la tabla DEPARTMENTS

-- Agrega la restricción de clave foránea para department_id
-- Esto asume que ya tienes una tabla DEPARTMENTS con una clave primaria DEPARTMENT_ID
ALTER TABLE Employees
ADD CONSTRAINT fk_department
FOREIGN KEY (department_id)
REFERENCES DEPARTMENTS (DEPARTMENT_ID);


INSERT INTO Employees (ID, FIRST_NAME, LAST_NAME, SALARY, id_job, hire_date, department_id) VALUES
(50, 'Alice', 'Brown', 4500, 'MK_REP', '2023-11-01', 20),
(60, 'Bob', 'White', 3200, 'PU_CLERK', '2024-02-28', 30),
(70, 'Charlie', 'Green', 5800, 'HR_MGR', '2020-09-01', 40);


INSERT INTO Employees (ID, FIRST_NAME, LAST_NAME, SALARY) VALUES (10, 'John', 'Doe', 4000);
INSERT INTO Employees (ID, FIRST_NAME, LAST_NAME, SALARY) VALUES (20, 'Jane', 'Jones', 3000);
INSERT INTO Employees (ID, FIRST_NAME, LAST_NAME, SALARY) VALUES (30, 'Sylvia', 'Smith', 5000);
INSERT INTO Employees (ID, FIRST_NAME, LAST_NAME, SALARY) VALUES (40, 'Hai', 'Nguyen', 6000);



SELECT salary
FROM employees
WHERE last_name LIKE
'Smith';


SELECT last_name, salary,
salary + 300
FROM employees;


SELECT last_name, salary,
12*salary +100
FROM employees;


SELECT last_name, salary,
12*(salary +100)
FROM employees;