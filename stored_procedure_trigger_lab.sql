use ITI
--1 stored procedure to show the number of students per department
create proc show_students_for_department
as 
begin
	select d.Dept_Name,count(*)
	from [dbo].[Department] d join [newschema].[Student] s
	on d.[Dept_Id]=s.[Dept_Id]
	group by d.Dept_Name
end
exec [dbo].[show_students_for_department]
------------------------------------------------------------------
------------------------------------------------------------------
--2 stored procedure that will  of employees in the project p1
use Net23_Company

create proc check_the_number(@count int output)
as
begin
	select @count= COUNT(p.projectNo)
	from [dbo].[Works_On] w join [dbo].[Employee] e
	on e.EmpNo=w.EmpNo join[dbo].[Project] p
	on p.projectNo=w.projectNo
	where w.projectNo=1
	group by  p.projectNo
end 

declare @noemp int
exec check_the_number
@count=@noemp output

if @noemp>=3
begin
	print 'The number of employees in the project p1 is 3 or more'
end
else 
begin
	print 'The number of employees in the project p1 is less than 3 '
	select p.projectNo,e.EmpFname+' '+e.EmpLname,p.ProjectName
	from [dbo].[Works_On] w join [dbo].[Employee] e
	on e.EmpNo=w.EmpNo join[dbo].[Project] p
	on p.projectNo=w.projectNo
	where w.projectNo=1
end
----------------------------------------------------------------
----------------------------------------------------------------
--3 stored procedure that will be used in case there is an old employee has left the project and a new one become instead of him
use [Net23_Company]
CREATE PROCEDURE UpdateWorksOn
    @oldEmpNumber INT,
    @newEmpNumber INT,
    @projectNumber INT
AS
BEGIN
    UPDATE works_on
    SET [EmpNo] = @newEmpNumber
    WHERE [EmpNo] = @oldEmpNumber
      AND [projectNo] = @projectNumber;
END;
exec UpdateWorksOn 2,2,1
------------------------------------------------------------------------
------------------------------------------------------------------------
--4 Create a trigger that prevents the insertion Process for Employee table in March 
use[AdventureWorks2019]
create trigger check_inserted_employee
on [HumanResources].[Employee]
instead of insert 
as
begin
	declare @hireing_month int
	select @hireing_month=month(i.HireDate)from inserted i
	if @hireing_month=3
	begin
	RAISERROR ('you should insert in month of march',16,1);
	end
end
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--5 Create a trigger to prevent anyone from inserting a new record in the Department table [ITI DB]
use ITI
 create trigger prevent_inserted
 on [dbo].[Department]
 instead of insert
 as
 begin
	RAISERROR('You are not authorized to insert a new record in the Department table.', 16, 1);
 end
 insert into Department
 values(5,'iti','intake','minya',1,getdate())
 -------------------------------------------------------------------------------
 -------------------------------------------------------------------------------
 --6 Create a trigger on student table after insert to add Row in Student Audit table 
 use [ITI]
 create table student_Audit(
	server_user_name varchar(60),
	modify_date date,
	Note varchar(500)
 )
 create trigger student_audiot
 on [newschema].[Student]
 after insert
 as 
 begin
 insert into student_Audit(server_user_name,modify_date,Note
 ) 
 select @@SERVERNAME,getdate(),concat('the user',i.[St_Fname],' ',i.St_Lname,' insert new row with id=',' ',i.St_Id,' in student table')from inserted as i
 end

 insert into [newschema].[Student] 
 values(14,'mohamed','atef','minya',24,10,6)

 select* from [dbo].[student_Audit]