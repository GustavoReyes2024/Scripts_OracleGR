SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'jobs';

ALTER TABLE jobs
ADD COLUMN min_salary NUMERIC(8, 2),
ADD COLUMN max_salary NUMERIC(8, 2);


INSERT INTO jobs (job_id, job_title, min_salary, max_salary)
VALUES (222, 'New Job', 100, 200)


SELECT last_name, department_name
FROM employees CROSS JOIN departments;

SELECT id, last_name, department_name
FROM employees NATURAL JOIN departments;

SELECT e.id, e.last_name, e.salary, j.grade_level
FROM employees e JOIN job_grades j
ON (e.salary BETWEEN j.lowest_sal AND j.highest_sal);

SELECT id, last_name, department_name
FROM employees JOIN departments
USING (department_id);

SELECT e.id, e.last_name, d.department_id,
d.location_id
FROM employees e JOIN departments d
ON (e.department_id = d.department_id);


SELECT e.id, e.last_name, e.department_id,
d.department_name
FROM employees e RIGHT OUTER JOIN departments d
ON (e.department_id = d.department_id);

SELECT e.id, e.last_name, e.department_id,
d.department_name
FROM employees e LEFT OUTER JOIN departments d
ON (e.department_id = d.department_id);

SELECT e.id, e.last_name, e.department_id,
d.department_name
FROM employees e FULL OUTER JOIN departments d
ON (e.department_id = d.department_id);


SELECT id, first_name, last_name
FROM employees
WHERE (department_id, manager_id) IN (SELECT department_id, manager_id
                                       FROM employees
                                       WHERE id = 50);


SELECT
    e.id,
    e.first_name,
    e.salary,
    e.department_id
FROM
    employees e
WHERE
    e.salary BETWEEN (SELECT j.min_salary
                      FROM jobs j
                      WHERE j.job_title = 'Manager')
    AND (SELECT j2.max_salary
         FROM jobs j2
         WHERE j2.job_title = 'Manager')          
AND
    e.department_id IN (SELECT d.department_id
                        FROM departments d
                        WHERE d.manager_id = 100);   


SELECT
    e.id,
    e.first_name,
    e.department_id,
    e.manager_id AS employee_manager_id 
FROM
    employees e
WHERE
    e.manager_id = (SELECT d.manager_id 
                    FROM departments d
                    WHERE d.department_id = e.department_id); 


INSERT INTO employees (id, first_name)
VALUES (100, 'Gustavo')

INSERT INTO employees 
VALUES (101, 'Alice', 'Smith', 10000);

DELETE FROM EMPLOYEES 
WHERE id = 102;


CREATE TABLE product_orders (
    order_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    quantity INTEGER NOT NULL,
    customer_name VARCHAR(100),
    order_status VARCHAR(50) DEFAULT 'Pending', 
    creation_timestamp TIMESTAMP WITH TIME ZONE DEFAULT NOW()  
);

INSERT INTO product_orders (product_name, quantity, customer_name, creation_timestamp)
VALUES ('Laptop', 1, 'Alice Smith', DEFAULT);


SELECT * FROM product_orders;


CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price NUMERIC(10, 2),
    stock_quantity INT,
    last_updated TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);


CREATE TABLE stg_products (
    product_id INT,
    product_name VARCHAR(100),
    price NUMERIC(10, 2),
    stock_quantity INT
);


INSERT INTO products (product_id, product_name, price, stock_quantity) VALUES
(1, 'Laptop Basic', 800.00, 50),
(2, 'Mouse Wireless', 25.00, 200),
(3, 'Keyboard Mechanical', 75.00, 100);

INSERT INTO stg_products (product_id, product_name, price, stock_quantity) VALUES
(1, 'Laptop Basic', 820.00, 45),    
(4, 'Monitor 27"', 299.99, 75),  
(2, 'Mouse Wireless', 25.00, 210), 
(5, 'Webcam HD', 50.00, 150);    

INSERT INTO products AS p_target (product_id, product_name, price, stock_quantity)
SELECT
    sp.product_id,
    sp.product_name,
    sp.price,
    sp.stock_quantity
