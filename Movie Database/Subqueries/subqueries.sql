-- 1.From the actor table, write a SQL query to find the actors who played a role in the movie 'Annie Hall'.
--   Return all the fields of actor table.

select *
from actor 
where act_id IN (select act_id from movie_cast where mov_id IN ( select mov_id from movie where mov_title = 'Annie Hall'));

-- 2.Write a SQL query to find the director of a film that cast a role in 'Eyes Wide Shut'.
--   Return director first name, last name.

select * 
from director;

select *
from movie_cast;

select *
from movie;

select *
from movie_direction;

select dir_fname,dir_lname
from director 
where dir_id in ( select dir_id from movie_direction
                  where mov_id in ( select mov_id from movie where mov_title = 'Eyes Wide Shut')
                );

-- 3.From movie table, write a SQL query to find those movies that have been released in countries other than the United Kingdom.
--   Return movie title, movie year, movie time, and date of release, releasing country.

select mov_title as "Movie Title",mov_year as "Movie Year",mov_time AS "Movie Time",mov_dt_rel AS "Date of Release" ,mov_rel_country AS "Releasing Country"
from movie 
where mov_rel_country != 'UK'; 
/*where mov_rel_country <> 'UK'; */

-- 4.Write a SQL query to find the movies whose reviewer is unknown.
--   Return movie title, year, release date, director first name, last name, actor first name, last name.

SELECT mov_title, mov_year, mov_dt_rel, dir_fname, dir_lname, act_fname, act_lname
FROM movie m JOIN actor a 
ON (m.mov_id IN (select mov_id from rating where rev_id in ( select rev_id from reviewer where rev_name is null))
    AND a.act_id IN (select act_id from movie_cast where mov_id in (m.mov_id)))
JOIN director d 
ON d.dir_id IN (select dir_id from movie_direction where mov_id in (m.mov_id));
