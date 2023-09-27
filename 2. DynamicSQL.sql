/*
Use EXECUTE with String Literals and Variables
Use When You Must Assign the Value of the Variable 
at Execution Time
*/
USE ITI



-- i'm now in Adventureworks DBDECLARE 
declare 	@dbname varchar(30)
   ,@tblname varchar(30)

SET @dbname = 'sales'
SET @tblname = 'customers'

--retrieve the whole products from products table in northwind DB
--select 'USE ' + @dbname + ' SELECT * FROM ' + @tblname



EXECUTE('USE ' + @dbname + ' SELECT * FROM ' + @tblname)
GO



create proc d_proc(@t nvarchar(50))
as
Execute ('select * from ' +@t)

d_proc 'customers'