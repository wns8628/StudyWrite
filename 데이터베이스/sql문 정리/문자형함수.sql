
-- MYSQL 문자열 함수

select ucase('Seoul'), upper('seoul');
select lcase('Seoul'), lower('SEOUL');

-- from을 비우지말고 from dual을 기본적으로 적어준다.
select substring('Happy Day', 3, 2) from dual;
select substring('first_name', 3, 2) from employees;

select first_name,
   gender,
    hire_date
    from employees
    where substring( hire_date, 1, 4) = '1989';
    
-- 빈자리 L 'hi' 앞에서부터, R 'hi' 뒤 빈자리
select LPAD('hi', 10, '*') from dual;
select RPAD('hi', 10, '*') from dual;

-- 문자  자리수 채울문자 cast = 형변환? 
select emp_no, LPAD(cast(salary as char), 10, ' ') from salaries;

-- trim 
-- 공백제거
select concat('-------', ltrim(' hello   '), '-----------'),
	   concat('-------', rtrim('    hello    '), '----------'),
       concat('---', trim('   hello   '), '-----');

select trim(both 'x' from 'xxxhixxx'),
       trim(leading 'x' from 'xxxhixxx'),
	   trim(trailing 'x' from 'xxxhixxx');