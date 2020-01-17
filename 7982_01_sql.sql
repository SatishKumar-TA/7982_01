/* Answers for Module1 */
/* 1Ans */
create database training; 

/* 2Ans */
use training; 
create table demography
(
CustID int PRIMARY KEY auto_increment,
Name varchar(50),
Age int,
Gender varchar(1)
);

/* 3Ans */  
insert into demography values(1,'John',25,'M');

/* 4Ans */
insert into demography 
(Name,Age,Gender) 
values 
('Pawan',26,'M'),
('Hema',28,'F');

/* 5Ans */
insert into demography 
(Name,Gender) 
values 
('Rekha','F');

/* 6Ans */
select * from demography;

/* 7Ans */
update demography 
set Age=NULL 
where Name='John';

/* 8Ans */
select * from demography where Age=NULL;

/* 9Ans */
delete from demography;

/* 10Ans */
drop table demography;


use sat;

/* Answers for Module2 */
/* 1Ans */
select 
account_id, cust_id, avail_balance 
from 
account 
where 
status='ACTIVE' and avail_balance > 2500;

/* 2Ans */
select * from account where year(open_date) = '2002';

/* 3Ans */
select 
account_id, avail_balance,pending_balance 
from 
account 
where 
avail_balance <> pending_balance;

/* 4Ans */
select 
account_id,product_cd 
from 
account 
where 
account_id in (1,10,23,27);

/* 5Ans */
select 
account_id,avail_balance 
from 
account 
where 
avail_balance between 100 and 200;




/* Answers for Module3 */
/* 1Ans */
select count(*) from account;

/* 2Ans */
select * from account limit 2;

/* 3Ans */
select * from account limit 2,2;

/* 4Ans */
select 
year(birth_date), month(birth_date), day(birth_date), weekday(birth_date)
from 
individual;

/* 5Ans */
select substring('Please find the substring in this string',17,9);

/* 6Ans */
select sign(25.76823);
select round(25.76823);

/* 7Ans */
select date_add(curdate(), INTERVAL 30 day);

/* 8Ans */
select 
left(fname,3),
right(lname,3)
from 
individual;

/* 9Ans */
select 
ucase(fname)
from
individual 
where length(fname)=5;

/* 10Ans */
select 
max(avail_balance), 
avg(avail_balance)
from
account
where
cust_id=1;




/* Answers for Module4 */
/* 1Ans */
select 
cust_id, count(*) as number_of_accounts 
from 
account 
group by 
cust_id;

/* 2Ans */
select 
cust_id, count(*) as number_of_accounts
from 
account 
group by 
cust_id
having 
count(*) > 2;

/* 3Ans */
select 
fname, birth_date 
from
individual
order by 
birth_date
desc;

/* 4Ans */
select 
year(open_date), avg(avail_balance)
from
account
group by 
year(open_date)
having
avg(avail_balance) > 2000
order by 
year(open_date);

/* 5Ans */  
select 
product_cd, max(pending_balance)
from
account
where
product_cd in ('CHK', 'SAV', 'CD')
group by 
product_cd;




/* Answers for Module5 */
/* 1Ans */
select 
fname, title, name 
from 
employee join department
on 
employee.dept_id = department.dept_id;

/* 2Ans */
select 
product_type.name, product.name
from
product_type left join product
on product_type.product_type_cd=product.product_type_cd;

/* 3Ans */
select 
concat(a.fname,' ',a.lname) as employee_name,
concat(b.fname,' ',b.lname) as superior_name
from
employee a join employee b
on 
a.superior_emp_id = b.emp_id;

/* 4Ans */
select  
fname,lname
from 
employee
where
superior_emp_id =
(select emp_id from employee
where fname='Susan' and lname='Hawthorne');

/* 5Ans */
select 
fname,lname
from 
employee
where
emp_id in
(select superior_emp_id from employee
where dept_id=1);


