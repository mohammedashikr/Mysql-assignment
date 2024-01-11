
-- Assignment1 
show databases;
create database Employeedeatils;
use Employeedeatils;

/*Question 1*/ 



create table EmployeeDetails (
    EmpId int primary key,
    FullName varchar(230),
    ManagerId int,
    DateOfJoining date,
    City varchar(250)
);
create table EmployeeSalary (
    EmpId int,
    Project varchar(225),
    Salary decimal(10, 2),
    Variable decimal(10, 2),
    foreign key  (EmpId) references EmployeeDetails(EmpId)
);

-- Question 2:SQL Query to fetch records that are present in one table but not in another table.

select* from EmployeeDetails where EmpId not in(select EmpId from EmployeeSalary);
select* from EmployeeSalary where EmpId not in(select EmpId from EmployeeDetails);

-- Question3:SQL query to fetch all the employees who are not working on any project.

select* from EmployeeDetails where EmpId not in(select EmpId from EmployeeSalary);

-- Question4:SQL query to fetch all the Employees from EmployeeDetails who joined in the Year 2020.

select* from EmployeeDetails where year(DateOfJoining)=2020;

-- Question5:Fetch all employees from EmployeeDetails who have a salary record in EmployeeSalary.

select ED.* from EmployeeDetails ED inner join EmployeeSalary ES on ED.EmpId =ES.EmpId;

-- Question6:Write an SQL query to fetch a project-wise count of employees.

select Project, count(EmpId) as EmployeeCount from EmployeeSalary group by Project;

-- Question7:Fetch employee names and salaries even if the salary value is not present for the employee.

select ED.FullName, coalesce(ES.Salary, 'Salary not recorded') as Salary from EmployeeDetails ED left join EmployeeSalary ES on ED.EmpId = ES.EmpId;

-- Question8:Write an SQL query to fetch all the Employees who are also managers.

select * from EmployeeDetails where EmpId in (select ManagerId from EmployeeDetails where ManagerId is not null);

-- Question9:Write an SQL query to fetch duplicate records from EmployeeDetails.
select EmpId, FullName, count(*) from EmployeeDetails group by EmpId, FullName having count(*) > 1;

-- Question10:Write an SQL query to fetch only odd rows from the table.

select * from (select *, row_number() over (order by EmpId) as rownum from EmployeeDetails) as SubQuery where rownum % 2 <> 0;


-- Question11:Write a query to find the 3rd highest salary from a table without top or limit keyword.

select distinct Salary from EmployeeSalary E1 where 3 = (select count(distinct Salary) from EmployeeSalary E2 where E1.Salary <= E2.Salary );
