-- 1 - task one create Net23-company database
use master;
create database Net23_Company
on primary(
	name='Net23_Company_Data',
	--file name defualt
	filename='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Net23_Company_Data.mdf',
	size=10MB,
	maxsize=40MB,
	filegrowth=10
)log on(
	name='Net23_Company_Log',
	--file name defualt
	filename='C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Net23_Company_Log.ldf',
	size=5MB,
	maxsize=40MB,
	filegrowth=10
)

-- 2.1- task two create table with following constarints 
use Net23_Company
create table Department(
	DeptNo int ,
	DepartName nvarchar(20) not null,
	
	Location Nchar(2) not null default 'Ny', --make defualt value
	--make primary key for DeptNo
	constraint DeptNo_pk primary key(DeptNo),
	-- check the value of location 
	constraint Location_ck check(Location='NY' or Location='Ds' or Location='kw')  
)
-- 2.2- create the following data
use Net23_Company;

--2.2-a employee table
create table Employee(
	EmpNo int identity(1,1) ,
	EmpFname varchar(20) not null,
	EmpLname varchar(20) not null,
	DepNo int, --forign key
	salary decimal(7,2) not null

	constraint EmpNo_pk primary key(EmpNo),
	constraint DepNo_fk foreign key(DepNo) references Department(DeptNo),
	constraint salary_uniq unique (salary),
	constraint salary_ck check (salary >6000 and salary<7000)
)

--2.2-b project table
create table Project(
	projectNo Nchar(2) primary key,
	ProjectName varchar(20) not null,
	Budget int
)

--2.2-c works table 
create table Works_On(
	projectNo Nchar(2), --primary key
	EmpNo int, --primary key
	Jop varchar(15),
	Enter_Date date not null default(getdate()), --have the system date value 
	
	constraint Project_pk primary key (projectNo,EmpNo),
	constraint projNo_fk foreign key (projectNo) references Project(projectNo),
	constraint empNo_fk foreign key (EmpNo) references Employee(EmpNo)
)

-- 3-task three 
-- add phone column to employee table
alter table Employee
add TelephoneNumber int;

-- add phone column to employee table
alter table Employee
drop column TelephoneNumber

