--Question 1: Return a list of employees with Job Titles and Department Names

select e.emp_name, j.job_title, d.department_name
from hr
left join employee e
on hr.employee_id = e.employee_id
left join job j
on hr.job_id = j.job_id
left join department d
on hr.department_id = d.department_id

--Question 2: Insert Web Programmer as a new job title
INSERT INTO job (job_title)
VALUES ('Web Programmer');

--Question 3: Correct the job title from web programmer to web developer

UPDATE job 
SET job_title = 'Web Developer'
WHERE job_title = 'Web Programmer';

--Question 4: Delete the job title Web Developer from the database
DELETE FROM job 
WHERE job_title = 'Web Developer';

--Question 5: How many employees are in each department?
SELECT d.department_name, count(*) as Total_Employee
FROM hr 
LEFT JOIN department d 
ON hr.department_id = d.department_id
GROUP BY d.department_name;

--Question 6: Write a query that returns current and past jobs 
--(include employee name, job title, department, manager name, start and end date for position) 
--for employee Toni Lembeck.

SELECT e.emp_name, j.job_title, d.department_name, m.emp_name as manager, start_date, end_date
FROM hr
INNER JOIN employee e 
ON  hr.employee_id = e.employee_id
AND e.emp_name = 'Toni Lembeck'
LEFT JOIN job j 
ON hr.job_id = j.job_id
LEFT JOIN department d 
ON hr.department_id = d.department_id
LEFT JOIN employee m 
ON hr.manager_id = m.employee_id;