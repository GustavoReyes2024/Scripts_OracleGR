SELECT
    SUBSTR(first_name, 1, 1) || ' ' || last_name AS "Employee Names"
FROM
    employees;


ALTER TABLE employees
ADD COLUMN email VARCHAR(100); 

-- Example for a new employee
INSERT INTO employees (id, first_name, last_name, email, hire_date, id_job, salary)
VALUES (1001, 'John', 'Doe', 'john.doe@example.com', '2023-01-15', 'IT_PROG', 60000);

SELECT
    first_name || ' ' || last_name AS "Employee Name",
    email AS "Email"
FROM
    employees
WHERE
    email LIKE '%john%';

SELECT
    MIN(last_name) AS "First Last Name",
    MAX(last_name) AS "Last Last Name"
FROM
    employees;

SELECT
    TO_CHAR(salary / 52, 'FM$9G999D00') AS "Weekly Salary"
FROM
    employees
WHERE
    (salary / 52) BETWEEN 700 AND 3000;

SELECT
    e.first_name || ' ' || e.last_name AS "Employee Name",
    j.job_title AS "Job"
FROM
    employees e
JOIN
    jobs j ON e.id_job = j.id_job  -- Changed from e.id_job = j.id_job
ORDER BY
    j.job_title;


SELECT
    TO_CHAR(salary / 52, 'FM$9699990.00') AS "Weekly Salary"
FROM
    employees
WHERE
    (salary / 52) BETWEEN 700 AND 3000; -- <<< Agrega este punto y coma aquí

SELECT
    e.first_name || ' ' || e.last_name AS "Employee Name",
    j.job_title AS "Job",
    CONCAT(j.job_title, ' - ', j.job_title) AS salary_range,
    e.salary AS employee_salary
FROM
    employees e
JOIN
    jobs j ON e.id = e.id;


SELECT
    e.first_name AS initials, 
    e.last_name,
    d.department_name
FROM
    employees e
JOIN
    departments d ON e.department_id = d.department_id;

SELECT
    e.first_name || ' ' || e.last_name AS "Employee Name", 
    d.department_name
FROM
    employees e
JOIN
    departments d USING (department_id);


SELECT
    CASE
        WHEN e.manager_id IS NULL THEN 'Nobody'
        ELSE 'Somebody'
    END AS "Works for",
    e.last_name AS "Last Name"
FROM
    employees e;

SELECT
    SUBSTRING(e.first_name, 1, 1) || ' ' || e.last_name AS "Employee Name",
    e.salary AS "Salary",
    CASE
        WHEN e.commission_pct IS NULL THEN 'No'
        ELSE 'Yes'
    END AS "Commission"
FROM
    employees e;

SELECT
    e.last_name,
    d.department_name,
    l.city,
    l.state_province
FROM
    Departments d
LEFT JOIN
    Employees e ON d.department_id = e.department_id
LEFT JOIN
    Locations l ON d.location_id = l.location_id
ORDER BY
    e.last_name NULLS LAST, d.department_name; 

SELECT
    first_name AS "First Name",
    last_name AS "Last Name",
    COALESCE(commission_pct, manager_id, -1) AS "Which function???"
FROM
    employees;


SELECT
    e.last_name,
    e.salary,
    jg.grade_level
FROM
    Employees e
JOIN
    job_grades jg ON e.salary BETWEEN jg.lowest_sal AND jg.highest_sal
WHERE
    e.department_id > 10;

SELECT
    e.last_name,
    d.department_name
FROM
    Employees e
FULL OUTER JOIN
    Departments d ON e.department_id = d.department_id
ORDER BY
    e.last_name NULLS LAST, d.department_name NULLS LAST; 

SELECT
    MIN(hire_date) AS "Lowest",
    MAX(hire_date) AS "Highest",
    COUNT(id) AS "No of Employees"
FROM
    Employees;

SELECT
    d.department_name AS "DEPARTMENT_NAME",
    SUM(e.salary) AS "SALARIES"
FROM
    Employees e
JOIN
    Departments d ON e.department_id = d.department_id
GROUP BY
    d.department_name
HAVING
    SUM(e.salary) BETWEEN 3000 AND 10000
ORDER BY
    "SALARIES";

SELECT
    d.department_name AS "DEPARTMENT_NAME",
    d.manager_id AS "MANAGER_ID", -- Asumo que el manager_id del departamento está en la tabla Departments
    m.last_name AS "MANAGER_NAME", -- Apellido del jefe
    AVG(e.salary) AS "AVG_DEPT_SALARY"
FROM
    Departments d
