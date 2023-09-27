--4- backup the database to use
use AdventureWorks2019; 

--5 
select NationalIDNumber,LoginID,JobTitle
from HumanResources.Employee

--6 
select Title,FirstName,LastName 
from Person.Person
where Title='Ms' or LastName='Antrim'

--7
select SalesOrderID,ShipDate 
from Sales.SalesOrderHeader
where ShipDate between '2011-07-5' and '2011-07-11' 
 
--8 
select ProductID,Name 
from Production.Product
where StandardCost< 110.00

--10 
select * 
from Production.Product
where Name like 'B%'

--12
select OrderDate, SUM(TotalDue)
from Sales.SalesOrderHeader
where OrderDate BETWEEN '2011-07-1' AND '2011-07-31'
group by OrderDate
