--create table traffic (uerid int,activity nvarchar(100), activity_date date)

--insert into traffic values 
--( 1       , 'login'    , '2019-05-01'    ) ,
--( 1       , 'homepage' , '2019-05-01'    ) ,
--( 1       , 'logout'   , '2019-05-01'    ) ,
--( 2       , 'login'    , '2019-06-21'    ) ,
--( 2       , 'logout'   , '2019-06-21'    ) ,
--( 3       , 'login'    , '2019-01-01'    ) ,
--( 3       , 'jobs'     , '2019-01-01'    ) ,
--( 3       , 'logout'   , '2019-01-01'    ) ,
--( 4       , 'login'    , '2019-06-21'    ) ,
--( 4       , 'groups'   , '2019-06-21'    ) ,
--( 4       , 'logout'   , '2019-06-21'    ) ,
--( 5       , 'login'    , '2019-03-01'    ) ,
--( 5       , 'logout'   , '2019-03-01'    ) ,
--( 5       , 'login'    , '2019-06-21'    ) ,
--( 5       , 'logout'   , '2019-06-21'    )
						 

select activity_date,count(1) as count  from (
select UerID, activity,min(activity_date) activity_date from traffic
where activity ='Login' 
group by UerID,activity
) as x 
where datediff(dd,activity_date,'2019-06-30')<=90
group by activity_date