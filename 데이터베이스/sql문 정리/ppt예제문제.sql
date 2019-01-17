-- *hr_employees --

-- 예제5 
   select title, avg(b.salary), count(*) as 'cnt'
     from employees a, salaries b, titles c
    where a.emp_no = b.emp_no
      and a.emp_no = c.emp_no
      and b.to_date = '9999-01-01'
      and c.to_date = '9999-01-01'
 group by c.title
   having cnt > 100;
   
-- 예제6
   select d.dept_name, avg(e.salary)
     from employees a, dept_emp b, titles c, departments d, salaries e
    where a.emp_no = b.emp_no
      and a.emp_no = c.emp_no
	  and a.emp_no = e.emp_no
      and b.dept_no = d.dept_no
      and b.to_date = '9999-01-01'
      and c.to_date = '9999-01-01'
      and e.to_date = '9999-01-01'
	  and c.title = 'Engineer'
 group by d.dept_name;      
   
   
-- 예제7 
  select b.title, sum(c.salary)
     from employees a, titles b, salaries c
    where a.emp_no = b.emp_no
      and a.emp_no = c.emp_no
      and b.to_date = '9999-01-01'
      and c.to_date = '9999-01-01'
	  and b.title != 'Engineer'
 group by b.title
   having sum(c.salary) > 2000000000
 order by sum(c.salary) desc;         
 
 
-- 이끼조인 실습1 
   select a.emp_no , concat(a.last_name,' ',a.first_name) as "이름" , c.dept_name 
     from employees a , dept_emp b , departments c 
	where a.emp_no= b.emp_no
      and b.dept_no = c.dept_no 
	  and b.to_date = '9999-01-01';
	  
-- 이끼조인 실습2
   select a.emp_no , concat(a.last_name,' ',a.first_name) as "이름" , b.salary
     from employees a , salaries b 
    where a.emp_no= b.emp_no
      and b.to_date = '9999-01-01';
      
      
      

 
 