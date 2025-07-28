DROP TABLE IF EXISTS clients;

CREATE TABLE clients
(client_number NUMERIC(4),
first_name VARCHAR(14),
last_name VARCHAR(13));


DROP TABLE IF EXISTS clients;

CREATE TABLE clients
(client_number NUMERIC(4) CONSTRAINT clients_client_num_pk
PRIMARY KEY,
first_name VARCHAR(14),
last_name VARCHAR(13));

DROP TABLE IF EXISTS clients;

CREATE TABLE clients
(client_number NUMERIC(4) CONSTRAINT clients_client_num_pk
PRIMARY KEY,
first_name VARCHAR(14),
last_name VARCHAR(13));

DROP TABLE IF EXISTS clients;

CREATE TABLE clients
(client_number NUMERIC(4) CONSTRAINT clients_client_num_pk PRIMARY KEY,
last_name VARCHAR(13) CONSTRAINT clients_last_name_nn NOT NULL,
email VARCHAR(80) CONSTRAINT clients_email_uk UNIQUE);

DROP TABLE IF EXISTS clients;

CREATE TABLE clients
(client_number NUMERIC(4) CONSTRAINT clients_client_num_pk PRIMARY KEY,
last_name VARCHAR(13) NOT NULL,
email VARCHAR(80));


DROP TABLE IF EXISTS clients;

CREATE TABLE clients
(client_number NUMERIC(4) CONSTRAINT clients_client_num_pk PRIMARY KEY,
last_name VARCHAR(13) NOT NULL,
email VARCHAR(80));

DROP TABLE IF EXISTS clients;

CREATE TABLE clients (
client_number NUMERIC(6) NOT NULL,
first_name VARCHAR(20),
last_name VARCHAR(20),
phone VARCHAR(20),
email VARCHAR(10) NOT NULL,
CONSTRAINT clients_phone_email_uk UNIQUE (email,phone));

DROP TABLE IF EXISTS clients;

CREATE TABLE clients (
    client_number NUMERIC(6),
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    phone VARCHAR(20), -- La definición de la columna 'phone' termina aquí
    email VARCHAR(10) CONSTRAINT clients_email_nn NOT NULL, -- Restricción NOT NULL en línea (correcta)

    CONSTRAINT clients_client_num_pk PRIMARY KEY (client_number),
    CONSTRAINT phone_email_uk UNIQUE (email, phone), 
    CONSTRAINT emailclients_email UNIQUE (email) 
);


DROP TABLE IF EXISTS clients;

CREATE TABLE clients
(client_number NUMERIC(4) CONSTRAINT clients_client_num_pk
PRIMARY KEY,
first_name VARCHAR(14),
last_name VARCHAR(13));


DROP TABLE IF EXISTS clients;

CREATE TABLE clients
(client_number NUMERIC(4),
first_name VARCHAR(14),
last_name VARCHAR(13),
CONSTRAINT clients_client_num_pk PRIMARY KEY
(client_number));

CREATE TABLE copy_job_history
(employee_id NUMERIC(6,0),
start_date DATE,
job_id VARCHAR(10),
department_id NUMERIC(4,0),
CONSTRAINT copy_jhist_id_st_date_pk PRIMARY KEY(employee_id,
start_date));

CREATE TABLE copy_employees
(employee_id NUMERIC(6,0) CONSTRAINT copy_emp_pk PRIMARY KEY,
first_name VARCHAR(20),
last_name VARCHAR(25),
department_id NUMERIC(4,0) CONSTRAINT c_emps_dept_id_fk
REFERENCES departments(department_id),
email VARCHAR(25));

DROP TABLE IF EXISTS copy_employees;

CREATE TABLE copy_employees (
    employee_id NUMERIC(6,0) CONSTRAINT copy_emp_pk PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(25),
    department_id NUMERIC(4,0) CONSTRAINT c_emps_dept_id_fk REFERENCES departments(department_id),
    email VARCHAR(25)
);

DROP TABLE IF EXISTS copy_employees;

CREATE TABLE copy_employees
(employee_id NUMERIC(6,0) CONSTRAINT copy_emp_pk PRIMARY KEY,
first_name VARCHAR(20),
last_name VARCHAR(25),
department_id NUMERIC(4,0),
email VARCHAR(25),
CONSTRAINT c_emps_dept_id_fk FOREIGN KEY (department_id)
REFERENCES departments(department_id));

DROP TABLE IF EXISTS copy_employees;

CREATE TABLE copy_employees
(employee_id NUMERIC(6,0) CONSTRAINT copy_emp_pk PRIMARY KEY,
first_name VARCHAR(20),
last_name VARCHAR(25),
department_id NUMERIC(4,0),
email VARCHAR(25),
CONSTRAINT cdept_dept_id_fk FOREIGN KEY (department_id)
REFERENCES copy_departments(department_id) ON DELETE CASCADE);

DROP TABLE IF EXISTS copy_job_history;

CREATE TABLE copy_job_history
(employee_id NUMERIC(6,0),
start_date DATE,
end_date DATE,
job_id VARCHAR(10),
department_id NUMERIC(4,0),
CONSTRAINT cjhist_emp_id_st_date_pk
PRIMARY KEY(employee_id, start_date),
CONSTRAINT cjhist_end_ck CHECK (end_date > start_date));

ALTER TABLE employees
ADD CONSTRAINT emp_dept_fk FOREIGN KEY (department_id)
REFERENCES departments (department_id) ON DELETE CASCADE;

ALTER TABLE clients ALTER COLUMN last_name SET NOT NULL;

ALTER TABLE employees
ALTER COLUMN email SET NOT NULL;

