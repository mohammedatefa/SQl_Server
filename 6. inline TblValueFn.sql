use ITI
--Inline table_valued function
--return table as a result of select statment
go
create function highage(@age int)
returns table
as 
return
(
	select st_fname,st_age 
	from student 
	where st_age=@age
)

select * from dbo.highage(20)

select st_fname from dbo.highage(20)
where st_fname like 'a%'
										----------------------------
--return information on a person with the last name of Alameda:
USE AdventureWorks2008;
GO
SELECT p.FirstName, p.LastName, em.EmailAddress,
ph.PhoneNumber FROM Person.Person p INNER JOIN
Person.PersonPhone ph
ON p.BusinessEntityID = ph.BusinessEntityID
INNER JOIN Person.EmailAddress em
ON p.BusinessEntityID = em.BusinessEntityID
WHERE LastName = 'Alameda'
go

--create a function that will return the specified mail and phone for any person
CREATE FUNCTION fn_PhoneEmail
(@LastName nvarchar(50))
RETURNS table
AS
	RETURN 
	(
		SELECT p.FirstName, p.LastName, em.EmailAddress,
		ph.PhoneNumber
		FROM Person.Person p INNER JOIN Person.PersonPhone ph
		ON p.BusinessEntityID = ph.BusinessEntityID
		INNER JOIN Person.EmailAddress em
		ON p.BusinessEntityID = em.BusinessEntityID
		WHERE LastName = @LastName 
	)

--test the function
SELECT * FROM dbo.fn_PhoneEmail ('Alameda')										
								----------------------------------