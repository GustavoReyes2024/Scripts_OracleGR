-- Leccion 5

SELECT TO_CHAR(hire_date, 'Month dd, YYYY')
FROM employees;

SELECT TO_CHAR(hire_date, 'fmMonth dd, YYYY')
FROM employees;

SELECT TO_CHAR(hire_date, 'fmMonth ddth, YYYY')
FROM employees;

SELECT TO_CHAR(hire_date, 'fmDay ddth Mon, YYYY')
FROM employees;

SELECT TO_CHAR(hire_date, 'fmDay ddthsp Mon, YYYY')
FROM employees;

SELECT TO_CHAR(hire_date, 'fmDay, ddthsp "of" Month, Year')
FROM employees;

SELECT TO_CHAR(SYSDATE, 'hh:mm')
FROM dual;

SELECT TO_CHAR(SYSDATE, 'hh:mm pm')
FROM dual;

SELECT TO_CHAR(SYSDATE, 'hh:mm:ss pm')
FROM dual;

SELECT TO_CHAR(salary,
'$99,999') AS "Salary"
FROM employees;

SELECT TO_CHAR(3000, '$99999.99')
FROM dual;

SELECT TO_CHAR(4500, '99,999')
FROM dual;

SELECT TO_CHAR(9000, '99,999.99')
FROM dual;

SELECT TO_CHAR(4422, '0,009,999')
FROM dual;

SELECT TO_NUMBER('5,320', '9,999')
AS "Number"
FROM dual;

SELECT TO_DATE('May10,1989', 'fxMonDD,YYYY')
AS "Convert"
FROM DUAL;

SELECT TO_DATE('Sep 07, 1965', 'fxMon dd, YYYY') AS "Date"
FROM dual;

SELECT TO_DATE('July312004', 'fxMonthDDYYYY') AS "Date"
FROM DUAL;

SELECT TO_DATE('June 19, 1990','fxMonth dd, YYYY') AS "Date"
FROM DUAL;

SELECT TO_DATE('27-Oct-95','DD-Mon-YY')
AS "Date"
FROM dual;

SELECT TO_DATE('27-Oct-95','DD-Mon-RR')
AS "Date"
FROM dual;

SELECT last_name, TO_CHAR(hire_date, 'DD-Mon-YY')
FROM employees
WHERE hire_date < TO_DATE('01-Jan-90','DD-Mon-YY');

SELECT
    TO_CHAR(
        CASE
            WHEN EXTRACT(DOW FROM (hire_date + INTERVAL '6 months')) = 5 -- Si ya es viernes
            THEN (hire_date + INTERVAL '6 months')
            ELSE (hire_date + INTERVAL '6 months') + (5 - EXTRACT(DOW FROM (hire_date + INTERVAL '6 months')) + 7) % 7 * INTERVAL '1 day'
        END,
        'Day, Month DD, YYYY' -- Formato de fecha para PostgreSQL
    ) AS "Next Evaluation"
FROM
    employees
WHERE
    employee_id = 10;


SELECT country_name, COALESCE(internet_extension, 'None')
AS "Internet extn"
FROM wf_countries
WHERE location = 'Southern Africa'
ORDER BY internet_extension DESC;

-- 1. Add the internet_extension column to the wf_countries table
ALTER TABLE wf_countries
ADD COLUMN internet_extension VARCHAR(50); -- You can adjust the VARCHAR size as needed

UPDATE wf_countries
SET internet_extension = '.us'
WHERE country_name = 'United States';

UPDATE wf_countries
SET internet_extension = '.ca'
WHERE country_name = 'Canada';

UPDATE wf_countries
SET internet_extension = '.mx'
WHERE country_name = 'Mexico';

UPDATE wf_countries
SET internet_extension = '.uk'
WHERE country_name = 'United Kingdom';

UPDATE wf_countries
SET internet_extension = '.de'
WHERE country_name = 'Germany';

UPDATE wf_countries
SET internet_extension = '.fr'
WHERE country_name = 'France';

UPDATE wf_countries
SET internet_extension = '.au'
WHERE country_name = 'Australia';

UPDATE wf_countries
SET internet_extension = '.jp'
WHERE country_name = 'Japan';

UPDATE wf_countries
SET internet_extension = '.br'
WHERE country_name = '.br'; -- Corrected from 'Brazil' to '.br'

UPDATE wf_countries
SET internet_extension = '.in'
WHERE country_name = 'India';

-- Script para crear la columna 'commission_pct' en la tabla 'employees'

ALTER TABLE employees
ADD COLUMN commission_pct NUMERIC(4,2);

UPDATE employees
SET commission_pct = ROUND((RANDOM() * 0.30)::NUMERIC, 2);

SELECT last_name, COALESCE(commission_pct, 0)
FROM employees
WHERE department_id IN(20,40);


ALTER TABLE wf_countries
ADD COLUMN date_of_independence DATE;

UPDATE wf_countries
SET date_of_independence = '1776-07-04'
WHERE country_name = 'United States';

UPDATE wf_countries
SET date_of_independence = '1867-07-01'
WHERE country_name = 'Canada';

UPDATE wf_countries
SET date_of_independence = '1810-09-16'
WHERE country_name = 'Mexico';

UPDATE wf_countries
SET date_of_independence = '1947-08-15'
WHERE country_name = 'India';

UPDATE wf_countries
SET date_of_independence = '1822-09-07'
WHERE country_name = 'Brazil';

UPDATE wf_countries
SET date_of_independence = '1902-05-20'
WHERE country_name = 'Cuba';

UPDATE wf_countries
SET date_of_independence = (
    '1900-01-01'::DATE + (RANDOM() * 365 * 100)::INT * INTERVAL '1 day'
)
WHERE date_of_independence IS NULL;


SELECT COALESCE(date_of_independence::VARCHAR, 'No date')
FROM wf_countries;

SELECT last_name,
COALESCE(commission_pct, 0)*250
AS "Commission"
FROM employees
WHERE department_id IN(20,40);

SELECT last_name, salary,
COALESCE(commission_pct, salary + (salary * commission_pct),
salary)
AS income
FROM employees
WHERE department_id IN(30,20);


SELECT first_name, LENGTH(first_name) AS "Length FN", last_name,
LENGTH(last_name) AS "Length LN", NULLIF(LENGTH(first_name),
LENGTH(last_name)) AS "Compare Them"
FROM employees;

SELECT last_name,
COALESCE(commission_pct, salary, 10)
AS "Comm"
FROM employees
ORDER BY commission_pct;

SELECT last_name,
CASE department_id
WHEN 20 THEN 'Management'
WHEN 30 THEN 'Sales'
WHEN 40 THEN 'IT'
ELSE 'Other dept.'
END AS "Department"
FROM employees;

