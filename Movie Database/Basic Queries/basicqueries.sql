-- 1.From movie table, write a SQL query to find the name and year of the movies. Return movie title, movie release year.

select mov_title,mov_year
from movie;

-- 2.From movie table, write a SQL query to find when the movie 'American Beauty' released. Return movie release year.

select mov_year
from movie
where mov_title = 'American Beauty';

-- 3.From movie table, write a SQL query to find the movie that was released in 1999. Return movie title.

select mov_title
from movie
where mov_year = 1999;

-- 4.From movie table, write a SQL query to find those movies, which were released before 1998. Return movie title.

select mov_title
from movie
where mov_year < 1998;

-- 5.From movie and reviewer tables, write a SQL query to find the name of all reviewers and movies together in a single list.

select movie.mov_title from movie
UNION
select reviewer.rev_name from reviewer;

-- 6.From reviewer table, write a SQL query to find all reviewers who have rated seven or more stars to their rating(rating table).
     --Return reviewer name

select rev_name 
from reviewer
where rev_id in( select rev_id from rating where rev_stars>=7 ) -- where rating.rev_id = reviewer.rev_id AND rating.rev_stars>=7
AND rev_name is not null;

-- 7. From movie and rating tables, write a SQL query to find the movies without any rating. Return movie title.
--a
select mov_title
from movie,rating
where rating.mov_id = movie.mov_id
AND num_o_rating is null;

--or b 
select mov_title 
from movie 
where mov_id in ( select mov_id from rating where num_o_rating is null);

--or c
select mov_title 
from movie m  JOIN rating r
ON m.mov_id = r.mov_id
AND num_o_rating is null;

-- a,b,c would be fine if there was not a single movie that has not a matching mov_id on table ratings.
-- But besides the matching ones that have null ratings, there are also many movies without a matching mov_id on table ratings, which means they dont have any rating.
-- w3resource solution which is the following: 

SELECT mov_title
FROM movie
WHERE mov_id NOT IN (SELECT mov_id FROM rating);

--forgets to take into account the null ratings on table ratings.
--The appropriate solution combining both perspectives :

select mov_title 
from movie 
where NOT EXISTS(select mov_id from rating where movie.mov_id=rating.mov_id AND num_o_rating is not null);

-- 8.From movie table, write a SQL query to find the movies with ID 905 or 907 or 917. Return movie title.

select mov_title
from movie
where mov_id in (905,907,917);

-- 9.From movie table, write a SQL query to find the movie titles that contain the word 'Boogie Nights'. 
--   Sort the result-set in ascending order by movie year. Return movie ID, movie title and movie release year.

select mov_id,mov_title,mov_year
from movie 
where mov_title like '%Boogie Nights%'
ORDER BY mov_year;

-- 10.From the actor table, write a SQL query to find those actors with the first name 'Woody' and the last name 'Allen'.
--    Return actor ID

select act_id
from actor
where act_fname= 'Woody' AND act_lname = 'Allen';
