DROP TABLE IF EXISTS education CASCADE;
CREATE TABLE education (
    education_id serial,
    education_level VARCHAR(100),
    PRIMARY KEY (education_id)
);

DROP TABLE IF EXISTS location CASCADE;
CREATE TABLE location (
    location_id serial,
    location VARCHAR(500),
    address VARCHAR(500),
    city VARCHAR(500),
    state VARCHAR(5),
    PRIMARY KEY (location_id)
);

DROP TABLE IF EXISTS employee CASCADE;
CREATE TABLE employee (
    employee_id VARCHAR(100),
    emp_name VARCHAR(500), 
    emp_email VARCHAR(500),
    hire_date date,
    education_id int,
    PRIMARY KEY (employee_id)
);

DROP TABLE IF EXISTS department CASCADE;
CREATE TABLE department (
    department_id serial,
    department_name VARCHAR(500),
    PRIMARY KEY (department_id)
);

DROP TABLE IF EXISTS job CASCADE;
CREATE TABLE job (
    job_id serial,
    job_title VARCHAR(500),
    PRIMARY KEY (job_id)
); 
 
DROP TABLE IF EXISTS salary CASCADE;
CREATE TABLE salary (
    salary_id SERIAL,
    salary int,
    PRIMARY KEY (salary_id)
);

DROP TABLE IF EXISTS hr CASCADE;
CREATE TABLE hr (
    employee_id VARCHAR(100),
    job_id int,
    location_id int,
    start_date date,
    end_date date,
    department_id int,
    manager_id varchar(100),
    salary_id int,
    PRIMARY KEY (employee_id, job_id)
);

--ADD FOREIGN KEY CONSTRAINT 
ALTER TABLE employee 
ADD CONSTRAINT education_fk FOREIGN KEY (education_id) 
REFERENCES education (education_id)
ON DELETE CASCADE;

ALTER TABLE hr 
ADD CONSTRAINT employee_fk FOREIGN KEY (employee_id) 
REFERENCES employee (employee_id)
ON DELETE CASCADE,
ADD CONSTRAINT job_fk FOREIGN KEY (job_id) 
REFERENCES job (job_id)
ON DELETE CASCADE,
ADD CONSTRAINT manager_fk FOREIGN KEY (manager_id) 
REFERENCES employee (employee_id)
ON DELETE CASCADE,
ADD CONSTRAINT department_fk FOREIGN KEY (department_id) 
REFERENCES department (department_id)
ON DELETE CASCADE,
ADD CONSTRAINT salary_fk FOREIGN KEY (salary_id) 
REFERENCES salary (salary_id)
ON DELETE CASCADE,
ADD CONSTRAINT location_fk FOREIGN KEY (location_id) 
REFERENCES location (location_id)
ON DELETE CASCADE;












