-- Script para crear la tabla 'jobs' y llenarla con datos en PostgreSQL

-- PASO 1: Crear la tabla jobs
CREATE TABLE jobs (
    JOB_ID VARCHAR(10) PRIMARY KEY, -- JOB_ID como clave primaria, VARCHAR para códigos
    JOB_TITLE VARCHAR(50) NOT NULL -- JOB_TITLE para el nombre del puesto, no puede ser nulo
);

-- PASO 2: Llenar la tabla jobs con los datos proporcionados
INSERT INTO jobs (JOB_ID, JOB_TITLE) VALUES
('AD_PRES', 'President'),
('AD_VP', 'Administration Vice President'),
('AD_ASST', 'Administration Assistant'),
('AC_MGR', 'Accounting Manager'),
('AC_ACCOUNT', 'Public Accountant'),
('SA_MAN', 'Sales Manager');

-- Opcional: Para verificar que la tabla se ha creado y llenado correctamente
SELECT JOB_ID, JOB_TITLE FROM jobs;

SELECT first_name, last_name, job_id, job_title
FROM employees NATURAL JOIN jobs
WHERE department_id > 30;

SELECT first_name, last_name, job_id, job_title
FROM employees NATURAL JOIN jobs
WHERE department_id > 20;

SELECT department_name, city
FROM departments NATURAL JOIN
locations;

SELECT last_name, department_name
FROM employees CROSS JOIN
departments;

SELECT first_name, last_name, department_id, department_name
FROM employees JOIN departments USING (department_id);

SELECT first_name, last_name, department_id, department_name
FROM employees JOIN departments USING (department_id)
WHERE last_name = 'Doe';

SELECT e.last_name, j.job_title
FROM employees e
JOIN jobs j ON e.id_job = j.job_id;


SELECT e.last_name, j.job_title
FROM employees e
JOIN jobs j ON (e.id_job = j.job_id);

SELECT e.last_name, j.job_title
FROM employees e
JOIN jobs j ON (e.id_job = j.job_id)
WHERE e.last_name LIKE 'm%';

-- Create the job_grades table
CREATE TABLE job_grades (
    grade_level VARCHAR(1) PRIMARY KEY,
    lowest_sal NUMERIC(10, 2),
    highest_sal NUMERIC(10, 2)
);

-- Insert sample data into job_grades
INSERT INTO job_grades (grade_level, lowest_sal, highest_sal) VALUES
('A', 1000, 2999),
('B', 3000, 5999),
('C', 6000, 9999),
('D', 10000, 15000),
('E', 15001, 20000); -- Added a couple more for demonstration 

SELECT e.last_name, e.salary, jg.grade_level, jg.lowest_sal, jg.highest_sal
FROM employees e
JOIN job_grades jg ON (e.salary BETWEEN jg.lowest_sal AND jg.highest_sal);

SELECT last_name, department_name AS "Department", city
FROM employees JOIN departments USING (department_id)
JOIN locations USING (location_id);

SELECT e.last_name, d.department_id,
d.department_name
FROM employees e LEFT OUTER JOIN
departments d
ON (e.department_id =
d.department_id);

SELECT e.last_name, d.department_id,
d.department_name
FROM employees e LEFT OUTER JOIN
departments d
ON (e.department_id =
d.department_id);


SELECT e.last_name, d.department_id,
d.department_name
FROM employees e RIGHT OUTER JOIN
departments d
ON (e.department_id =
d.department_id);

SELECT e.last_name, d.department_id, d.department_name
FROM employees e FULL OUTER JOIN departments d
ON (e.department_id = d.department_id);

SELECT worker.department_id || ' works for ' || manager.department_name
AS "Works for"
FROM departments worker JOIN departments manager
ON (worker.manager_id = manager.department_id);

SELECT last_name, job_title
FROM employees e JOIN jobs j
ON (e.id_job = j.job_id); -- CORRECTED: changed e.job_id to e.id_job

-- And for the second one if it's a separate query:
SELECT last_name, job_title
FROM employees e JOIN jobs j
ON (e.id_job = j.job_id); -- CORRECTED: changed e.employee_job_id to e.id_job

ALTER TABLE employees
ADD COLUMN manager_id INTEGER;

-- Example UPDATE statements. Replace these with your actual employee and manager IDs.
UPDATE employees SET manager_id = NULL WHERE id = 100; -- Example: Employee 100 is a top-level manager (no manager)
UPDATE employees SET manager_id = 100 WHERE id = 101; -- Example: Employee 101 reports to employee 100
UPDATE employees SET manager_id = 101 WHERE id = 102; -- Example: Employee 102 reports to employee 101


-- This entire block replaces lines 121-125 from your original script that had the Oracle syntax.
WITH RECURSIVE employee_hierarchy AS (
    -- Anchor member: Defines the starting point(s) of the recursion
    SELECT
        e.id AS employee_id,    -- 'id' is the employee ID in your 'employees' table
        e.last_name,
        e.id_job AS job_id,     -- 'id_job' is the job ID in your 'employees' table
        e.manager_id,           -- This column must now exist and be populated
        1 AS level              -- Starting level for the hierarchy (e.g., top-level manager is level 1)
    FROM
        employees e
    WHERE
        e.id = 100 -- Replace '100' with the actual ID of the employee you want to start the hierarchy from
                    -- (e.g., the ID of a top-level manager)

    UNION ALL

    -- Recursive member: Defines how to extend the hierarchy
    -- It finds employees whose manager_id matches an employee_id already found in the hierarchy
    SELECT
        e.id,
        e.last_name,
        e.id_job,
        e.manager_id,
        eh.level + 1
    FROM
        employees e
    JOIN
        employee_hierarchy eh ON e.manager_id = eh.employee_id
)
-- Final SELECT statement to retrieve the results from the recursive CTE
SELECT
    employee_id,
    last_name,
    job_id,
    manager_id,
    level
FROM
    employee_hierarchy;




