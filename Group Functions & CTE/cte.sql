-- Find all the employee whose salary is more than the average salary of all employees

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

