-- *web db --

desc employee;
desc department;

insert 
  into department
values(null, '총무팀');
 
insert 
  into department
values(null, '인사팀');
 
 insert 
  into department
values(null, '개발팀');
 
select * from department;

desc employee;

insert
  into employee
values (null, '둘리', 1);

insert
  into employee
values (null, '마이콜', 2);

insert
  into employee
values (null, '또치', 3);

insert
  into employee
values (null, '길동', null);

select * from employee;
select * from employee a,department b where a.department_no = b.no;

-- outer join ---------------------------------

-- left outer join 
		 select a.name, b.name 
		   from employee a 
left outer join department b
			 on a.department_no = b.no;

-- left join on 아우터 뺴도됨
	  select a.name, ifnull(b.name, '없음') 
		from employee a 
   left join department b
	      on a.department_no = b.no;
		
-- right join on 
	select * 
	  from employee a 
right join department b
	    on department_no = b.no;
   