FROM
    stg_products AS sp
ON CONFLICT (product_id) DO UPDATE
SET
    product_name = EXCLUDED.product_name,
    price = EXCLUDED.price,
    stock_quantity = EXCLUDED.stock_quantity,
    last_updated = NOW(); 


SELECT * FROM products ORDER BY product_id;


CREATE TABLE users (
    user_id SERIAL PRIMARY KEY, -- Auto-incrementing ID, also primary key
    username VARCHAR(50) NOT NULL UNIQUE, -- Must have a username, must be unique
    email VARCHAR(100) NOT NULL UNIQUE,   -- Must have an email, must be unique
    password_hash VARCHAR(255) NOT NULL,
    registration_date TIMESTAMP WITH TIME ZONE DEFAULT NOW(), -- Defaults to current timestamp
    last_login_date TIMESTAMP WITH TIME ZONE, -- Can be NULL, no default
    is_active BOOLEAN DEFAULT TRUE, -- Defaults to true
    user_role VARCHAR(20) DEFAULT 'Standard' -- Defaults to 'Standard'
);

CREATE TABLE hr_view_active_employees AS
SELECT
    e.id,
    e.first_name,
    e.last_name,
    e.email,
    e.hire_date,
    d.department_name
FROM
    employees e
JOIN
    departments d ON e.department_id = d.department_id
WHERE
    e.hire_date IS NOT NULL; 

ALTER TABLE users 
ADD COLUMN profile_picture_url VARCHAR(255);

ALTER TABLE users
ALTER COLUMN profile_picture_url TYPE VARCHAR(30);

ALTER TABLE users DROP COLUMN profile_picture_url;

DROP TABLE hr_view_active_employees;


CREATE TABLE projects (
    project_id SERIAL CONSTRAINT pk_projects PRIMARY KEY,
    project_name VARCHAR(255) CONSTRAINT uk_project_name UNIQUE, 
    start_date DATE NOT NULL, 
    end_date DATE,
    budget NUMERIC(15, 2) CONSTRAINT ck_project_budget CHECK (budget >= 0) 
);


CREATE TABLE project_tasks (
    task_id SERIAL CONSTRAINT pk_project_tasks PRIMARY KEY, 
    task_name VARCHAR(255) CONSTRAINT nn_task_name NOT NULL, 
    task_code VARCHAR(10) CONSTRAINT uk_task_code UNIQUE, 
    priority_level INTEGER CONSTRAINT ck_priority_level CHECK (priority_level >= 1 AND priority_level <= 5), 
    project_id INTEGER CONSTRAINT fk_project_tasks_projects REFERENCES projects (project_id) 
);

CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    student_email VARCHAR(100) UNIQUE
);

CREATE TABLE courses (
    course_code VARCHAR(10) PRIMARY KEY,
    course_title VARCHAR(255) NOT NULL,
    credits INTEGER CHECK (credits >= 1 AND credits <= 6)
);


CREATE TABLE enrollments (
    student_id INTEGER NOT NULL,
    course_code VARCHAR(10) NOT NULL,
    enrollment_date DATE DEFAULT CURRENT_DATE,
    grade VARCHAR(2), 

    CONSTRAINT pk_enrollments PRIMARY KEY (student_id, course_code),

    CONSTRAINT ck_enrollment_grade CHECK (grade IN ('A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D', 'F', NULL)),

    CONSTRAINT fk_enrollments_student FOREIGN KEY (student_id) REFERENCES students (student_id),

    CONSTRAINT fk_enrollments_course FOREIGN KEY (course_code) REFERENCES courses (course_code)
);


CREATE VIEW employee_salaries_by_department AS
SELECT
    e.first_name,
    e.last_name,
    e.salary,
    d.department_name
FROM
    employees e
JOIN
    departments d ON e.department_id = d.department_id
WHERE
    e.salary > 500;


SELECT * FROM employee_salaries_by_department;

DROP VIEW employee_salaries_by_department;

SELECT
    id,
    first_name,
    last_name,
    salary