LEFT JOIN
    Employees e ON d.department_id = e.department_id -- Une departamentos con sus empleados
LEFT JOIN
    Employees m ON d.manager_id = m.id -- Auto-unión para encontrar el nombre del jefe del departamento
GROUP BY
    d.department_name, d.manager_id, m.last_name -- Agrupa por estos campos para que AVG(salary) funcione
ORDER BY
    d.department_name; -- Ordena como en el ejemplo, si no hay un orden específico en la imagen.


SELECT
    ROUND(MAX(avg_salary)) AS "Highest Avg Sal for Depts"
FROM
    (SELECT
        department_id,
        AVG(salary) AS avg_salary
    FROM
        Employees
    GROUP BY
        department_id
    ) AS DepartmentAvgSalaries;


SELECT
    d.department_name AS "Department Name",
    SUM(e.salary) AS "Monthly Cost"
FROM
    Departments d
JOIN
    Employees e ON d.department_id = e.department_id
GROUP BY
    d.department_name
ORDER BY
    d.department_name;

SELECT
    d.department_name AS "Department Name",
    e.id_job AS "Job Title", 
    SUM(e.salary) AS "Monthly Cost"
FROM
    Employees e
JOIN
    Departments d ON e.department_id = d.department_id
GROUP BY GROUPING SETS (
    (d.department_name, e.id_job), 
    (d.department_name),           
    ()                             
)
ORDER BY
    d.department_name NULLS LAST, e.id_job NULLS LAST; 


SELECT
    d.department_name AS "Department Name",
    e.id_job AS "Job Title",
    SUM(e.salary) AS "Monthly Cost"
FROM
    Employees e
JOIN
    Departments d ON e.department_id = d.department_id
GROUP BY CUBE (d.department_name, e.id_job)
ORDER BY
    d.department_name NULLS LAST, e.id_job NULLS LAST;

SELECT
    d.department_name AS "Department Name",
    e.id_job AS "Job Title",
    SUM(e.salary) AS "Monthly Cost",
    CASE WHEN GROUPING(d.department_name) = 0 THEN 'Yes' ELSE 'No' END AS "Department ID Used",
    CASE WHEN GROUPING(e.id_job) = 0 THEN 'Yes' ELSE 'No' END AS "Job ID Used"
FROM
    Employees e
JOIN
    Departments d ON e.department_id = d.department_id
GROUP BY CUBE (d.department_name, e.id_job)
ORDER BY
    d.department_name NULLS LAST, e.id_job NULLS LAST;

SELECT
    d.department_name AS "DEPARTMENT_NAME",
    e.id_job AS "JOB_ID",
    l.city AS "CITY",
    SUM(e.salary) AS "SUM(SALARY)"
FROM
    Employees e
JOIN
    Departments d ON e.department_id = d.department_id
JOIN
    Locations l ON d.location_id = l.location_id
GROUP BY GROUPING SETS (
    (d.department_name, e.id_job), 
    (l.city)                        
)
ORDER BY
    d.department_name NULLS LAST, e.id_job NULLS LAST, l.city NULLS LAST;


SELECT
    e.first_name || ' ' || e.last_name AS "Employee Name",
    e.department_id AS "Department Id",
    CAST(NULL AS VARCHAR(20)) AS "Department Name", -- Se usa NULL para alinear con el resultado esperado
    CAST(NULL AS VARCHAR(20)) AS "City" -- Se usa NULL para alinear con el resultado esperado
FROM
    Employees e

UNION ALL

SELECT
    CAST(NULL AS VARCHAR(40)) AS "Employee Name", -- Se usa NULL para alinear con el resultado esperado
    d.department_id AS "Department Id",
    d.department_name AS "Department Name",
    CAST(NULL AS VARCHAR(20)) AS "City" -- Se usa NULL para alinear con el resultado esperado
FROM
    Departments d

UNION ALL

SELECT
    CAST(NULL AS VARCHAR(40)) AS "Employee Name", -- Se usa NULL para alinear con el resultado esperado
    CAST(NULL AS INT) AS "Department Id", -- Se usa NULL para alinear con el resultado esperado
    CAST(NULL AS VARCHAR(20)) AS "Department Name", -- Se usa NULL para alinear con el resultado esperado
    l.city AS "City"
FROM
    Locations l;


SELECT
    e.first_name || ' ' || e.last_name AS "Employee",
    e.salary AS "Salary",
    d.department_name AS "Department Name"
FROM
    Employees e
JOIN
    Departments d ON e.department_id = d.department_id
WHERE
    e.salary > (SELECT AVG(e2.salary)
                FROM Employees e2
                WHERE e2.department_id = e.department_id);