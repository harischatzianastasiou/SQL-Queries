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
    -- Movie cast connects actor and movie table by referencing their primary keys(act_id and mov_id)
    -- How to join tables that are not immediately connected 
JOIN director d 
ON d.dir_id IN (select dir_id from movie_direction where mov_id in (m.mov_id));

-- 5. Write a SQL query to find those movies directed by the director 
--    whose first name is Woddy and last name is Allen. Return movie title

select mov_title 
from movie 
where mov_id in ( select mov_id
                  from movie_direction 
                  where dir_id in (select dir_id 
                                    from director
                                    where dir_fname = 'Woody' AND dir_lname = 'Allen')
                );
                
-- 6. Write a SQL query to determine those years in which there was at least one movie that received a rating of at least three stars.
--    Sort the result-set in ascending order by movie year. Return movie year.

select DISTINCT mov_year
from movie 
where mov_id in (select mov_id
                 from rating
                 where rev_stars >= 3);
                 
-- 7. Write a SQL query to search for movies that do not have any ratings. Return movie title.

select distinct mov_title 
from movie
where mov_id in ( select mov_id from rating 
                  where num_o_rating is null)
OR mov_id NOT IN (select mov_id from rating);

/*
select mov_title 
from movie 
where NOT EXISTS(select mov_id from rating where movie.mov_id=rating.mov_id AND num_o_rating is not null);
*/
-- 8. Write a SQL query to find those reviewers who have not given a rating to certain films. Return reviewer name.

select rev_name
from reviewer 
where rev_id IN (select rev_id from rating
                 where rev_stars is null)
OR rev_id NOT in ( select rev_id from rating);

-- Either have 0 num_of_rating OR have no entry in ratings table.MUST CHECK BOTH. 

-- 9. Write a SQL query to find movies that have been reviewed by a reviewer and received a rating. 
--    Sort the result-set in ascending order by reviewer name, movie title, review Stars. Return reviewer name, movie title, review Stars.

select rev_name, mov_title, rev_stars 
from rating INNER JOIN movie 
ON movie.mov_id = rating.mov_id 
-- Here unlike 4. table rating is referncing to movie table with foreign key mov_id.
    AND  num_o_rating is not null
    AND rev_stars is not null
JOIN reviewer
ON reviewer.rev_id = rating.rev_id
AND reviewer.rev_name is not null
ORDER BY rev_name, mov_title, rev_stars;

-- 10. Write a SQL query to find movies that have been reviewed by a reviewer and received a rating. 
--     Group the result set on reviewer’s name. Return reviewer’s name and number of reviews of every reviewer.

select rev_name,count(*)
from rating INNER JOIN movie 
ON movie.mov_id = rating.mov_id 
-- Here unlike 4. table rating is referncing to movie table with foreign key mov_id.
    AND  num_o_rating is not null
    AND rev_stars is not null
JOIN reviewer
ON reviewer.rev_id = rating.rev_id
AND reviewer.rev_name is not null
GROUP BY rev_name
ORDER BY count(*) DESC;

--  11. Write a SQL query to find those movies, which have received highest number of stars.
--  Group the result set on movie title and sorts the result-set in ascending order by movie title.
--  Return movie title and maximum number of review stars.

select mov_title,max(rev_stars)
from rating INNER JOIN movie
ON rating.mov_id = movie.mov_id
   AND rev_stars is not null 
GROUP BY mov_title
ORDER by mov_title;

-- 12. Write a SQL query to find all reviewers who rated the movie 'American Beauty'. Return reviewer name.

select rev_name
from reviewer 
where rev_id in (select rev_id from rating where mov_id in ( select mov_id from movie where mov_title = 'American Beauty'));

-- 13. Write a SQL query to find the movies that have not been reviewed by any reviewer body other than 'Paul Monks'.
--     Return movie title.

select mov_title 
from movie
where mov_id in ( select mov_id from rating where rev_id NOT IN ( select rev_id from reviewer where rev_name = 'Paul Monks'))

-- 14. From the following table, write a SQL query to find the movies with the lowest ratings. 
--     Return reviewer name, movie title, and number of stars for those movies.

select rev_name, mov_title, rev_stars
from rating r INNER JOIN movie m
ON r.mov_id = m.mov_id 
AND rev_stars = ( select min(rev_stars) from rating ) 
JOIN reviewer 
ON reviewer.rev_id = r.rev_id
AND rev_name IS NOT NULL;

-- 15. Write a SQL query to find the movies directed by 'James Cameron'. Return movie title.

select mov_title
from movie_direction INNER JOIN movie 
ON movie_direction.mov_id = movie.mov_id
inner JOIN director 
ON director.dir_id = movie_direction.dir_id 
AND dir_fname = 'James' AND dir_lname = 'Cameron';

-- 16. Write a query in SQL to find the movies in which one or more actors appeared in more than one film.

select mov_title
from movie 
where mov_id in ( select mov_id 
                  from movie_cast 
                  where act_id in( select act_id from movie_cast GROUP BY act_id HAVING count(act_id)>1 )
                  --where act_id in (select act_id from( select act_id,count(*) from movie_cast group by act_id having count(*) >= 2 ))
                );
