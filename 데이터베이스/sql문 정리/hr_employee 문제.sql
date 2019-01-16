-- *hr_employees --

show tables;

select count(*) from employees;

select * from employees;	-- limit 2000,1000;
-- column heading alias , concat
select emp_no as '번호',
		concat(first_name,' ', last_name) as '성명',
       hire_date '입사일'
 from employees;

-- distinct
select distinct title from titles;

-- order by
select concat(first_name,' ', last_name) as '성명',
	   gender as '성별',
       hire_date '입사일'
 from employees
 order by hire_date;


-- 2001년 
select emp_no,  salary  
	from salaries
   where '2000-12-31' < from_date
     and from_date < '2002-01-01'
     order by salary desc;


-- 1991년
select concat(first_name,' ', last_name) as '이름',
		gender as '성별',
        hire_date as "입사일"
	from employees
    where hire_date < '1991-01-01'; 

-- 비교연산자 in
select emp_no, dept_no 
 from dept_emp
 where dept_no in('d005','d009');


select * from employees;
select * from salaries;
select * from dept_manager;
select * from titles;
select * from dept_emp; 
select * from departments;
-- 문제 

-- 1번
select last_name from employees where emp_no=10944;

-- 2번오름차순 , 별칭 ,선임부터출력
select last_name as "이름", gender as "성별", hire_date as "입사일" from employees ORDER BY hire_date asc ; 

-- 3번  남직원, 여직원수
select count(if(gender="M", gender, null)) as "남직원" , count(if(gender="F", gender, null)) as "여직원" from employees;

-- 4번 직원수 salaries 이용 
select count(emp_no) as "직원수" from salaries where to_date=(select max(to_date) from titles);

-- 5번  부서개수 
select count(*) from departments; 

-- 6번  부서매니저 몇명 역임매니저제외 = 9
select count(*) from dept_manager where to_date = (select max(to_date) from dept_manager);

-- 7.부서이름긴순
select dept_name as "부서명 이름긴순" from departments ORDER BY length(dept_name) desc; 

-- 8.급여 120000 이상  = 2159
select count(emp_no) from salaries where salary >= 120000 AND to_date = (select max(to_date) from titles); 

-- 9. 어떤직책들 이름긴순서
select distinct title from titles ORDER BY length(title) desc;

-- 10. 현재를기준으로 해야겠지 엔지니어 몇명? 
select count(*) from titles where title = "Engineer" AND to_date= (select max(to_date) from titles); 

-- 11번. 사번에 13250(zeydy)인직원의 직책변경상황 시간순 (가장최근이 위로 = 내림차순)
select * from titles where emp_no = 13250 ORDER BY to_date desc;



-- 2번문제------------------------------------------------------------------------------------------------

select * from employees;
select * from salaries;
select * from dept_manager;
select * from titles;
select * from dept_emp; 
select * from departments;


-- 1. 최고임금 최저임금
select max(salary) - min(salary) as "최고임금-최저임금" from salaries;

