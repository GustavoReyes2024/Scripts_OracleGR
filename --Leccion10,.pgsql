SELECT first_name, last_name,
hire_date
FROM employees
WHERE hire_date >
(SELECT hire_date
FROM employees
WHERE last_name = 'Brown');


SELECT last_name
FROM employees
WHERE department_id =
(SELECT department_id
FROM employees
WHERE last_name = 'Smith');

SELECT last_name, id_job, department_id
FROM employees
WHERE department_id =
(SELECT department_id
FROM departments
WHERE department_name = 'Marketing')
ORDER BY id_job DESC;

SELECT last_name, id_job, salary, department_id
FROM employees
WHERE id_job =
(SELECT id_job
FROM employees
WHERE id = 50)
AND department_id =
(SELECT department_id
FROM departments
WHERE location_id = 1200);

SELECT last_name, salary
FROM employees
WHERE salary <
(SELECT AVG(salary)
FROM employees);

SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) >
(SELECT MIN(salary)
FROM employees
WHERE department_id = 50);

SELECT last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) IN
(SELECT EXTRACT(YEAR FROM hire_date)
FROM employees
WHERE department_id=100);

SELECT id,
manager_id,
department_id
FROM employees
WHERE manager_id IN
(SELECT manager_id
FROM employees
WHERE id IN
(149,174))
AND department_id IN
(SELECT department_id
FROM employees
WHERE id IN
(149,174))
AND id NOT IN(149,174);

SELECT id,
manager_id,
department_id
FROM employees
WHERE manager_id IN
(SELECT manager_id
FROM employees
WHERE id IN
(149,174))
AND department_id IN
(SELECT department_id
FROM employees
WHERE id IN
(149,174))
AND id NOT IN(149,174);

SELECT first_name, last_name,
id_job
FROM employees
WHERE id_job =
(SELECT id_job
FROM employees
WHERE last_name = 'Doe');

SELECT o.first_name,o.last_name,
o.salary
FROM employees o
WHERE o.salary >
(SELECT AVG(i.salary)
FROM employees i
WHERE i.department_id =
o.department_id);

SELECT last_name AS "Not a Manager"
FROM employees emp
WHERE NOT EXISTS
(SELECT *
FROM employees mgr
WHERE mgr.manager_id = emp.id);

SELECT last_name AS "Not a Manager"
FROM employees emp
WHERE emp.id NOT IN
(SELECT mgr.manager_id
FROM employees mgr);

WITH managers AS
(SELECT DISTINCT manager_id
FROM employees
WHERE manager_id IS NOT NULL)
SELECT last_name AS "Not a manager"
FROM employees
WHERE id NOT IN
(SELECT *
FROM managers);