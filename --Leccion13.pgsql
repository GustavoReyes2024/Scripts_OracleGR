CREATE TABLE my_cd_collection (
    cd_number INT,
    title VARCHAR(20),
    artist VARCHAR(20),
    purchase_date DATE DEFAULT CURRENT_DATE
);


CREATE TABLE my_friends (
    first_name VARCHAR(20),
    last_name VARCHAR(30),
    email VARCHAR(30),
    phone_num VARCHAR(12),
    birth_date DATE
);


CREATE TABLE emp_load (
    employee_number VARCHAR(5), -- Use VARCHAR for variable length or CHAR(5) for fixed length
    employee_dob DATE,         -- For dates
    employee_last_name VARCHAR(20),
    employee_first_name VARCHAR(15),
    employee_middle_name VARCHAR(15),
    employee_hire_date DATE
);

CREATE TABLE temp_emp_load (
    employee_number VARCHAR(5),
    employee_dob_text VARCHAR(10), -- Store as text initially
    employee_last_name VARCHAR(20),
    employee_first_name VARCHAR(15),
    employee_middle_name VARCHAR(15),
    employee_hire_date_text VARCHAR(10) -- Store as text initially
);


CREATE TABLE time_ex1
(exact_time TIMESTAMP);

INSERT INTO time_ex1
VALUES ('10-Jun-2017 10:52:29.123456');

INSERT INTO time_ex1
VALUES (NOW());

INSERT INTO time_ex1
VALUES (CURRENT_TIMESTAMP);

SELECT *
FROM time_ex1;

CREATE TABLE time_ex2
(time_with_offset TIMESTAMP WITH TIME ZONE);

INSERT INTO time_ex2
VALUES (now());

INSERT INTO time_ex2
VALUES ('10-Jun-2017 10:52:29.123456 AM +2:00');

SELECT *
FROM time_ex2;

CREATE TABLE time_ex3
(
    first_column TIMESTAMP WITH TIME ZONE,
    second_column TIMESTAMP WITH TIME ZONE -- Corrected from TIMESTAMP WITH LOCAL TIME ZONE
);

INSERT INTO time_ex3
(first_column, second_column)
VALUES
('15-Jul-2017 08:00:00 AM -07:00', '15-Nov-2007 08:00:00');

SELECT *
FROM time_ex3;

CREATE TABLE time_ex4
(
    loan_duration1 INTERVAL, 
    loan_duration2 INTERVAL  
);


INSERT INTO time_ex4 (loan_duration1, loan_duration2)
VALUES (INTERVAL '120 months',
        INTERVAL '3 years 6 months');

SELECT CURRENT_DATE + loan_duration1 AS "120 months from now",
CURRENT_DATE + loan_duration2 AS "3 years 6 months from
now"
FROM time_ex4;


CREATE TABLE time_ex5
(
    day_duration1 INTERVAL, -- Corrected from INTERVAL DAY "3" TO SECOND
    day_duration2 INTERVAL  -- Corrected from INTERVAL DAY "3" TO SECOND
);

SELECT NOW() + day_duration1 AS "25 Days from now",
TO_CHAR(NOW() + day_duration2, 'dd-Mon-yyyy hh:mi:ss')
AS "precise days and time from now"
FROM time_ex5;

ALTER TABLE my_cd_collection
ADD COLUMN release_date DATE DEFAULT CURRENT_DATE;

ALTER TABLE my_friends
ADD favorite_game VARCHAR(30);


CREATE TABLE mod_emp
(last_name VARCHAR(20),
salary NUMERIC(8,2));

ALTER TABLE mod_emp
ALTER COLUMN last_name TYPE VARCHAR(30);

ALTER TABLE mod_emp
ALTER COLUMN last_name TYPE VARCHAR(10);

ALTER TABLE mod_emp
ALTER COLUMN salary TYPE NUMERIC(10,2);

ALTER TABLE mod_emp
ALTER COLUMN salary SET DEFAULT 50;

ALTER TABLE mod_emp
ALTER COLUMN last_name TYPE VARCHAR(10);

ALTER TABLE mod_emp
ALTER COLUMN last_name TYPE VARCHAR(30);

ALTER TABLE mod_emp
ALTER COLUMN salary TYPE NUMERIC(10,2);

ALTER TABLE mod_emp
ALTER COLUMN salary SET DEFAULT 50;

ALTER TABLE my_cd_collection
DROP COLUMN release_date;

ALTER TABLE my_friends
DROP COLUMN favorite_game;

ALTER TABLE copy_employees
DROP COLUMN email;

DROP TABLE copy_employees;

RENAME my_cd_collection TO my_music;

ALTER TABLE my_cd_collection
RENAME TO my_music;


COMMENT ON TABLE my_music
IS 'Table containing my music CD collection';

COMMENT ON TABLE employees
IS 'Western Region only';

SELECT
    id,
    first_name || ' ' || last_name AS "OPERATION", -- No 'versions_operation AS' needed here, just the alias
    -- versions_starttime AS "START_DATE",           -- These columns don't exist in a standard 'employees' table without a temporal design
    -- versions_endtime AS "END_DATE",
    salary
FROM employees
WHERE id = 20;



