---- Create Users table
--CREATE TABLE Users (
--    user_id INT PRIMARY KEY,
--    join_date DATE,
--    favorite_brand VARCHAR(50)
--);

---- Insert data into Users table
--INSERT INTO Users (user_id, join_date, favorite_brand) VALUES
--(1, '2019-01-01', 'Lenovo'),
--(2, '2019-02-09', 'Samsung'),
--(3, '2019-01-19', 'LG'),
--(4, '2019-05-21', 'HP');

---- Create Orders table
--CREATE TABLE Orders (
--    order_id INT PRIMARY KEY,
--    order_date DATE,
--    item_id INT,
--    buyer_id INT,
--    seller_id INT
--);

---- Insert data into Orders table
--INSERT INTO Orders (order_id, order_date, item_id, buyer_id, seller_id) VALUES
--(1, '2019-08-01', 4, 1, 2),
--(2, '2019-08-02', 2, 1, 3),
--(3, '2019-08-03', 3, 2, 3),
--(4, '2019-08-04', 1, 4, 2),
--(5, '2019-08-04', 1, 3, 4),
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
select * from orders 
select * from items 

select user_id as 'seller_id', case when seller_id is not null and it_id is not null 
then 'yes' else 'no' end as '2nd_item_fav_brand ' from( 
select favorite_brand,user_id,b.item_id,comp.seller_id,comp.item_id  as it_id from users a left join items b on a.favorite_brand= b.item_brand 
left join
(select * from(
select seller_id,item_id,row_number () over(partition by seller_id order by order_date asc) as rnk 
from orders) as x where rnk=2) as comp on a.user_id=comp.seller_id and comp.item_id = b.item_id) as op
order by seller_id  asc
