-- *hr_employees --

select * from employees;
select * from salaries;
select * from dept_manager;
select * from titles;
select * from dept_emp; 
select * from departments;
  
-- equijoin (inner join)
 -- 현재 근무중인 직책이 Senior Engoneer이고 여자인 직원의 이름을출력하라 
select a.emp_no, a.first_name, b.title
  from employees a, titles b
 where a.emp_no = b.emp_no        -- 조인조건 
   and b.to_date = '9999-01-01'	  -- 선택조건1
   and b.title ='Senior Engineer' -- 선택조건2
   and a.gender = 'F'; 			  -- 선택조건3  
   
--
-- ANSI/ISO SQL의 조인
-- 

-- 이끼조인이랑 결과는같지만 방법을 다르게 

-- 1. natural join
	  select a.emp_no, a.first_name, b.title
		from employees a 
natural	join titles b
	   where b.to_date = '9999-01-01';

-- 2. on join 
	  select a.emp_no, a.first_name, b.title
		from employees a 
		join titles b
		  on a.emp_no = b.emp_no
	   where b.to_date = '9999-01-01';
       
-- 3. join ~using 
	  select a.emp_no, a.first_name, b.title
		from employees a 
		join titles b using(emp_no)
	   where b.to_date = '9999-01-01';
       
       
