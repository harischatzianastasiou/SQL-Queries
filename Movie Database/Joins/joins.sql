-- 1. Write a SQL query to find all reviewers whose ratings contain a NULL value. Return reviewer name.

select rev_name
from reviewer r INNER JOIN rating ra 
ON r.rev_id = ra.rev_id 
AND rev_stars IS NULL ;

--How to use USING CLAUSE
select rev_name
from reviewer INNER JOIN rating USING(rev_id)
WHERE rev_stars IS NULL;

-- 2. Write a SQL query to find out who was cast in the movie 'Annie Hall'. 
--    Return actor first name, last name and role.

select act_fname, act_lname, role
from actor INNER JOIN movie_cast USING(act_id)
INNER JOIN movie USING(mov_id)
WHERE mov_title = 'Annie Hall';

-- 3. From the following table, write a SQL query to find the director who directed a movie that 
--    featured a role in 'Eyes Wide Shut'. Return director first name, last name and movie title.
