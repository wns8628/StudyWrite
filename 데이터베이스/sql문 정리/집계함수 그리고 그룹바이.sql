-- 집계함수(통계)
select emp_no, avg(salary), sum(salary)
	from salaries
group by emp_no;

-- 최저임금 최대임금 받은시기 각각출력 ㄱ

-- 1) 애를 테이블로봐라
select max(salary) as max_salary,
	   min(salary) as min_salary
  from salaries;
-- 2)
select salary, from_date
  from salaries
where emp_no = 10060;

-- 결론 1) + 2) 
select *
  from ( select max(salary) as max_salary,
			    min(salary) as min_salary
		   from salaries where emp_no = 10060) a;
           
           
-- 사원별 직책변경몇번인지 
   select emp_no,count(*) 
	 from titles
 group by emp_no;

-- 각사원별 평균연봉
   select emp_no, avg(salary) 
	 from salaries
 group by emp_no 
   having avg(salary) > 50000;
   
   
   