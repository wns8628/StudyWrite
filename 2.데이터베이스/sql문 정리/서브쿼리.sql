-- *hr_employees --

-- subquery

-- ex1) Fai bale 이근무하는 부서에서 근무하는 직원의 사번, 이름출력 
 
select a.emp_no, b.dept_no
  from employees a, dept_emp b
 where a.emp_no = b.emp_no
   and concat(a.first_name, ' ', a.last_name) = 'Fai bale'
   and b.to_date = '9999-01-01';

-- 
select a.emp_no, a.first_name 
  from employees a, dept_emp b
 where a.emp_no = b.emp_no
   and b.dept_no = 'd004';
   
   
-- 결론
select a.emp_no, a.first_name 
  from employees a, dept_emp b
 where a.emp_no = b.emp_no
   and dept_no = (	select b.dept_no
					  from employees a, dept_emp b
					 where a.emp_no = b.emp_no
					   and concat(a.first_name, ' ', a.last_name) = 'Fai bale'
					   and b.to_date = '9999-01-01');
                       
-- ex2) 현재 전체사원의 평균 연봉보다 적은 급여를 받는 사원의 이름, 급여를 나타내세요
select a.first_name, b.salary 
  from employees a, salaries b
 where a.emp_no = b.emp_no
   and b.to_date = '9999-01-01'
   and salary < (select avg(salary) 
				   from salaries
				  where to_date='9999-01-01')
			   order by salary desc;
   
 
-- ex3) 급여를 구하라 
	select min(avg_salary)
      from ( select title, avg(a.salary) as avg_salary 
			   from salaries a, titles b , employees c
              where c.emp_no = a.emp_no 
			    and a.emp_no = b.emp_no  
                and a.to_date = '9999-01-01'
                and b.to_date = '9999-01-01'
		   group by title) a ;
   
-- 타이틀까지 같이 출력하고싶다. 
    select title, avg(a.salary) as avg_salary 
	  from salaries a, titles b 
	 where a.emp_no = b.emp_no  
	   and a.to_date = '9999-01-01'
	   and b.to_date = '9999-01-01'
  group by title having round(avg(a.salary)) = (  select round(min(avg_salary))
													from ( select title, avg(a.salary) as avg_salary 
															 from salaries a, titles b 
															where a.emp_no = b.emp_no  
															  and a.to_date = '9999-01-01'
															  and b.to_date = '9999-01-01'
														 group by title) a );                                                
 -- top k 로 풀기 
 select title, avg(a.salary) as avg_salary 
			   from salaries a, titles b , employees c
              where c.emp_no = a.emp_no 
			    and a.emp_no = b.emp_no  
                and a.to_date = '9999-01-01'
                and b.to_date = '9999-01-01'
		   group by title
           order by avg_salary asc
		      limit 0,1;
              
-- 다중행
-- any  
--   ( =any : in 이랑 완전 동일 ), >=any ,>any, <>any, ...등등
-- all  
--   =all, >=all ,>all, <>all, ...등등
-- ex) 현재급여가 5만이상인 직원이름 출력
select concat(first_name,' ',last_name) 
  from employees
 where emp_no = any( select emp_no 
				       from salaries 
					  where to_date= '9999-01-01' 
	                    and salary > 50000);
              
-- 서브쿼리로 풀기	+ 급여까지나오게		
select concat(a.first_name,' ',a.last_name), b.salary
  from employees a , salaries b
 where a.emp_no = b.emp_no
   and b.to_date = '9999-01-01'
   and (a.emp_no, b.salary) = any ( select emp_no,salary 
									 from salaries 
									where to_date= '9999-01-01' 
									  and salary > 50000);   
                        
-- 조인으로풀기  느리다
select concat(a.first_name,' ',a.last_name), b.salary
  from employees a,(select emp_no,salary 
					  from salaries 
					 where to_date= '9999-01-01' 
					   and salary > 50000) b 
 where a.emp_no = b.emp_no;
   
   
   
   