--Create table Seat (id int, student varchar(255))
--Truncate table Seat
--insert into Seat (id, student) values ('1', 'Abbot')
--insert into Seat (id, student) values ('2', 'Doris')
--insert into Seat (id, student) values ('3', 'Emerson')
--insert into Seat (id, student) values ('4', 'Green')
--insert into Seat (id, student) values ('5', 'Jeames')

select* from seat

select case when id%2=0 then id-1 else case when id+1 in (select id from seat ) then 
id+1 else id end end as did,student  from seat
