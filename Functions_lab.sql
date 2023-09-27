--3
--1 task one inline tabled-valued function that return all employees names, titles in AdventureWorks database
use AdventureWorks2019
create function number_betweens(@start_index int ,@end_index int)
returns @resualt table(value int)
as
begin
	while @start_index<@end_index-1
	begin
		set @start_index=@start_index+1
		insert into @resualt(value) 
		values(@start_index)
	end
	return
end
select * from number_betweens(1,6)

--2 task two inline tabled-function that returns Employees name, title, Marital status, Gender (Contact Table in AdventureWorks).
use AdventureWorks2019
create function dispaly_employes_info()
returns table
as
return(
	select p.FirstName+' '+p.MiddleName+' '+p.LastName as 'Employees name',p.Title,e.Gender,e.MaritalStatus
	from [Person].[Person]p join [HumanResources].[Employee] e
	on e.BusinessEntityID=p.BusinessEntityID
	
)

select *  
from dispaly_employes_info()

select [Employees name],
	isnull( Title, 'NotProvided') as title
	,
	case 
		when [MaritalStatus]='m' then 'married' 
		when [MaritalStatus]='s' then 'single'
	end	as MaritalStatus,
	case 
		when [Gender]='f' then 'fmale' 
		when [Gender]='m' then 'male' 
	end	as Gender
from dispaly_employes_info()

-- task three inline tabled-valued function that return all employees names, titles in AdventureWorks database and thier experience years of work 
create function dispaly_employees_experience_years()
returns table
as
return(
	select concat(p.FirstName,' ',p.MiddleName,' ',p.LastName) as 'Employees name',
	e.JobTitle,
	DATEDIFF(YEAR,e.[HireDate],GETDATE()) as 'Experience-Years',
	dateadd(year,21,e.BirthDate) as 'Graduation-Date'
	from [Person].[Person]p join [HumanResources].[Employee] e
	on e.BusinessEntityID=p.BusinessEntityID	
)
select * from dispaly_employees_experience_years()

--task four scalar function that calculates the net salary 
create function Calc_Net_Salary
(
	@salaery int,
	@ExperienceYears int
)
returns decimal
as 
begin
	declare @netSalary decimal;
	declare @increasedmount decimal;
	declare @maximumIncrease decimal;
	set @maximumIncrease = @salaery*0.7*@ExperienceYears;
	set @increasedmount=@salaery*0.1*@ExperienceYears;
	set @netSalary=
	case when @increasedmount<@maximumIncrease then @salaery+@increasedmount 
	else @salaery+@maximumIncrease
	end
	return @netSalary
end

select dbo.calc_net_salary(5000,4) as 'NetSalary'

--5 Create function return the highest 10 salary in this department
create function get_top_employee_sallry(@depId int)
returns table
as
return(
	SELECT top 10 d.DepartmentID,dd.Name,eph1.BusinessEntityID,concat(p.FirstName,' ',p.MiddleName,' ',p.LastName) as 'Employees name' ,Rate 
	FROM HumanResources.EmployeePayHistory AS eph1 join [Person].[Person] p
	on eph1.BusinessEntityID=p.BusinessEntityID
	join [HumanResources].[EmployeeDepartmentHistory] d 
	on eph1.BusinessEntityID=d.BusinessEntityID join [HumanResources].[Department] dd
	on dd.DepartmentID=d.DepartmentID
	WHERE RateChangeDate = (SELECT MAX(RateChangeDate)   
							FROM HumanResources.EmployeePayHistory AS eph2  
							WHERE eph1.BusinessEntityID = eph2.BusinessEntityID) and d.DepartmentID = @depId 
	ORDER BY BusinessEntityID
)
select * from get_top_employee_sallry(2)