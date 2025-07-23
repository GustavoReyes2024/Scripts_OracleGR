--Leccion 4

CREATE TABLE DUAL (
    DUMMY VARCHAR(1)
);

INSERT INTO DUAL (DUMMY) VALUES ('X');


SELECT (319/29) + 12
FROM DUAL;

SELECT last_name
FROM employees
WHERE LOWER(last_name) = 'doe';


SELECT last_name
FROM employees
WHERE UPPER(last_name) = 'DOE';

SELECT last_name
FROM employees
WHERE INITCAP(last_name) = 'Doe';

SELECT CONCAT('Hello', 'World')
FROM DUAL;

SELECT CONCAT(first_name, last_name)
FROM employees;

SELECT SUBSTR('HelloWorld',1,5)
FROM DUAL;

SELECT SUBSTR('HelloWorld', 6)
FROM DUAL;

SELECT SUBSTR(last_name,1,3)
FROM employees;

SELECT LENGTH('HelloWorld')
FROM DUAL;

SELECT LENGTH(last_name)
FROM employees;

SELECT STRPOS('HelloWorld', 'W');

SELECT last_name, STRPOS(last_name, 'a')
FROM employees;

SELECT LPAD('HelloWorld',15, '-')
FROM DUAL;

SELECT LPAD(last_name, 10,'*')
FROM employees;

SELECT RPAD('HelloWorld',15, '-')
FROM DUAL;

SELECT RPAD(last_name, 10,'*')
FROM employees;

SELECT TRIM(LEADING 'a' FROM 'abcba')
FROM DUAL;

SELECT TRIM(TRAILING 'a' FROM 'abcba')
FROM DUAL;

SELECT TRIM(BOTH 'a' FROM 'abcba')
FROM DUAL;

SELECT REPLACE('JACK and JUE','J','BL')
FROM DUAL;

SELECT REPLACE(last_name,'a','*')
FROM employees;

SELECT LOWER(last_name)||
LOWER(SUBSTR(first_name,1,1))
AS "User Name"
FROM employees;

SELECT first_name, last_name, salary, department_id
FROM employees
WHERE department_id= 20;

CREATE TABLE wf_countries (
    country_name VARCHAR(100) PRIMARY KEY, -- Assuming country_name is unique and can serve as PK
    airports INT
);

-- Insert sample data into wf_countries
-- The 'airports' column values are chosen so that MOD(airports, 2) matches the "Mod Demo" column in your image.
INSERT INTO wf_countries (country_name, airports) VALUES
('Canada', 7),           -- 7 MOD 2 = 1 (Odd)
('Republic of Costa Rica', 4), -- 4 MOD 2 = 0 (Even)
('Republic of Cape Verde', 3), -- 3 MOD 2 = 1 (Odd)
('Greenland', 2),        -- 2 MOD 2 = 0 (Even)
('Dominican Republic', 6), -- 6 MOD 2 = 0 (Even)
('State of Eritrea', 9);   -- 9 MOD 2 = 1 (Odd)


SELECT country_name, MOD(airports,2)
AS "Mod Demo"
FROM wf_countries;

DROP TABLE IF EXISTS DUAL;

-- Crea la tabla DUAL con la columna DUMMY
CREATE TABLE DUAL (
    DUMMY VARCHAR(1)
);

-- Inserta la fila 'X' en la tabla DUAL
INSERT INTO DUAL (DUMMY) VALUES ('X');

-- Agrega la columna SYSDATE de tipo DATE a la tabla DUAL
ALTER TABLE DUAL
ADD COLUMN SYSDATE DATE;

-- Agrega una nueva columna para la fecha y hora actual
ALTER TABLE DUAL
ADD COLUMN CURRENT_DATETIME TIMESTAMP;

-- Agrega otra columna para una fecha específica
ALTER TABLE DUAL
ADD COLUMN SPECIFIC_DATE DATE;

-- Actualiza la fila existente en DUAL para asignar la fecha actual a las nuevas columnas
-- Usamos CURRENT_DATE para obtener la fecha actual del sistema
-- Usamos NOW() para obtener la fecha y hora actual
UPDATE DUAL
SET
    SYSDATE = CURRENT_DATE,
    CURRENT_DATETIME = NOW(),
    SPECIFIC_DATE = '2025-01-01' -- Ejemplo de una fecha específica
WHERE DUMMY = 'X';


SELECT SYSDATE
FROM DUAL;

SELECT last_name, hire_date + 60
FROM employees;

SELECT last_name, hire_date + 60
FROM employees;