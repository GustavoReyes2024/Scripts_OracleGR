SELECT employees.last_name, departments.department_name
FROM employees, departments
WHERE employees.department_id = departments.department_id;


SELECT last_name, job_id, job_title
FROM employees, jobs j
WHERE job_id = j.job_id
AND department_id = 40;

SELECT employees.last_name, departments.department_name
FROM employees, departments;

SELECT last_name, job_title
FROM employees e JOIN jobs j
ON (e.id_job = j.job_id); 

SELECT e.last_name, e.id_job AS "Job", jh.job_id AS "Old Job ID", jh.end_date AS "Old end_date"
FROM employees e LEFT OUTER JOIN job_history jh
ON (e.id = jh.employee_id); -- Corrected e.employee_id to e.id based on your schema

SELECT employees.last_name, employees.id_job, jobs.job_id, jobs.job_title
FROM employees, jobs
WHERE employees.id_job = jobs.job_id 

SELECT last_name, city
FROM employees e, departments d,
locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id;

SELECT last_name, salary, grade_level, lowest_sal,
highest_sal
FROM employees, job_grades
WHERE (salary BETWEEN lowest_sal AND highest_sal);



