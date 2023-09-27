use ITI
--	1. scalar funcion
--return one vales "all perviouse functions are scalar function"
--syntax
/*create function FunctionName(paramater list)
returns Datatype
begin
	function Body
	return
end
*/
------------------------
--Examples
-- Function Definition
Create function TestFun()
returns Nvarchar(15)
Begin
	Return 'Hello World'
End

------
--Function Calling 
Select dbo.TestFun()
----------------------------------

create function GetProductColor(@sid int)
returns nvarchar(20)
begin
declare @name nvarchar(20)
	if @sid > 0
		--set @name=(select Color from AdventureWorks.Production.Product
		--where ProductID=@sid)

		select @name=Color from AdventureWorks.Production.Product
		where ProductID=@sid
	else
		set @name='sid must be positive'
	return @name 	
end 


--Function calling
select dbo.GetProductColor(317) 
 --OR
print dbo.GetProductColor(-1)
--OR
Declare @result nvarchar(20)
select @result=dbo.GetProductColor(317) 
print @result

-----------------------------
alter function myday(@x datetime)
returns nvarchar(20)
as
begin
declare @d nvarchar(20)
select @d=datename(MM,@x)
return @d
end

select dbo.myday('2014-05-08')					
					-----------------------------
USE northwind
GO
CREATE FUNCTION fn_NewRegion ( @myinput nvarchar(30) ) 
RETURNS nvarchar(30)
BEGIN
  IF @myinput IS NULL
	SET @myinput = 'Not Applicable'

  RETURN @myinput
END
GO

exec fn_NewRegion 'Null'
							---------------------	
use AdventureWorks							
SELECT Name, ProductNumber, Color FROM
Production.Product
go

CREATE FUNCTION fn_NULL_to_NA --//it is generic fn
(@inputString nvarchar(30))
RETURNS nvarchar(15)
AS
BEGIN
	If @inputString IS NULL
	SET @inputString = 'Not Available'
-- At this point, the value of the @inputString
-- variable is either the
-- original color or it has been changed to Not
-- Available if it was NULL
	Return @inputString
END
go
 --test function
 SELECT Name, ProductNumber, dbo.fn_NULL_to_NA(Color)
FROM Production.Product							
							-----------------------------------