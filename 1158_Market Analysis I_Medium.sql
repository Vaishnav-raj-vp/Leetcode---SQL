---- Create Users table
--CREATE TABLE Users (
--    user_id INT PRIMARY KEY,
--    join_date DATE,
--    favorite_brand VARCHAR(50)
--);

---- Insert data into Users table
--INSERT INTO Users (user_id, join_date, favorite_brand) VALUES
--(1, '2018-01-01', 'Lenovo'),
--(2, '2018-02-09', 'Samsung'),
--(3, '2018-01-19', 'LG'),
--(4, '2018-05-21', 'HP');

---- Create Orders table
--CREATE TABLE Orders (
--    order_id INT PRIMARY KEY,
--    order_date DATE,
--    item_id INT,
--    buyer_id INT,
--    seller_id INT,

--);

---- Insert data into Orders table
--INSERT INTO Orders (order_id, order_date, item_id, buyer_id, seller_id) VALUES
--(1, '2019-08-01', 4, 1, 2),
--(2, '2018-08-02', 2, 1, 3),
--(3, '2019-08-03', 3, 2, 3),
--(4, '2018-08-04', 1, 4, 2),
--(5, '2018-08-04', 1, 3, 4),
--(6, '2019-08-05', 2, 2, 4);

---- Create Items table
--CREATE TABLE Items (
--    item_id INT PRIMARY KEY,
--    item_brand VARCHAR(50)
--);

---- Insert data into Items table
--INSERT INTO Items (item_id, item_brand) VALUES
--(1, 'Samsung'),
--(2, 'Lenovo'),
--(3, 'LG'),
--(4, 'HP');


select * from users
select * from items 
select * from orders 


--select [user_id],join_date from users a left join items b 
--on a.[user_id] = b.item_id left join orders c 
--on b.item_id=c.item_id
--where left(order_date,4)='2019'

select y.buyer_id,y.join_date,orderin2019 from (
select buyer_id , join_date,case when left(order_date,4)='2019' then rnk else 0 end as 'orderin2019' 
from (
select b.buyer_id,order_date,row_number() over(partition by buyer_id order by buyer_id) as rnk,
join_date 
from items  a left outer join orders b on  a.item_id=b.buyer_id left join users c 
on c.user_id = a.item_id) as x) as y  inner join (


select buyer_id, max(orderin2019) as maxed from (
select buyer_id , join_date,case when left(order_date,4)='2019' then rnk else 0 end as 'orderin2019' 
from (
select b.buyer_id,order_date,row_number() over(partition by buyer_id order by buyer_id) as rnk,
join_date 
from items  a left outer join orders b on  a.item_id=b.buyer_id left join users c 
on c.user_id = a.item_id) as x) as y
group by buyer_id) as z 
on y.orderin2019=z.maxed and y.buyer_id=z.buyer_id




SELECT u.user_id AS buyer_id, u.join_date, COUNT(o.order_id) AS orders_in_2019
FROM Users u
LEFT JOIN Orders o ON u.user_id = o.buyer_id and YEAR(o.order_date) = 2019
GROUP BY u.user_id, u.join_date



SELECT u.user_id AS buyer_id, 
       u.join_date, 
       COALESCE(COUNT(o.order_id), 0) AS orders_in_2019
FROM Users u
LEFT JOIN Orders o ON u.user_id = o.buyer_id AND YEAR(o.order_date) = 2019
GROUP BY u.user_id, u.join_date;



