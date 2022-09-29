-- Find all the employee whose salary is more than the average salary of all employees

select avg(salary) from employees;

select e.employee_id,a.avg_sal,count()
from employees e,
(   select avg(salary) as avg_sal
    from employees
) a
GROUP BY e.employee_id,a.avg_sal
where e.salary > a.avg_sal;




WITH dept_costs as (

    SELECT e.department_id, sum(e.salary) dept_total, count(e.employee_id) empcnt

    FROM hr.employees e

    WHERE 1=1

    GROUP BY e.department_id

),

avg_costs as(  SELECT department_id, trunc(dept_total/empcnt) avg_sal

    FROM dept_costs )

select avg(avg_costs.avg_sal)
from avg_costs;
