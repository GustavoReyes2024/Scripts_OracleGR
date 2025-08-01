CREATE SEQUENCE runner_id_seq
INCREMENT BY 1
START WITH 1
MAXVALUE 50000
NO CYCLE;

CREATE SEQUENCE runner_id_seq
INCREMENT BY 1
START WITH 1
MAXVALUE 50000
NO CYCLE;

CREATE SEQUENCE departments_seq
INCREMENT BY 1
START WITH 1
NO CYCLE;

INSERT INTO departments (department_id, department_name, location_id)
VALUES (nextval('departments_seq'), 'Support', 2500);

CREATE SEQUENCE employees_seq
INCREMENT BY 1
START WITH 1
NO CYCLE;

INSERT INTO employees (
    id,
    first_name,
    last_name,
    email,
    hire_date,
    id_job,
    salary,
    department_id 
)


VALUES (
    nextval('employees_seq'),
    'Juan',
    'Perez',
    'juan.perez@example.com',
    CURRENT_DATE,
    101,
    50000.00,
    nextval('departments_seq')
);


DROP TABLE IF EXISTS runners;

-- Luego, crea la tabla runners
CREATE TABLE runners (
    runner_id NUMERIC(10) PRIMARY KEY, -- O el tipo de dato que uses para IDs
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
    -- Añade más columnas si tu tabla 'runners' tiene más
);

INSERT INTO runners
(runner_id, first_name, last_name)
VALUES (nextval('runner_id_seq'), 'Joanne', 'Everely');

INSERT INTO runners
(runner_id, first_name, last_name)
VALUES (nextval('runner_id_seq'), 'Adam', 'Curtis');


SELECT runner_id, first_name, last_name
FROM runners;

INSERT INTO runners (runner_id, first_name, last_name)
VALUES (nextval('runner_id_seq'), 'Joanne', 'Everely');

ALTER SEQUENCE runner_id_seq
INCREMENT BY 1
MAXVALUE 999999
NO CYCLE;


CREATE INDEX wf_cont_reg_id_idx
ON wf_countries(region_id);

CREATE INDEX emps_name_idx
ON employees(first_name, last_name);


SELECT
    idx.relname AS index_name,
    a.attname AS column_name,
    (array_position(idx_cls.indkey, a.attnum)) AS column_position,
    idx_cls.indisunique AS uniqueness
FROM
    pg_class t
JOIN
    pg_namespace n ON n.oid = t.relnamespace
JOIN
    pg_index idx_cls ON t.oid = idx_cls.indrelid
JOIN
    pg_class idx ON idx.oid = idx_cls.indexrelid
JOIN
    pg_attribute a ON a.attrelid = t.oid AND a.attnum = ANY(idx_cls.indkey)
WHERE
    t.relkind = 'r'
    AND idx.relkind = 'i'
    AND t.relname = 'employees'
ORDER BY
    index_name, column_position;

CREATE INDEX upper_last_name_idx
ON employees (UPPER(last_name));

SELECT *
FROM employees
WHERE UPPER(last_name) = 'KING';

CREATE INDEX upper_last_name_idx
ON employees (UPPER(last_name));

SELECT *
FROM employees
WHERE UPPER(last_name) LIKE 'KIN%';

SELECT *
FROM employees
WHERE UPPER (last_name) IS NOT NULL
ORDER BY UPPER (last_name);


SELECT first_name, last_name, hire_date
FROM employees
WHERE TO_CHAR(hire_date, 'yyyy') = '1987'

CREATE INDEX emp_hire_year_idx
ON employees (EXTRACT(YEAR FROM hire_date));

DROP INDEX upper_last_name_idx;

DROP INDEX emps_name_idx;

DROP INDEX emp_hire_year_idx;