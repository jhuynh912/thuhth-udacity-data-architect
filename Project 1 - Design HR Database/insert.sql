--(Emp_ID, Emp_NM, email, hire_dt, job_title, salary, department_nm, manager, start_dt, end_dt, location, address, city, state, education_lvl)

INSERT INTO education (education_level)
SELECT distinct education_lvl
FROM proj_stg;

INSERT INTO location (location, address, city, state)
SELECT distinct location, address, city, state
FROM proj_stg;

INSERT INTO employee (employee_id, emp_name, emp_email, hire_date, education_id)
SELECT distinct Emp_ID, Emp_NM, email, hire_dt, e.education_id
FROM proj_stg
LEFT JOIN education e
ON proj_stg.education_lvl = e.education_level;

INSERT INTO department (department_name)
SELECT distinct department_nm
FROM proj_stg;

INSERT INTO job (job_title)
SELECT distinct job_title
FROM proj_stg;

INSERT INTO salary (salary)
SELECT distinct salary
FROM proj_stg;

INSERT INTO hr (employee_id, job_id, location_id, start_date, end_date, department_id, manager_id, salary_id) 
SELECT distinct Emp_ID, j.job_id, l.location_id, start_dt
, end_dt, department_id, e.employee_id, salary.salary_id
FROM proj_stg s
LEFT JOIN job j 
ON s.job_title = j.job_title 
LEFT JOIN location l 
ON s.LOCATION  = l.location and s.ADDRESS = l.address
LEFT JOIN employee e 
ON s.MANAGER = e.emp_name
LEFT JOIN department d 
ON s.department_nm = d.department_name
LEFT JOIN salary  
ON s.SALARY = salary.salary;


--CHECK COUNT(*)
SELECT 'department' as tb_name , COUNT(*) FROM department group by tb_name
UNION
SELECT 'education' as tb_name ,COUNT(*) FROM education group by tb_name
UNION
SELECT 'employee' as tb_name ,COUNT(*) FROM employee group by tb_name
UNION
SELECT 'hr' as tb_name ,COUNT(*) FROM hr group by tb_name
UNION
SELECT 'job' as tb_name ,COUNT(*) FROM job group by tb_name
UNION
SELECT 'salary' as tb_name ,COUNT(*) FROM salary group by tb_name
UNION
SELECT 'location' as tb_name ,COUNT(*) FROM location group by tb_name;

--DELETE ALL RECORDS



