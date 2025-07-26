-- Leccion 9

SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
ORDER BY department_id;

SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
ORDER BY department_id;


SELECT MAX(salary)
FROM employees
GROUP BY department_id;


SELECT department_id, MAX(salary)
FROM employees
GROUP BY department_id;

SELECT COUNT(country_name), region_id
FROM wf_countries
GROUP BY region_id
ORDER BY region_id;

SELECT COUNT(*), region_id
FROM wf_countries
GROUP BY region_id
ORDER BY region_id;


SELECT department_id, MAX(salary)
FROM employees
WHERE last_name != 'King'
GROUP BY department_id;

ALTER TABLE wf_countries
ADD COLUMN population INTEGER;

INSERT INTO wf_countries (region_id, country_name, population) VALUES
(4, 'Egypt', 109000000),
(4, 'South Africa', 60000000),
(5, 'Australia', 26000000),
(5, 'New Zealand', 5200000),
(6, 'Sweden', 10500000),
(6, 'Norway', 5500000),
(7, 'India', 1420000000);


SELECT region_id, ROUND(AVG(population)) AS population
FROM wf_countries
GROUP BY region_id
ORDER BY region_id;

ALTER TABLE wf_countries
ADD CONSTRAINT UQ_country_name UNIQUE (country_name);


CREATE TABLE wf_spoken_languages (
    country_name VARCHAR(255) NOT NULL, -- Changed from country_id to country_name
    language_id INTEGER NOT NULL,
    language_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (country_name, language_id), -- Primary key on name and language_id
    FOREIGN KEY (country_name) REFERENCES wf_countries(country_name) -- References country_name
);

SELECT country_name
FROM (VALUES
    ('Honduras'), ('Guatemala'), ('El Salvador'), ('Brazil'), ('Argentina'),
    ('Canada'), ('Mexico'), ('Egypt'), ('South Africa'), ('Australia'),
    ('New Zealand'), ('Sweden'), ('Norway'), ('India')
) AS proposed_countries(country_name)
WHERE NOT EXISTS (
    SELECT 1 FROM wf_countries wc WHERE wc.country_name = proposed_countries.country_name
);


SELECT country_name, COUNT(language_id) AS "Number of
languages"
FROM wf_spoken_languages
GROUP BY country_name;

SELECT department_id,MAX(salary)
FROM employees
GROUP BY department_id
HAVING COUNT(*)>1
ORDER BY department_id;

SELECT department_id, id, SUM(salary)
FROM employees
WHERE department_id < 50
GROUP BY ROLLUP (department_id, id);

SELECT department_id, id, SUM(salary)
FROM employees
WHERE department_id < 50
GROUP BY ROLLUP (department_id, id);

SELECT department_id, id, SUM(salary)
FROM employees
WHERE department_id < 50
GROUP BY (department_id, id);

SELECT department_id, id, SUM(salary)
FROM employees
WHERE department_id < 50
GROUP BY CUBE (department_id, id);

SELECT department_id, id, manager_id, SUM(salary)
FROM employees
WHERE department_id < 50
GROUP BY GROUPING SETS
((id, manager_id),(department_id, id),
(department_id, manager_id));


SELECT department_id, id, SUM(salary),
GROUPING(department_id) AS "Dept sub total",
GROUPING(id) AS "Job sub total"
FROM employees
WHERE department_id < 50
GROUP BY CUBE (department_id, id);


