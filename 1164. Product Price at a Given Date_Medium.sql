---- Create the Products table
--CREATE TABLE Products (
--    product_id INT,
--    new_price DECIMAL(10, 2),
--    change_date DATE
--);

---- Insert data into the Products table
--INSERT INTO Products (product_id, new_price, change_date) VALUES
--(1, 20, '2019-08-14'),
--(2, 50, '2019-08-14'),
--(1, 30, '2019-08-15'),
--(1, 35, '2019-08-16'),
--(2, 65, '2019-08-17'),
--(3, 20, '2019-08-18');

select b.product_id,cast(case when new_price is null then '10' else new_price end as int)  as 'new_price' from(
select * from (
select *,row_number() over(partition by product_id order by change_date desc)rnk from products
where change_date <='2019-08-16') as x where rnk=1) as a 
right join
(select distinct(product_id) product_id from products) as b  on  a.product_id = b.product_id