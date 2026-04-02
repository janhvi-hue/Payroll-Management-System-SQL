CREATE DATABASE PayrollDB;
USE PayrollDB;

#Table1 departments
CREATE TABLE Departmnts (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

INSERT INTO Departmnts VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Sales');

#Table2 employees
CREATE TABLE Employs (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    designation VARCHAR(50),
    basic_salary INT,
    join_date DATE,
    FOREIGN KEY (dept_id) REFERENCES Departmnts(dept_id)
);

INSERT INTO Employs VALUES
(101, 'Amit Sharma', 2, 'Software Engineer', 50000, '2022-06-15'),
(102, 'Neha Verma', 1, 'HR Executive', 40000, '2021-03-10'),
(103, 'Rahul Mehta', 3, 'Accountant', 45000, '2020-01-20'),
(104, 'Priya Singh', 2, 'Data Analyst', 55000, '2023-02-05'),
(105, 'Karan Patel', 4, 'Sales Manager', 60000, '2019-11-25');


#Table3 payroll
CREATE TABLE Payroll (
    payroll_id INT PRIMARY KEY,
    emp_id INT,
    month VARCHAR(15),
    allowances INT,
    deductions INT,
    FOREIGN KEY (emp_id) REFERENCES Employs(emp_id)
);

INSERT INTO Payroll VALUES
(1, 101, 'January', 5000, 2000),
(2, 102, 'January', 4000, 1500),
(3, 103, 'January', 4500, 1800),
(4, 104, 'January', 6000, 2500),
(5, 105, 'January', 7000, 3000);

select * from departmnts;
select * from employs;
select * from payroll;

select e.emp_name,
d.dept_name
from employs e 
join departmnts d 
on e.dept_id = d.dept_id
where d.dept_name = "IT";

select emp_name, designation from employs;

select emp_id, emp_name from employs
where basic_salary > 45000;

select * from payroll
where month = 'January';

select distinct designation from employs;

select emp_name from employs
where join_date > "2021-12-31";

select count(emp_id) from employs;

select emp_name from employs order by emp_name asc;

#j
select e.emp_name,
d.dept_name
from employs e 
join departmnts d 
on e.dept_id = d.dept_id
where dept_name = "Sales";

select e.emp_name,
d.dept_name
from employs e 
join departmnts d 
on e.dept_id = d.dept_id;

select e.emp_name,
d.dept_name,
e.basic_salary
from employs e 
join departmnts d 
on e.dept_id = d.dept_id
order by e.basic_salary desc;

select e.emp_name,
e.basic_salary,
pr.allowances,
pr.deductions
from employs e 
join payroll pr 
on e.emp_id=pr.emp_id;

select e.emp_name,
d.dept_name,
pr.allowances,
pr.deductions
from employs e
join departmnts d on e.dept_id = d.dept_id
join payroll pr on e.emp_id = pr.emp_id;

select e.emp_name,
e.basic_salary
from employs e 
left join payroll pr 
on e.emp_id=pr.emp_id
where pr.emp_id is null ;

select e.emp_name,
d.dept_name
from employs e 
inner join departmnts d 
on e.dept_id = d.dept_id;

select e.emp_name,
d.dept_name
from employs e 
left join departmnts d 
on e.dept_id = d.dept_id;

select e.emp_name ,
pr.month
from employs e
join payroll pr 
on e.emp_id = pr.emp_id;

select e.emp_name, e.designation,
d.dept_name 
from employs e 
join departmnts d 
on e.dept_id = d.dept_id;

select d.dept_name,
e.emp_name
from departmnts d 
left join employs e 
on d.dept_id = e.dept_id
order by d.dept_id;

#c
create view view_net_salary as
select e.emp_name,
e.basic_salary,
pr.allowances,
pr.deductions,
(e.basic_salary + pr.allowances - pr.deductions) as net_salary
from employs e 
join payroll pr 
on e.emp_id=pr.emp_id;

select emp_name , net_salary from view_net_salary;

select emp_name , net_salary 
from view_net_salary
where net_salary > 55000;

select sum(e.basic_salary + pr.allowances - pr.deductions) as total_salary
from employs e 
join payroll pr 
on e.emp_id=pr.emp_id
where month = 'January'; 

select max(net_salary) from view_net_salary;

select min(net_salary) from view_net_salary;

select avg(basic_salary) from employs;

select d.dept_name,
sum(pr.deductions) as total_deduction
from departmnts d
join employs e 
on e.dept_id = d.dept_id 
join payroll pr
on pr.emp_id = e.emp_id
group by d.dept_name;

select sum(allowances) from payroll;

select max(basic_salary) - min(basic_salary) as salarydiff 
from employs;

#g
select d.dept_name,
count(e.emp_id)
from employs e 
join departmnts d 
on e.dept_id = d.dept_id
group by d.dept_name;

select d.dept_name,
avg(e.basic_salary)
from employs e 
join departmnts d 
on e.dept_id = d.dept_id
group by d.dept_name;

select d.dept_name,
sum(e.basic_salary + pr.allowances - pr.deductions) as total_salary_paid
from employs e 
join departmnts d
on e.dept_id = d.dept_id
join payroll pr 
on pr.emp_id = e.emp_id
group by d.dept_name; 

select designation,
count(emp_id)
from employs
group by designation;

select d.dept_name,
sum(pr.allowances)
from departmnts d 
join employs e on d.dept_id = e.dept_id
join payroll pr on e.emp_id = pr.emp_id
group by d.dept_name;

SELECT 
d.dept_name,
COUNT(e.emp_id) AS employee_count
FROM departmnts d
JOIN employs e
ON d.dept_id = e.dept_id
GROUP BY d.dept_name
HAVING COUNT(e.emp_id) > 1;

select d.dept_name,
sum(pr.deductions)
from departmnts d 
join employs e on d.dept_id = e.dept_id
join payroll pr on e.emp_id = pr.emp_id
group by d.dept_name;

select d.dept_name,
avg(e.basic_salary) as avg_salary
from employs e 
join departmnts d 
on e.dept_id = d.dept_id
group by d.dept_name
order by avg_salary desc;

select month,
count(*) as total_record
from payroll
group by month
order by month;

select d.dept_name,
max(e.basic_salary) as max_salary
from departmnts d 
join employs e on d.dept_id = e.dept_id
group by d.dept_name;

#cs
select emp_name,
basic_salary,
case when basic_salary < 45000 then 'low'
when basic_salary between 45000 and 55000 then 'medium'
else 'high'
end as salary_category
from employs;

SELECT 
CASE WHEN basic_salary < 45000 THEN 'Low'
WHEN basic_salary BETWEEN 45000 AND 55000 THEN 'Medium'
ELSE 'High'
END AS salary_category,
COUNT(*) AS employee_count
FROM employs
GROUP BY salary_category;

select emp_name,
basic_salary,
case when basic_salary > 50000 then 'Eligible'
else 'Not Eligible'
end as bonus_category
from employs;

select emp_name,
pr.deductions,
case when pr.deductions > 2500 then 'High'
else 'Low'
end as deduction_category
from employs e 
join payroll pr
on e.emp_id = pr.emp_id;







