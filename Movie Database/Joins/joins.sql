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

-- 11. Write a SQL query to find movies with the shortest duration. 
--     Return movie title, movie year, director first name, last name, actor first name, last name and role.
select mov_title, mov_year, dir_fname, dir_lname, act_fname, act_lname, role
from movie 
NATURAL JOIN movie_direction 
NATURAL JOIN director
NATURAL JOIN actor 
NATURAL JOIN movie_cast
WHERE mov_time = ( select min(mov_time) from movie );

-- 12. Write a SQL query to find the years in which a movie received a rating of 3 or 4. 
--     Sort the result in increasing order on movie year.

select distinct mov_year 
from movie
NATURAL JOIN rating
WHERE rev_stars = 3 OR rev_stars = 4
ORDER BY mov_year;

-- 13. Write a SQL query to get the reviewer name, movie title, and stars in an order that reviewer name will come first, 
--     then by movie title, and lastly by number of stars.

select rev_name, mov_title, rev_stars 
from rating
NATURAL JOIN reviewer
NATURAL JOIN movie
WHERE rev_name IS NOT NULL
ORDER BY rev_name, mov_title, rev_stars; 

-- 14. Write a SQL query to find those movies that have at least one rating and received the most stars. 
--     Sort the result-set on movie title. Return movie title and maximum review stars.

select mov_title, max(rev_stars)
from movie
INNER JOIN rating
ON num_o_rating IS NOT NULL
GROUP BY mov_title
HAVING MAX(rev_stars)>0
ORDER BY mov_title;

-- 15.  Write a SQL query to find out which movies have received ratings. 
--      Return movie title, director first name, director last name and review stars.

select mov_title, dir_fname, dir_lname, rev_stars 
from rating 
NATURAL JOIN movie
NATURAL JOIN movie_direction
NATURAL JOIN director
WHERE rev_stars IS NOT NULL; 

-- 16. Write a SQL query to find movies in which one or more actors have acted in more than one film. 
--     Return movie title, actor first and last name, and the role.

select mov_title, act_fname, act_lname, role 
from movie 
NATURAL JOIN movie_cast
NATURAL JOIN actor
WHERE act_id in ( select act_id from movie_cast GROUP BY act_id HAVING count(act_id) > 1 );

-- 17. Write a SQL query to find the actor whose first name is 'Claire' and last name is 'Danes'.
--     Return director first name, last name, movie title, actor first name and last name, role.

select dir_fname, dir_lname, mov_title, act_fname, act_lname, role
from movie 
NATURAL JOIN movie_direction 
NATURAL JOIN director
NATURAL JOIN actor 
NATURAL JOIN movie_cast 
WHERE act_fname = 'Claire' AND act_lname = 'Danes';

-- 18. Write a SQL query to find for actors whose films have been directed by them. 
--     Return actor first name, last name, movie title and role

select act_fname, act_lname, mov_title, role ,dir_fname, dir_lname
from actor
NATURAL JOIN movie_cast
NATURAL JOIN movie_direction
NATURAL JOIN director 
NATURAL JOIN movie
WHERE act_fname = dir_fname AND act_lname = dir_lname;

-- 19.  Write a SQL query to find the cast list of the movie ‘Chinatown’. Return first name, last name.

select act_fname, act_lname
from actor 
NATURAL JOIN movie_cast
NATURAL JOIN movie
where mov_title = 'Chinatown';

-- 20. Write a SQL query to find those movies where actor’s 
--     first name is 'Harrison' and last name is 'Ford'. Return movie title.

select mov_title 
from movie
NATURAL JOIN movie_cast
NATURAL JOIN actor 
WHERE act_fname = 'Harrison' AND act_lname = 'Ford';

-- 21. Write a SQL query to find the highest-rated movies.
--     Return movie title, movie year, review stars and releasing country.

select mov_title, mov_year, rev_stars, mov_rel_country
from movie
NATURAL JOIN rating
WHERE rev_stars = ( select max(rev_stars) from rating );

-- 22. Write a SQL query to find the highest-rated ‘Mystery Movies’. Return the title, year, and rating.

select mov_title, mov_year, rev_stars
from movie
NATURAL JOIN rating
NATURAL JOIN movie_genres
NATURAL JOIN genres
WHERE rev_stars  = ( select max(rev_stars) from  genres NATURAL JOIN movie_genres NATURAL JOIN rating WHERE gen_title = 'Mystery');

-- 23.  Write a SQL query to find the years when most of the ‘Mystery Movies’ produced.
--      Count the number of generic title and compute their average rating. 
--      Group the result set on movie release year, generic title. 
--      Return movie year, generic title, number of generic title and average rating.

select mov_year,gen_title,count(gen_title),avg(rev_stars)
from movie 
NATURAL JOIN movie_genres
NATURAL JOIN genres
NATURAL JOIN rating
WHERE gen_title = 'Mystery'
GROUP BY mov_year,gen_title;

-- 24.  Write a query in SQL to generate a report, which contain the fields movie title, name of the female actor,
--      year of the movie, role, movie genres, the director, date of release, and rating of that movie.

select mov_title,act_fname,act_lname,mov_year,role,gen_title,dir_fname,dir_lname,mov_dt_rel,rev_stars 
from movie 
NATURAL JOIN movie_cast
NATURAL JOIN movie_direction
NATURAL JOIN director 
NATURAL JOIN actor
NATURAL JOIN rating
NATURAL JOIN movie_genres
NATURAL JOIN genres
WHERE act_gender = 'F';
