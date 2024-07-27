-- Leetcode challenge - 1174 
-- If the preferred delivery date of the customer is the same as the order date then the order is called immediate otherwise it's called scheduled.
-- The first order of a customer is the order with the earliest order date that customer made. It is guaranteed that a customer has exactly one first order.
-- Write an SQL query to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.
  
--CREATE TABLE deliveries (
--    delivery_id INT PRIMARY KEY,
--    customer_id INT,
--    order_date DATE,
--    customer_pref_delivery_date DATE
--);

--INSERT INTO deliveries (delivery_id, customer_id, order_date, customer_pref_delivery_date)
--VALUES
--    (1, 1, '2019-08-01', '2019-08-02'),
--    (2, 2, '2019-08-02', '2019-08-02'),
--    (3, 1, '2019-08-11', '2019-08-12'),
--    (4, 3, '2019-08-24', '2019-08-24'),
--    (5, 3, '2019-08-21', '2019-08-22'),
--    (6, 2, '2019-08-11', '2019-08-13'),
--    (7, 4, '2019-08-09', '2019-08-09');

select * from deliveries 


select convert(nvarchar(5),cast((cast(x.immcount as decimal(10,2))/z.tc)* 100 as int))+'%' as Percentage   from (
select count(1) as immcount from (
select *,dense_rank() over(partition by customer_id  order by order_date asc) as rnk 
from deliveries) as x
where rnk = 1 and order_date = customer_pref_delivery_date ) as x

, 

(select sum(totalcount) as tc from (
select count(distinct(customer_id)) as totalcount from deliveries group by customer_id) as y
) as z
