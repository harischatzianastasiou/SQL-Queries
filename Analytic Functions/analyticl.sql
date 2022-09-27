--ANALYTIC FUNCTIONS

-- 1. Aggregate and analytic functions both enable you to do a calculation over many rows. 
--    Aggregate functions squash the output to ONE ROW PER GROUP. 
--    For example the following counts the total rows in the table. It returns one row:

select count(*) from bricks;

-- 2. This allows you to see the values from all the other columns
--    which you can't using group by:

select b.*, 
       count(*) over () total_count 
from   bricks b;

-- 3.You can have the same use as GROUP BY in analytic funtions
--   with the use of PARTITION BY clause.

select colour,count(*), sum ( weight )
from   bricks
group  by colour;
--same but now can also see the values from all the other columns 
select b.*, count(*) over (PARTITION BY colour) , sum ( weight ) over (PARTITION BY colour) 
from   bricks b;

-- 4. Write a query to return the count and average weight of bricks for each shape:

select b.*, 
count(*) over(PARTITION BY shape) as "Count of bricks for this shape",
avg(weight) over(PARTITION BY shape) as "Avg weight of brick for this shape"
from bricks b
order  by shape, weight, brick_id;


-- 5. ORDER BY 
-- The order by clause enables you to compute running totals. For example, the following sorts the rows by brick_id. 
-- Then shows the total number of rows and sum of the weights for rows with a brick_id less than or equal to that of the current row:

select b.*, 
       count(*) over (
         order by brick_id
       ) running_total, 
       sum ( weight ) over (
         order by brick_id
       ) running_weight
from   bricks b;
select count(*) from bricks;

-- 6. Partition By + Order By

-- You can combine the partition by and order by clauses to get running totals within a group. 
-- For example, the following splits the rows by colour. 
-- It then gets the running count and weight of rows for each colour, sorted by brick_id:

select b.*, 
       count(*) over (
         partition by colour
         order by brick_id
       ) running_total, 
       sum ( weight ) over (
         partition by colour
         order by brick_id
       ) running_weight
from   bricks b;

-- 7. Windowing Clause
