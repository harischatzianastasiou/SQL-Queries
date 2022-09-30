-- 1. Find how many employees have salary greater than the average salary of all employees.

--WITHOUT CTE
select count(*) 
from employees e,
(   select avg(salary) as avg_sal
    from employees
) a
where e.salary > a.avg_sal;

--WITH CTE 

WITH emps as (
    SELECT salary, avg(salary) OVER() avg_sal
    FROM employees
)
SELECT count(*)
FROM emps
WHERE emps.salary > emps.avg_sal;

-- 2. Find all the employees                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               whose salary is greater than the average salary of all employees.

--WITHOUT CTE
select e.first_name,e.last_name
from employees e,
(   select avg(salary) as avg_sal
    from employees
) a
where e.salary > a.avg_sal;

--WITH CTE 

WITH emps as (
    SELECT first_name,last_name,salary, avg(salary) OVER() avg_sal
    FROM employees
)
SELECT first_name, last_name
FROM emps
WHERE emps.salary > emps.avg_sal;

-- 3.  Find all the employees whose salary is greater than the average salary of all employees in respective departments.

WITH emp1 as (
    select department_id,avg(salary) avg_sal
    from employees 
    group by department_id
)

select first_name, last_name
from employees LEFT JOIN emp1 USING (department_id)
WHERE salary > avg_sal
