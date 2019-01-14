select * from employees;
select * from salaries;
select * from dept_manager;
select * from titles;
select * from dept_emp; 
select * from departments;


-- 1번
select last_name from employees where emp_no=10944;

-- 2번오름차순 , 별칭 ,선임부터출력
select last_name as "이름", gender as "성별", hire_date as "입사일" from employees ORDER BY hire_date asc ; 

-- 3번  남직원, 여직원수
select count(if(gender="M", gender, null)) as "남직원" , count(if(gender="F", gender, null)) as "여직원" from employees;

-- 4번 직원수 salaries 이용
select count(Distinct emp_no) as "직원수" from salaries;

-- 5번  부서개수 
select count(*) from departments; 

-- 6번  부서매니저 몇명 역임매니저제외
select count(*) from dept_manager where to_date = (select max(to_date) from dept_manager);

-- 7.부서이름긴순
select dept_name as "부서명 이름긴순" from departments ORDER BY length(dept_name) desc; 

-- 8.급여 120000 이상  = 2288
select count(distinct emp_no) from salaries where salary >= 120000;  

-- 9. 어떤직책들 이름긴순서
select distinct title from titles ORDER BY length(title) desc;

-- 10. 엔지니어 몇명? 
select count(*) from titles where title = "Engineer";

-- 11번. 사번에 13250(zeydy)인직원의 직책변경상황 시간순 (가장최근이 위로 = 내림차순)
select * from titles where emp_no = 13250 ORDER BY to_date desc;
