--multi_statment table-valued function
--return a new table as a result of insert statment 
create function student_names(@format nvarchar(50)) 
returns @t table
		(
		 student_id int primary key,
		 student_name nvarchar(50)
		)
as
begin
	if (@format='fullname') 
		insert into @t
		select st_id,st_fname+' '+st_lname 
		from ITI.dbo.student
	else
	if (@format='firstname')
		insert  into @t
		select st_id,st_fname
		from ITI.dbo.student

return
end

select * from student_names('fullname')

select * from student_names('firstname')
--where student_id>10

select student_id,student_name from student_names('firstname')
