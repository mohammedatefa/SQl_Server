-- control of flow elements
--usig if...else statment
DECLARE @n tinyint
SET @n = 5;
IF (@n BETWEEN 4 and 6 )-- (4,6) "boundaries" are included
   begin
		--statments or queries
		USE AdventureWorks;
		select * FROM Production.Product
		WHERE ProductID=@n;
   end
Else
   begin 
		--statments or queries
		select 'Not allowed number';
   end
---------------------------------------
--if exists
use AdventureWorks;
if exists(select * FROM Production.Product WHERE ProductID=1)

	update Production.Product 
	set Name='new product'
	where ProductID=1;
Else
	--insert
	print 'Not Found';
--------------------------------------
--loop using while
DECLARE @n tinyint;
SET @n = 1
WHILE (@n < 10)      
BEGIN             --error if we remove begin,end here
	--statements or Queries
	print @n;
	--USE AdventureWorks;
		--select * FROM Production.Product WHERE ProductID=@n;
	Set @n=@n+1;--increement of variable condition that ends the loop
END    
GO 
-- Using Continue , Break with while loop
declare @i int
Set @i = 0
while (@i < 10)
begin
	if (@i=5)
		begin
			Set @i=@i+1
			continue  --go to the beginning of that loop
		end
	else if (@i=8)
		break		--get out of loop
	
	Set @i=@i+1;
	print @i;		
end
------------------------------------------------------------------------------					
--Using When Expression (T-SQL)
USE AdventureWorks;
GO
SELECT   ProductNumber, ProductLine as Name
FROM Production.Product
ORDER BY ProductNumber;

SELECT   ProductNumber,
      CASE ProductLine
         WHEN 'R' THEN 'Road'
         WHEN 'M' THEN 'Mountain'
         WHEN 'T' THEN 'Touring'
         WHEN 'S' THEN 'Other sale items'
         ELSE 'Not for sale'
      END as Name
FROM Production.Product
ORDER BY ProductNumber;
GO

