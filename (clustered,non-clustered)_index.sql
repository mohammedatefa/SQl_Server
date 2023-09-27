				--Day 6 Lab Assignments

--1.	Create backup from my database (using three types)
-- * first type is full-backup type 
-- Explaination:-
-- full-backup make  backup for all database from its creation 
-- * second type is differintional type 
-- Explaination:-
-- differintional make  backup for  database from last full-backup
--* third type is transaction type 
-- Explaination:-
-- transaction make  backup for database from last any backup occured on the database
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
--3.	Create a  clustered index on Employee table

--a index on the column of EmpNo can not be created as it by defualt created clusterd index as it has primary key constraint
use[Net23_Company]
create nonclustered index EmpNo --Cannot create more than one clustered index 
on [dbo].[Employee] ([EmpNo])

--b create new table, and try to create cluster index on the ID column of it.
create table table_index_test (
	Id int ,
	name varchar(2),
	age int,
)
create clustered index id_index
on table_index_test(Id)

--c .Can you create a clustered index on a column that isn’t a primary key?
-- yes you can create index for the column but it must the table does contain another primary key column 

--d.	Does SQL server create a clustered index on the primary kery as default?
--defualt created clusterd index if it has primary key constraint

--e.	Can you change it and make it as a non-clustered index and create a clustered index on other column?
-- you can change only the custom clustered index that you create but by drop it and create new clustered index but the defualt clustered index you can not change it 

---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--4.	Create non-clustered index on name column in employee table.
create nonclustered index ncIndex --non-unique clustered 
on [dbo].[Employee]([EmpFname])

