-- variables
/*1-Global variables (Defined By the server):
	1- defined by server.
	2-begin with @@.
	3-cann't be created by user
	4-cann't assigned a value by user
*/
--Common global variables:
	@@rowcount  ---number of rows affected.
	@@error  --------0 or num of error message.
.	@@version  ----- version of the DBMS.
--Examples
select @@VERSION as 'result';
--OR
print @@VERSION;
-----
use AdventureWorks;
select * from Production.Product1;
go
select @@error ----Note: Select @@error must be executed in a single batch.
-----
use AdventureWorks;
update Production.Product
set Name='newProduct222'
where ProductID =316;
select @@ROWCOUNT;

----------------------------------------------
--2-Local varibales (User Defined) 
    --User defined
    --Always begin with @
-- Declaring Local variables
DECLARE  @stdID  varchar(11)
        ,@vlName char(20)
		,@cName  varchar(10);
--------------------------------------------
--Assigning values to them
	-- 1- Assigment select\set using an expression
	-- 2- Assignment select using a table value
	-- 3- Assignment update
--Assigment set using an expression
 DECLARE  @myVar  varchar(11);
set @myVar='test'
--or
select @myVar='test';

print @myVar
--or
select @myVar; 


 
--Assignment select using a table value
DECLARE  @Pname  nvarchar(55);

SELECT @Pname = Name
 FROM  Production.Product 
 WHERE ProductID  = 4;   --if it returns multiple values, only  the last value remains
 --or
 set @Pname=
 (SELECT  Name
 FROM  Production.Product 
 WHERE ProductID  = 4);

print @Pname	
select 	@Pname	
		
--Assignment update
DECLARE  @cName  varchar(11);
set @cName='ahmed'
update customer
set phone=2222222
	,contact=@cName
where cust_id=1
-------------------------------------------------
-- Displaying them
SELECT @EmpID ,@cName AS [customer Name] 
GO 
------------------------------------------
-- create variable form table
DECLARE @ProductTotals TABLE
(
  ProductID int,
  Name nvarchar(50)
)

--insert into @ProductTotals values(10,1000)
insert into @ProductTotals
select [EmployeeID],[NationalIDNumber] from [HumanResources].[Employee]

select * from @ProductTotals

--create table data type
create type customertype as table
(
		Cust_ID int not null
		,Cust_Name varchar(50)
		,Cust_Surname varchar(50)
		,Cust_Email varchar(50)
)
go
declare @c customertype;
insert into @c values (1,'steven','gerrard','sg@liverpool.com')
insert into @c values (2,'jamie','caragher','jc@liverpool.com')
select * from @c

create type idColumn as table
(ID int)

declare @i idColumn;
select st_id from newschema.Student insert into @i;

select * from @i;
--------------------------------------------
--General Example for using variables
USE ITI;
CREATE TABLE orders
(
	orderid INTEGER NOT NULL,
	orderdate DATE,
	shippeddate DATE,
	freight money
);
GO
declare @i int , @order_id integer
declare @orderdate datetime
declare @shipped_date datetime
declare @freight money
set @i = 1
set @orderdate = getdate()
set @shipped_date = getdate()
set @freight = 100.00
while @i < 10
begin
	insert into orders (orderid, orderdate, shippeddate, freight)
	values( @i, @orderdate, @shipped_date, @freight)
	set @i = @i+1
end
