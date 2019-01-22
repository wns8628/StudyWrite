-- SET SQL_SAFE_UPDATES =0;

desc employee;

select * from employee;

insert into employee(name,no,department_no) values('test2',null,null);

insert into employee values(null,'test2',null);

insert into employee(name) values ('test2');

select * from employee;

update employee 
   set name = '도우넛',
	   department_no = 1 
 where no = 5 ;

delete from employee 
	  where name = 'test2';

