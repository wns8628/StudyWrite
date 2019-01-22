-- *hr_employees --

-- 현재날짜
select curdate(), current_date;

-- 현재시간
select curtime(), current_time;

-- 현재날짜 + 시간까지 출력
select now(), sysdate();
select emp_no, now() from employees; -- 처음실행되는시간 다똑같음 
select emp_no,sysdate() from employees; -- 이건 쿼리출력하면서 시간이 바뀜 출력할떄 시간정해짐 

-- 포맷팅 // 비즈니스조건에따라 포맷팅해서 보내던지 , 글로벌하면 타임스탬프에더더해서하는거지 
select first_name,
	   date_format(hire_date, '%Y년-%m월-%d일 %h시:%i분:%s초')
  from employees;

-- 각 직원들에 대해 직원의 이름과 근무개월수 period_diff (a,b) =  a-b 개월수반환 일걸
select first_name, concat(
						cast(
							period_diff(
										date_format(curdate(),'%Y%m'),
										date_format(hire_date,'%Y%m')
                                        )
					as char ), "개월" 
						)
       from employees;           
              
-- date_add()
                  
-- 각 사원은  입사 후 6개월 뒤에 정규직으로 발령이 된다. 
-- 발령날은 언제?
select first_name,
	   hire_date,
       date_add(hire_date, interval 6 month) -- interval표현식임  interval x month, year, day,week ..등등 
   from employees;

-- 내가 만일살면? 
select date_add( cast('19930810' as DATE), interval 9289 day);


-- ------------------------------------------
