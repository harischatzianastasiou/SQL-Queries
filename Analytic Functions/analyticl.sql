--ANALYTIC FUNCTIONS

-- 1. Aggregate(sum,max count etc) and analytic functions both enable you to do a calculation over many rows. 
--    Aggregate functions squash the output to ONE ROW PER GROUP.
--    You can turn any aggregate function into analytic by using OVER.
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

--When you use order by, the database adds a default windowing clause of:

-- range between unbounded preceding 
-- and current row

--This means:
--Include all the rows with a value less than or equal to that of the current row.
--This can lead to the function including values from rows after the current!
--For example : 

select b.*, 
       count(*) over (
         order by weight
       ) running_total, 
       sum ( weight ) over (
         order by weight
       ) running_weight
from   bricks b
order  by weight;

--it checks for weight = 1 and finds it 3 times so it calculates running weight = (1+1+1) on every weight = 1
--then checks for weight = 2 finds it 2 times so it calculates running weight = 3 + (2+2) =7 on every weight = 2
--then checks for weight = 3 finds it 1 time so it calculates running weight = 7 + 3 = 10

/*

Usually this isn't what you want. Normally running totals should only include values from previous rows in the data set.

To do this, you must specify a windowing clause of

rows between unbounded preceding 
     and current row

For example:
*/

select b.*, 
       count(*) over (
         order by weight
         rows between unbounded preceding and current row
       ) running_total, 
       sum ( weight ) over (
         order by weight
         rows between unbounded preceding and current row
       ) running_weight
from   bricks b
order  by weight;

/*

Note that this makes your results non-deterministic. Rows of the same weight could have their running totals in a different order each time you run the query.

To fix this, add columns to the order by until each set of values in the sort appears once in your results. This makes your results deterministic. Here that's the brick_id:

select b.*, 
       count(*) over (
         order by weight, brick_id
         rows between unbounded preceding and current row
       ) running_total, 
       sum ( weight ) over (
         order by weight, brick_id
         rows between unbounded preceding and current row
       ) running_weight
from   bricks b
order  by weight, brick_id;

*/

-- 8. Sliding Windows 

--With sliding windows i can also specify how many preceding rows i want to include.

/*

The following shows the total weight of:

The current row + the previous row
All rows with the same weight as the current + all rows with a weight one less than the current

*/

select b.*, 
       sum ( weight ) over (
         order by weight
         rows between 1 preceding and current row
       ) running_row_weight, 
       sum ( weight ) over (
         order by weight
         range between 1 preceding and current row
       ) running_value_weight
from   bricks b
order  by weight, brick_id;

-- 9. Filtering Analytic Functions 

-- To filter and also see other columns you must use the analytic in a subquery. Then filter it in the outer query. 
--For example:

select * from (
  select b.*,
         count(*) over ( partition by colour ) colour_count
  from   bricks b
)
where  colour_count >= 2;
