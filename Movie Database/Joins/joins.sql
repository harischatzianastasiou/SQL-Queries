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

select *
from director NATURAL JOIN movie_direction
NATURAL JOIN movie
NATURAL JOIN movie_cast 
WHERE role IS  NOT NULL
AND mov_title='Eyes Wide Shut';

/*
select dir_fname, dir_lname, mov_title 
from director d INNER JOIN movie m 
ON m.mov_id in (  select mov_id from movie where mov_title = 'Eyes Wide Shut')
AND d.dir_id in ( select dir_id from movie_direction where mov_id = m.mov_id);
*/
-- 4. Write a SQL query to find the director of a movie that cast a role as Sean Maguire. 
--    Return director first name, last name and movie title.

select dir_fname, dir_lname, mov_title
from director NATURAL JOIN movie_direction 
NATURAL JOIN movie_cast 
NATURAL JOIN movie
WHERE role = 'Sean Maguire';

-- 5. Write a SQL query to find out which actors have not appeared in any movies between 1990 and 2000 (Begin and end values are included.).
--    Return actor first name, last name, movie title and release year.

select act_fname, act_lname
from actor NATURAL JOIN movie_cast 
NATURAL JOIN movie 
WHERE mov_year not between 1990 AND 2000 ;

-- 6. Write a SQL query to find the directors who have directed films in a variety of genres. 
--    Group the result set on director first name, last name and generic title. 
--    Sort the result-set in ascending order by director first name and last name.
--    Return director first name, last name and number of genres movies.

select dir_fname,dir_lname,gen_title,count(*)
from director NATURAL JOIN movie_direction 
NATURAL JOIN movie_genres 
NATURAL JOIN genres 
GROUP BY dir_fname,dir_lname,gen_title
ORDER BY dir_fname, dir_lname;

--7. Write a SQL query to find the movies with year and genres. Return movie title, movie year and generic title.

select mov_title, mov_year, gen_title 
from movie 
NATURAL JOIN movie_genres 
NATURAL JOIN genres
ORDER BY mov_title;
-- 8. Write a SQL query to find all the movies with year, genres, and name of the director.

select mov_title,mov_year, gen_title, dir_fname, dir_lname
from movie 
NATURAL JOIN movie_direction
NATURAL JOIN director
NATURAL JOIN genres

-- 9. Write a SQL query to find the movies released before 1st January 1989. Sort the result-set in descending order by date of release.
--    Return movie title, release year, date of release, duration, and first and last name of the director. 

select mov_title,mov_year,mov_dt_rel,mov_time,dir_fname,dir_lname
from movie 
NATURAL JOIN movie_direction
NATURAL JOIN director 
WHERE mov_dt_rel < '01-JAN-1989'
ORDER BY mov_dt_rel desc ;

-- 10. Write a SQL query to calculate the average movie length and count the number of movies in each genre. 
--     Return genre title, average time and number of movies for each genre.

select gen_title,avg(mov_time),count(gen_title)
from movie 
NATURAL JOIN movie_genres
NATURAL JOIN genres
GROUP BY gen_title
ORDER BY avg(mov_time) DESC;