FROM
    employees
ORDER BY
    salary DESC 
LIMIT 5; 


CREATE SEQUENCE order_id_seq
    AS INTEGER               
    INCREMENT BY 1            
    START WITH 1000           
    MAXVALUE 999999           
    MINVALUE 1000             
    NO CYCLE                  
    CACHE 50;                 



SELECT nextval('order_id_seq'); 

CREATE TABLE customer_orders (
    order_id INTEGER PRIMARY KEY,
    customer_name VARCHAR(100),
    order_date DATE DEFAULT CURRENT_DATE
);

INSERT INTO customer_orders (order_id, customer_name)
VALUES (nextval('order_id_seq'), 'Alice Smith');

INSERT INTO customer_orders (order_id, customer_name)
VALUES (nextval('order_id_seq'), 'Bob Johnson');

SELECT currval('order_id_seq');

SELECT * FROM customer_orders;

DROP SEQUENCE order_id_seq;

CREATE INDEX idx_employees_last_name
ON employees (last_name);

CREATE UNIQUE INDEX idx_employees_email_unique
ON employees (email);

CREATE INDEX idx_employees_dept_salary
ON employees (department_id, salary DESC);

DROP INDEX idx_employees_dept_salary;


-- Creación de la tabla empleados si no existe
CREATE TABLE IF NOT EXISTS empleados (
    empleado_id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    correo_electronico VARCHAR(100) UNIQUE,
    fecha_contratacion DATE DEFAULT CURRENT_DATE,
    salario NUMERIC(10, 2),
    departamento_id INTEGER
);


CREATE TABLE IF NOT EXISTS departamentos (
    departamento_id SERIAL PRIMARY KEY,
    nombre_departamento VARCHAR(100) NOT NULL UNIQUE
);


INSERT INTO departamentos (nombre_departamento) VALUES
('Recursos Humanos'),
('Ingeniería'),
('Ventas');

INSERT INTO empleados (nombre, apellido, correo_electronico, salario, departamento_id) VALUES
('Juan', 'Perez', 'juan.perez@ejemplo.com', 50000.00, 1),
('Maria', 'Gomez', 'maria.gomez@ejemplo.com', 60000.00, 2),
('Carlos', 'Lopez', 'carlos.lopez@ejemplo.com', 45000.00, 1),
('Ana', 'Diaz', 'ana.diaz@ejemplo.com', 75000.00, 2),
('Luis', 'Martinez', 'luis.martinez@ejemplo.com', 55000.00, 3);

CREATE OR REPLACE VIEW vista_empleados_basica AS
SELECT
    e.nombre AS nombre_empleado,         
    e.apellido AS apellido_empleado,
    d.nombre_departamento AS departamento
FROM
    empleados AS e
JOIN
    departamentos AS d ON e.departamento_id = d.departamento_id;

SELECT * FROM vista_empleados_basica;

CREATE ROLE administrador_db LOGIN PASSWORD 'UnaContrasenaSegura123!' CREATEDB CREATEROLE;

CREATE ROLE gerentes_ventas NOINHERIT;


GRANT SELECT ON empleados TO gerentes_ventas;

CREATE ROLE auditor_salarios LOGIN PASSWORD 'AuditorSeguro!';

GRANT SELECT (nombre, apellido, salario)
ON empleados
TO gerentes_ventas;

GRANT SELECT (salario)
ON empleados
TO auditor_salarios
WITH GRANT OPTION;

GRANT SELECT
ON departamentos
TO PUBLIC;

GRANT INSERT (nombre, apellido, correo_electronico),
      UPDATE (nombre, apellido, correo_electronico)
ON empleados
TO gerentes_ventas;

REVOKE SELECT (salario)
ON empleados
FROM gerentes_ventas;


REVOKE SELECT (salario)
ON empleados
FROM auditor_salarios;


REVOKE SELECT
ON departamentos
FROM PUBLIC;

REVOKE INSERT (nombre, apellido, correo_electronico),
       UPDATE (nombre, apellido, correo_electronico)
ON empleados
FROM gerentes_ventas;

