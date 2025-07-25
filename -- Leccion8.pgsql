ALTER TABLE wf_countries
ADD COLUMN life_expect_at_birth NUMERIC(5,2);


UPDATE wf_countries SET life_expect_at_birth = 72.5 WHERE country_name = 'Honduras';
UPDATE wf_countries SET life_expect_at_birth = 83.1 WHERE country_name = 'Canada';
UPDATE wf_countries SET life_expect_at_birth = 79.0 WHERE country_name = 'Mexico';


SELECT MIN(life_expect_at_birth)
AS "Lowest life exp"
FROM wf_countries;

SELECT MIN(country_name)
FROM wf_countries;

SELECT MIN(hire_date)
FROM employees;

SELECT MAX(life_expect_at_birth)
AS "Highest Life Exp"
FROM wf_countries;

SELECT MAX(country_name)
FROM wf_countries;

SELECT MAX(hire_date)
FROM employees;

ALTER TABLE wf_countries
ADD COLUMN area NUMERIC(15,2);

-- Ejemplos de actualización de la columna 'area'.
-- ¡ADAPTA ESTOS VALORES Y CONDICIONES A TUS DATOS REALES DE PAÍSES!

UPDATE wf_countries SET area = 112492.00 WHERE country_name = 'Honduras'; -- Área de Honduras en km²
UPDATE wf_countries SET area = 9984670.00 WHERE country_name = 'Canada';   -- Área de Canadá en km²
UPDATE wf_countries SET area = 1972550.00 WHERE country_name = 'Mexico';   -- Área de México en km²
UPDATE wf_countries SET area = 9833520.00 WHERE country_name = 'United States'; -- Área de Estados Unidos en km²
-- Añade más sentencias UPDATE para los países que tengas en tu tabla.

ALTER TABLE wf_countries
ADD COLUMN region_id INTEGER;

-- Ejemplos de actualización de la columna 'region_id'.
-- ¡ADAPTA ESTOS VALORES Y CONDICIONES A TUS DATOS REALES DE PAÍSES Y REGIONES!

UPDATE wf_countries SET region_id = 1 WHERE country_name = 'Canada';        -- Ejemplo: Norteamérica
UPDATE wf_countries SET region_id = 1 WHERE country_name = 'United States'; -- Ejemplo: Norteamérica
UPDATE wf_countries SET region_id = 2 WHERE country_name = 'Mexico';        -- Ejemplo: Latinoamérica
UPDATE wf_countries SET region_id = 2 WHERE country_name = 'Honduras';       -- Ejemplo: Latinoamérica
UPDATE wf_countries SET region_id = 3 WHERE country_name = 'Brazil';         -- Ejemplo: Sudamérica (si tienes)
-- Añade más sentencias UPDATE para los países que tengas en tu tabla 'wf_countries'.

-- Esta consulta ahora funcionará directamente si 'area' y 'region_id' están en 'wf_countries'
SELECT SUM(area)
FROM wf_countries
WHERE region_id = 2; 

SELECT SUM(area)
FROM wf_countries

SELECT SUM (salary)
FROM employees
WHERE department_id = 20;

SELECT MAX(salary), MIN(salary), MIN(id)
FROM employees
WHERE department_id = 20;

SELECT COUNT(id)
FROM employees;

SELECT commission_pct
FROM employees;

SELECT COUNT(commission_pct)
FROM employees;

SELECT COUNT(*)
FROM employees
WHERE hire_date < '01-Jan-1996';

SELECT id
FROM employees;

SELECT DISTINCT id
FROM employees;

SELECT SUM(salary)
FROM employees
WHERE department_id = 20;

SELECT SUM(DISTINCT salary)
FROM employees
WHERE department_id = 20;

SELECT COUNT (DISTINCT
id)
FROM employees;

SELECT COUNT (DISTINCT id)
FROM employees;

SELECT AVG(commission_pct)
FROM employees;

SELECT AVG(COALESCE(commission_pct, 0))
FROM employees;

SELECT AVG(commission_pct)
FROM employees;