-- 2. 마지막 신입사원들어온날 date_format(curdate(),'%Y%m'
select date_format(max(hire_date), '%Y년 %m월 %d일') from employees;
-- 조인으로 현재에서 거름
select date_format(max(hire_date), '%Y년 %m월 %d일') 
from employees, salaries 
where employees.emp_no = salaries.emp_no and to_date = (select max(to_date) from titles);

select *
from employees, salaries
where employees.emp_no = salaries.emp_no and to_date = (select max(to_date) from titles)  limit 0,400000;

-- 3. 가장오래 근속한직원의 입사일
select min(hire_date) from employees;
-- select * from salaries where to_date= (select max(to_date) from titles);
-- 조인으로 현재다니는사람중에 가장오래 근속한직원의 입사일
select min(hire_date) from employees , salaries where employees.emp_no = salaries.emp_no and to_date = (select max(to_date) from titles);


-- 4.
select avg(salary) from salaries where to_date= (select max(to_date) from titles);

-- 5.
select max(salary), min(salary) from salaries where to_date= (select max(to_date) from titles);

-- 6
select (year(curdate()) - year(min(birth_date))), (year(curdate())-year(max(birth_date))) from employees;
-- 조인으로 현재에서 거름
select (year(curdate()) - year(min(birth_date))), (year(curdate())-year(max(birth_date))) 
from salaries, employees 
where employees.emp_no = salaries.emp_no and to_date = (select max(to_date) from titles);



-- 3. 조인 문제 ------------------------------------------------------------------------------------------------------

select * from employees;
select * from salaries;
select * from dept_manager;
select * from titles;
select * from dept_emp; 
select * from departments;

-- 1번 
  select a.emp_no as "사번", a.first_name as "이름", b.salary as "연봉"    
    from employees a, salaries b
   where a.emp_no = b.emp_no
     and b.to_date = '9999-01-01'
order by b.salary desc;
 
-- 2번 
  select a.emp_no as "사번",concat(a.last_name,' ',a.first_name), b.title as "직책"    
    from employees a, titles b
   where a.emp_no = b.emp_no 
     and b.to_date = '9999-01-01'
order by concat(a.first_name,' ',a.last_name);
	 
-- 3번
  select a.emp_no as "사번", a.first_name as "이름", c.dept_name as "부서"    
    from employees a, dept_emp b, departments c
   where a.emp_no = b.emp_no  
     and b.dept_no = c.dept_no   
     and b.to_date = '9999-01-01'
order by a.last_name;

-- 4번
  select a.emp_no as "사번", concat(a.last_name,' ',a.first_name) as "이름", b.salary as "연봉", c.title "직책", e.dept_name as "부서" 
    from employees a, salaries b, titles c, dept_emp d, departments e
   where a.emp_no = b.emp_no
     and a.emp_no = c.emp_no
	 and a.emp_no = d.emp_no
     and d.dept_no = e.dept_no
     and b.to_date = '9999-01-01'
     and c.to_date = '9999-01-01'
     and d.to_date = '9999-01-01'
order by a.last_name;    

-- 5번
 select a.emp_no as "사번", concat(a.last_name,' ',a.first_name) as "이름"
   from employees a, titles b 
  where a.emp_no =  b.emp_no 
    and b.title = 'Technique Leader'
    and b.to_date <> '9999-01-01';
    
-- 6번 
 select concat(a.first_name,' ',a.last_name) as "이름", d.dept_name as "부서", b.title as "직책"
   from employees a, titles b, dept_emp c, departments d
  where a.emp_no = b.emp_no
    and a.emp_no = c.emp_no
    and c.dept_no = d.dept_no 
    and b.to_date = '9999-01-01'
    and c.to_date = '9999-01-01'
    and a.last_name like 'S%'; 
	
-- 7번 
  select concat(c.first_name,' ',c.last_name) as "사원"
    from titles a, salaries b, employees c
   where a.emp_no = b.emp_no
     and b.emp_no = c.emp_no 
     and b.salary >= 40000
     and a.title = 'Engineer'
     and a.to_date = '9999-01-01'
	 and b.to_date = '9999-01-01'
order by b.salary desc;

-- 8번
  select a.title as "직책" , b.salary as "급여"
    from titles a, salaries b 
   where a.emp_no = b.emp_no
     and b.salary > 5000
	 and a.to_date = '9999-01-01'
	 and b.to_date = '9999-01-01'
order by b.salary desc;


-- 9번
  select c.dept_name , avg(a.salary)
    from salaries a, dept_emp b, departments c 
   where a.emp_no = b.emp_no
     and b.dept_no = c.dept_no
     and a.to_date = '9999-01-01'
     and b.to_date = '9999-01-01'	
group by c.dept_name 
order by avg(a.salary) desc;	

-- 10번 
  select b.title, avg(a.salary)
    from salaries a, titles b
   where a.emp_no = b.emp_no
     and a.to_date = '9999-01-01'
     and b.to_date = '9999-01-01'	
group by b.title
order by avg(a.salary) desc;

-- -------------------------------------------------------------------------------------------------
-- 4.서브쿼리 

-- 1번문제
select count(*) 
  from employees a, salaries b 
  where a.emp_no = b.emp_no 
    and b.to_date = '9999-01-01'
    and b.salary > (select avg(salary) 
					  from salaries
					 where to_date = '9999-01-01');

-- 2번문제 
 select  a.emp_no as "사번", concat(a.last_name,' ',a.first_name) as "이름", c.부서, c.연봉
   from employees a , salaries b , (select d.dept_name as "부서", max(b.salary) as "연봉" 
									  from employees a, salaries b,  dept_emp c, departments d
									 where a.emp_no = b.emp_no
									   and a.emp_no = c.emp_no
									   and c.dept_no = d.dept_no
									   and b.to_date = '9999-01-01'
									   and c.to_date = '9999-01-01'
								  group by d.dept_name
								  order by max(b.salary) desc) c
  where b.salary = c.연봉
    and a.emp_no = b.emp_no
    and b.to_date = '9999-01-01'
order by c.연봉 desc;













