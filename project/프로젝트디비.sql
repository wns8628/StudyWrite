
SET SQL_SAFE_UPDATES =0;

-- 루트에서하세요~ 
drop database bookmall;
-- db생성
create database quicksilver_douzone;
create user 'quicksilver'@'%' identified by 'root12'; 
grant all privileges on quicksilver_douzone.* to 'quicksilver'@'%'; 
grant all privileges on *.* to 'quicksilver'@'%' identified by 'root12';

show databases;

show tables;

select * from master_group;
select * from company;
select * from departments;
select * from employees;
select * from user;

delete from master_group;
delete from company;
delete from departments;
delete from employees;


insert into master_group values(null,'QuickSilver');
insert into user values(null,'quicksilver','quicksilver@quicksilver','root12','ADMIN'); 

-- 
insert into departments values(null,'부서1'    ,1, 1, 1, 1);
insert into departments values(null,'부서1-1'  ,1, 2, 2, 1);
insert into departments values(null,'부서1-2'  ,1, 3, 2, 1);
insert into departments values(null,'부서1-2-1',1, 4, 3, 1);

insert into departments values(null,'부서2'    ,2, 1, 1, 1);
insert into departments values(null,'부서2-1'  ,2, 2, 2, 1);
insert into departments values(null,'부서2-2'  ,2, 3, 2, 1);

insert into departments values(null,'부서3'    ,3, 1, 1, 1);
insert into departments values(null,'부서3-1'  ,3, 2, 2, 1);
insert into departments values(null,'부서3-2'  ,3, 3, 2, 1);



insert into company values(null,'더 존비즈온',1);
insert into departments values(null,'부서1'    ,1, 1, 1, 2);
insert into departments values(null,'부서1-1'  ,1, 2, 2, 2);
insert into departments values(null,'부서1-2'  ,1, 3, 2, 2);
insert into departments values(null,'부서1-2-1',1, 4, 3, 2);

insert into departments values(null,'부서2'    ,2, 1, 1, 2);
insert into departments values(null,'부서2-1'  ,2, 2, 2, 2);
insert into departments values(null,'부서2-2'  ,2, 3, 2, 2);

insert into departments values(null,'부서3'    ,3, 1, 1, 2);
insert into departments values(null,'부서3-1'  ,3, 2, 2, 2);
insert into departments values(null,'부서3-2'  ,3, 3, 2, 2);




select * from master_group;
select * from company;
select * from departments;
select * from employees;
select * from user;


select no,name,group_no from company;


select no,name,g_no,o_no,depth,company_no from departments;


  select a.no, a.name, a.g_no, a.o_no, a.depth, a.company_no, a.parents
    from departments a, company b 
   where a.company_no = b.no
order by a.g_no asc, a.o_no asc;


alter table departments add parents text;
alter table employees add phone text;


update departments set parents = 18 where no = 19;
update departments set parents = 18 where no = 20;



delete from departments where no= 21;

select * from departments;

SELECT @rank:=0;
UPDATE departments SET no=@rank:=@rank+1 ORDER BY no;


-- -----------------------------------------------------------------------------------------------------


-- 직원의 모회사,자회사 직원의 부서, 직원의 부모부서, 직원의 정보들 (이름,계급,나이,성별) 
EXPLAIN select a.no as 사원번호, a.name as 이름, a.age as 나이, a.gender, a.grade as 직급, b.name as 부서, c.name as 자회사, d.name as 모회사, a.phone as 전화번호
  from employees a, departments b, company c, master_group d
 where a.departments_no = b.no
   and b.company_no = c.no
   and c.group_no = d.no;


select * from master_group;
select * from company;
select * from departments;
select * from employees;
select * from user;


-- ----------------------------------------------
-- 처음 시간 테스트 하고 난 뒤 
-- 직원테이블의 이름에 클러스터 걸고 , 부서이름에도 클러스터걸고
-- 전화번호로 논 클러스터 인덱스 만들고 
-- 두번째 테스트 ㄱ 

-- . 추가하여 만들기
 -- CREATE INDEX <인덱스명> ON <테이블명> ( 칼럼명1, 칼럼명2, ... );
-- . 인덱스 삭제
 -- ALTER TABLE <테이블명> DROP INDEX <인덱스명>;
 
create index idx_ename on employees(name);
create index idx_dname on departments(name);

ALTER TABLE employees DROP INDEX idx_ename;

SHOW INDEX FROM employees;
SHOW INDEX FROM departments;
SHOW INDEX FROM company;


-- -----------------------------------------------------------------------------------------------

show tables;

create index idx_testname on fakenames(name);
ALTER TABLE fakenames DROP INDEX idx_testname;
SHOW INDEX FROM fakenames;
select * from fakenames where name = 'Cedric';





select count(*) from employees;
select * from employees;

select a.no as 사원번호, a.name as 이름, a.age as 나이, a.gender, a.grade as 직급, b.name as 부서, c.name as 자회사, d.name as 모회사, a.phone as 전화번호
  from employees a, departments b, company c, master_group d
 where a.departments_no = b.no
   and b.company_no = c.no
   and c.group_no = d.no
   and a.name like '%joe%';
   
select name from employees where name='joe';

-- ------------------------------------------------------------------------------------

select * from company;
select * from departments; -- where p_no = -1 limit 0, 100000;
select * from dept_com;
select * from dept_emp;
select * from dept_manager;
select * from employees;
select * from grade;
select * from grade_emp;
select * from masterGroup;
select * from salaries;
-- --------------------------------------------------------------
 

-- --------------------------------------------------------------
-- 검색
	select a.no as no,
		   a.profile as profile,
           a.name as name,
           a.age as age,
           a.gender as gender,
           c.name as grade,
           a.email as email,
           a.phone as phone,
           e.name as departments
	  from employees a, grade_emp b, grade c, dept_emp d, departments e 
	 where a.no = b.emp_no
       and c.no = b.grade_no
       and a.no = d.emp_no
       and e.no = d.departments_no
       and b.to_date = '9999-01-01'
       and d.to_date = '9999-01-01'
       and a.name = 'so';



-- 팀장뽑기  	
select emp_no, b.name
  from dept_manager a, employees b 
 where a.emp_no = b.no
   and departments_no = 3
   and a.to_date = '9999-01-01';
 
select * from dept_manager;
select count(*) from dept_manager;


-- 위에보일것 - 왼쪽 부서 클릭시 나올 정보들
	select a.no as no,
		   a.profile as profile,
           a.name as name,
           a.age as age,
           a.gender as gender,
           c.name as grade,
           a.email as email,
           a.phone as phone,
           e.name as departments
	  from employees a, grade_emp b, grade c, dept_emp d, departments e 
	 where a.no = b.emp_no
       and c.no = b.grade_no
       and a.no = d.emp_no
       and e.no = d.departments_no
       and b.to_date = '9999-01-01'
       and d.to_date = '9999-01-01'
       and d.departments_no = 3;
       
-- 개수 10만개나와야 정상
	select count(*)
	  from employees a, grade_emp b, grade c, dept_emp d, departments e 
	 where a.no = b.emp_no
       and c.no = b.grade_no
       and a.no = d.emp_no
       and e.no = d.departments_no
       and b.to_date = '9999-01-01'
       and d.to_date = '9999-01-01';       
 
-- --------------------------------------------------
       
-- 자세히 보일것 
	select a.no as no,
		   a.profile as profile, 
		   a.name as name,
           a.age as age,
           a.gender as gender,
           d.name as grade,
           a.address as address,
           a.resident_num as residentNum,
           a.email as email,
           a.phone as phone , 
           b.salary as salary,
           f.name as departments,
           h.name as company,
		   i.name as masterGroup
	  from employees a, salaries b, grade_emp c, grade d, dept_emp e, departments f, dept_com g, company h, masterGroup i
	 where a.no = b.emp_no
       and a.no = c.emp_no
       and d.no = c.grade_no
       and a.no = e.emp_no
       and f.no = e.departments_no
       and f.no = g.departments_no
       and h.no = g.company_no
       and i.no = h.mastergroup_no
       and b.to_date = '9999-01-01'
       and c.to_date = '9999-01-01'
       and e.to_date = '9999-01-01'
       and g.to_date = '9999-01-01'
	   and e.departments_no = 3;
		
        
	-- 개수 10만개 나와야 정상
	select count(*)
		  from employees a, salaries b, grade_emp c, grade d, dept_emp e, departments f, dept_com g, company h, masterGroup i
		 where a.no = b.emp_no
		   and a.no = c.emp_no
		   and d.no = c.grade_no
		   and a.no = e.emp_no
		   and f.no = e.departments_no
		   and f.no = g.departments_no
		   and h.no = g.company_no
		   and i.no = h.mastergroup_no
		   and b.to_date = '9999-01-01'
		   and c.to_date = '9999-01-01'
		   and e.to_date = '9999-01-01'
		   and g.to_date = '9999-01-01'
		   limit 0, 100000;



-- delete from dept_emp;
-- alter table dept_emp auto_increment=1;

  select count(*) from employees;
  select count(*) from dept_emp;


--
use quicksilver_douzone;


show databases;
show tables;  

-- 모회사(그룹)
select * from t_co_group;
select * from t_co_groupping;
select * from t_co_groupping_comp;
select * from t_co_groupping_comp_history;

-- 회사
select * from t_co_comp;
select * from t_co_comp_duty_position;
select * from t_co_comp_duty_position_multi; -- t_co_comp_duty_position_multi
select * from t_co_comp_duty_position_multi_history;
select * from t_co_comp_multi;
select * from t_co_comp_multi_history;

-- 사업장 
select * from t_co_biz;
select * from t_co_biz_history;
select * from t_co_biz_multi;
select * from t_co_biz_multi_history;

-- 부서
select * from t_co_dept;
select * from t_co_dept_histor;
select * from t_co_dept_multi;

-- 직원
select count(*) from t_co_emp;
select * from t_co_emp;
select * from t_co_emp_comp;
select * from t_co_emp_comp_history;
select * from t_co_emp_dept; 			-- 
select * from t_co_emp_dept_history;
select * from t_co_emp_dept_multi;	    --  
select * from t_co_emp_dept_multi_history;
select * from t_co_emp_history;
select * from t_co_emp_multi;			-- t_co_emp_multi ,t_co_comp_duty_position_multi
select * from t_co_emp_multi_history;


select count(distinct(emp_seq)) from t_co_emp_dept;


select c.comp_name as compName, count(b.comp_seq) as compEmpCount
  from t_co_emp_dept a, t_co_comp b, t_co_comp_multi c
 where a.comp_seq = b.comp_seq 	
   and b.comp_seq = c.comp_seq
   and c.lang_code = 'kr'
 group by b.comp_seq;
 
 -- 메인 자회사별 바차트 
 select c.comp_name as compName, count(distinct(a.emp_seq)) as compEmpCount
		  from t_co_emp_dept a, t_co_comp b, t_co_comp_multi c
		 where a.comp_seq = b.comp_seq 	
		   and b.comp_seq = c.comp_seq
		   and c.lang_code = 'kr'
		 group by b.comp_seq;

-- main info
select distinct(b.group_name) as groupName, d.total_comp as totalComp, e.total_biz as totalBiz, f.total_dept as totalDept,count(a.emp_seq) as totalEmp, count(distinct(a.emp_seq)) as allEmp, c.age_10 as age10, c.age_20 as age20, c.age_30 as age30, c.age_40 as age40, c.age_50 as age50, c.age_60 as age60
  from t_co_emp_dept a, t_co_group b, (select a.group_seq, 
										sum(if(date_format(now(),'%Y')-substring(bday,1,4) between 10 and 19 , 1, 0)) as age_10,
										sum(if(date_format(now(),'%Y')-substring(bday,1,4) between 20 and 29 , 1, 0)) as age_20,
										sum(if(date_format(now(),'%Y')-substring(bday,1,4) between 30 and 39 , 1, 0)) as age_30,
										sum(if(date_format(now(),'%Y')-substring(bday,1,4) between 40 and 49 , 1, 0)) as age_40,
										sum(if(date_format(now(),'%Y')-substring(bday,1,4) between 50 and 59 , 1, 0)) as age_50,
										sum(if(date_format(now(),'%Y')-substring(bday,1,4) between 60 and 69 , 1, 0)) as age_60
								   from t_co_emp a, t_co_group b, t_co_emp_dept h
								  where a.emp_seq = h.emp_seq
								    and a.group_seq = b.group_seq) c, (select b.group_seq, count(a.comp_seq) as total_comp
																		 from t_co_comp a, t_co_group b
																		where a.group_seq = b.group_seq) d, ( select b.group_seq,count(a.biz_seq) as total_biz
																											    from t_co_biz a, t_co_group b
																											   where a.group_seq = b.group_seq) e, (select b.group_seq,count(dept_seq) as total_dept
																																					  from t_co_dept a, t_co_group b
																																					 where a.group_seq = b.group_seq) f
 where a.group_seq = b.group_seq
   and b.group_seq = c.group_seq
   and c.group_seq = d.group_seq
   and d.group_seq = e.group_seq
   and e.group_seq = f.group_seq;
   

  select a.group_seq, 
			sum(if(date_format(now(),'%Y')-substring(bday,1,4) between 10 and 19 , 1, 0)) as age_10,
			sum(if(date_format(now(),'%Y')-substring(bday,1,4) between 20 and 29 , 1, 0)) as age_20,
			sum(if(date_format(now(),'%Y')-substring(bday,1,4) between 30 and 39 , 1, 0)) as age_30,
			sum(if(date_format(now(),'%Y')-substring(bday,1,4) between 40 and 49 , 1, 0)) as age_40,
			sum(if(date_format(now(),'%Y')-substring(bday,1,4) between 50 and 59 , 1, 0)) as age_50,
			sum(if(date_format(now(),'%Y')-substring(bday,1,4) between 60 and 69 , 1, 0)) as age_60
	from t_co_emp a, t_co_emp_dept b
   where a.group_seq = b.group_seq;
   
-- 자회사1의 직원 수, 그리고 연령대등등
select * from 
			 (select f.comp_name as compName, f.owner_name as ownerName ,count(e.emp_seq) as totalEmp, count(distinct(e.emp_seq)) as allEmp,
						sum(if(date_format(now(),'%Y')-substring(bday,1,4) between 10 and 19 , 1, 0)) as age10,
						sum(if(date_format(now(),'%Y')-substring(bday,1,4) between 20 and 29 , 1, 0)) as age20,
						sum(if(date_format(now(),'%Y')-substring(bday,1,4) between 30 and 39 , 1, 0)) as age30,
						sum(if(date_format(now(),'%Y')-substring(bday,1,4) between 40 and 49 , 1, 0)) as age40,
						sum(if(date_format(now(),'%Y')-substring(bday,1,4) between 50 and 59 , 1, 0)) as age50,
						sum(if(date_format(now(),'%Y')-substring(bday,1,4) between 60 and 69 , 1, 0)) as age60
			  from t_co_emp_dept a, t_co_biz b, t_co_comp c, t_co_group d, t_co_emp e, t_co_comp_multi f
			 where a.biz_seq = b.biz_seq
			   and a.comp_seq = c.comp_seq 
			   and a.group_seq = d.group_seq
			   and a.emp_seq = e.emp_seq
               and c.comp_seq = f.comp_seq
			   and a.comp_seq=1
			   and f.lang_code='kr') a,
								(select count(a.biz_seq) as totalbiz
								  from t_co_biz a, t_co_comp b, t_co_group c
								 where a.comp_seq = b.comp_seq
								   and b.group_seq = c.group_seq
								   and a.comp_seq = 1) b,
												(select count(a.dept_seq) as totalDept
												  from t_co_dept a, t_co_biz b, t_co_comp c,t_co_group d
												 where a.biz_seq = b.biz_seq
												   and b.comp_seq = c.comp_seq
												   and c.group_seq = d.group_seq
												   and a.comp_seq = 1) c;

select count(distinct(emp_seq)) from t_co_emp_dept;

select count(distinct(emp_seq)) from t_co_emp_dept where comp_seq = 1;


 -- 사업장별 바차트
  select b.biz_name, count(distinct(d.emp_seq))
    from t_co_biz a, t_co_biz_multi b, t_co_comp c,t_co_emp_dept d
   where a.biz_seq= b.biz_seq 
     and a.comp_seq = c.comp_seq
     and a.biz_seq = d.biz_seq
     and b.lang_code ='kr'
     and a.comp_seq = 1
group by a.biz_seq;
 --  
 
 -- 
 		select a.emp_seq as empNum, a.emp_name as empName, a.dept_name as deptName, a.main_dept_yn as mainDeptYn,
			if(a.gender_code = 'M', '남', '여') as genderCode, (left(now(), 4)-left(a.bday, 4))+1 as bDay, 
		    a.dp_name as dutyCode, b.dp_name as positionCode
		from
			(select a.emp_seq, b.emp_name, dept_name, main_dept_yn, gender_code, bday, e.dp_name, a.position_code
			from t_co_emp a, t_co_emp_multi b, t_co_emp_dept c, t_co_dept_multi d, t_co_comp_duty_position_multi e
			where a.emp_seq = b.emp_seq												
			and b.emp_seq = c.emp_seq
			and c.dept_seq = d.dept_seq
			and c.duty_code = e.dp_seq
			and b.lang_code = 'kr'
			and d.lang_code = 'kr'
			and e.lang_code = 'kr'
			and c.comp_seq = 1) a
		left outer join t_co_comp_duty_position_multi b
		on a.position_code = b.dp_seq
		and b.lang_code = 'kr';
 
 select * from t_co_dept;
   
select count(dept_seq) as total_dept
  from t_co_dept a, t_co_group b
 where a.group_seq = b.group_seq; 
   
select b.group_seq, count(a.comp_seq) as total_comp
  from t_co_comp a, t_co_group b
 where a.group_seq = b.group_seq;


select b.group_seq,count(a.biz_seq) as total_biz
  from t_co_biz a, t_co_group b
 where a.group_seq = b.group_seq;


select group_name from t_co_group;


 select a.group_seq,
		sum(if(date_format(now(),'%Y')-substring(bday,1,4) between 10 and 19 , 1, 0)) as age_10,
		sum(if(date_format(now(),'%Y')-substring(bday,1,4) between 20 and 29 , 1, 0)) as age_20,
		sum(if(date_format(now(),'%Y')-substring(bday,1,4) between 30 and 39 , 1, 0)) as age_30,
		sum(if(date_format(now(),'%Y')-substring(bday,1,4) between 40 and 49 , 1, 0)) as age_40,
		sum(if(date_format(now(),'%Y')-substring(bday,1,4) between 50 and 59 , 1, 0)) as age_50,
		sum(if(date_format(now(),'%Y')-substring(bday,1,4) between 60 and 69 , 1, 0)) as age_60
   from t_co_emp a, t_co_group b
  where a.group_seq = b.group_seq;
  
-- select floor((year(now())-year(bday))/10)*10 age, count(bday) as cnt from t_co_emp a where bday!='' group by age;

		
		select c.comp_name as compName, count(b.comp_seq) as compEmpCount
		  from t_co_emp_dept a, t_co_comp b, t_co_comp_multi c
		 where a.comp_seq = b.comp_seq 	
		   and b.comp_seq = c.comp_seq
		   and c.lang_code = 'kr'
		 group by b.comp_seq
		 order by b.comp_seq asc;
         
-- ------
-- 정렬이안됨..
select * from t_co_comp order by comp_seq asc; 

select * from t_co_comp_duty_position_multi; -- pmp
select * from t_co_emp;  -- emp

update t_co_comp_duty_position_multi set dp_type ='POSITION'  where dp_seq = 'dp001';
update t_co_comp_duty_position_multi set group_seq ='demo'  where dp_seq = 'dp001';
update t_co_comp_duty_position_multi set comp_seq ='707010015275'  where dp_seq = 'dp001';

update t_co_emp_comp set dept_seq ='707010015276'  where dept_seq = '707010015285';

select * from t_co_emp_dept;    
select * from t_co_comp_duty_position_multi;
select * from t_co_emp_multi;
select * from t_co_dept;    

		select 
		  	  emp.emp_seq
			, pmp.dp_name
			, pmd.dp_name
		from t_co_emp emp
		LEFT OUTER JOIN t_co_comp_duty_position_multi pmp
			ON emp.position_code = pmp.dp_seq
			AND pmp.lang_code = 'en'
			AND pmp.dp_type = 'POSITION'
		LEFT OUTER JOIN t_co_comp_duty_position_multi pmd
			ON emp.duty_code = pmd.dp_seq
			AND pmd.lang_code = 'en'
			AND pmd.dp_type = 'DUTY'
		where emp.emp_seq = '1';


-- 부서클릭시 직원간단출력
 select a.emp_name as '이름', b.사원번호, b.직급, b.직책, b.이메일, b.전화번호, c.부서명, c.주부서여부, c.사업장시퀀스, c.회사시퀀스, c.그룹시퀀스
   from t_co_emp_multi a,(select emp.emp_seq as 사원번호,
								emp.pic_file_id as 프로필,
								emp.gender_code as 성별,
								pmp.dp_name as 직급,
								pmd.dp_name as 직책,
								emp.email_addr as 이메일,
								emp.mobile_tel_num as 전화번호
						   from t_co_emp emp
				LEFT OUTER JOIN t_co_comp_duty_position_multi pmp
							 ON emp.position_code = pmp.dp_seq
							AND pmp.lang_code ='kr'
							AND pmp.dp_type = 'POSITION'
				LEFT OUTER JOIN t_co_comp_duty_position_multi pmd
							 ON emp.duty_code = pmd.dp_seq 
							AND pmd.dp_type = 'DUTY') b, ( select a.emp_seq as '사원번호',
																   e.dept_name as '부서명',  
																   b.main_dept_yn as '주부서여부',
																   b.biz_seq as '사업장시퀀스',
																   b.comp_seq as '회사시퀀스',
																   b.group_seq as '그룹시퀀스'
															  from t_co_emp a, t_co_emp_dept b, t_co_emp_comp c, t_co_dept d, t_co_dept_multi e
															 where a.emp_seq = b.emp_seq
															   and b.dept_seq = c.dept_seq 
															   and b.dept_seq = d.dept_seq 
															   and d.dept_seq = e.dept_seq
                                                               and d.dept_seq = '707010015276') c 
  where a.emp_seq = b.사원번호
    and b.사원번호 = c.사원번호;


-- 검색
 select a.emp_name as '이름', b.사원번호, b.직급, b.직책, b.이메일, b.전화번호, c.부서명, c.주부서여부, c.사업장시퀀스, c.회사시퀀스, c.그룹시퀀스
   from t_co_emp_multi a,(select emp.emp_seq as 사원번호,
								emp.pic_file_id as 프로필,
								emp.gender_code as 성별,
								pmp.dp_name as 직급,
								pmd.dp_name as 직책,
								emp.email_addr as 이메일,
								emp.mobile_tel_num as 전화번호
						   from t_co_emp emp
				LEFT OUTER JOIN t_co_comp_duty_position_multi pmp
							 ON emp.position_code = pmp.dp_seq
							AND pmp.lang_code ='kr'
							AND pmp.dp_type = 'POSITION'
				LEFT OUTER JOIN t_co_comp_duty_position_multi pmd
							 ON emp.duty_code = pmd.dp_seq 
							AND pmd.dp_type = 'DUTY') b, ( select a.emp_seq as '사원번호',
																   e.dept_name as '부서명',  
																   b.main_dept_yn as '주부서여부',
																   b.biz_seq as '사업장시퀀스',
																   b.comp_seq as '회사시퀀스',
																   b.group_seq as '그룹시퀀스'
															  from t_co_emp a, t_co_emp_dept b, t_co_emp_comp c, t_co_dept d, t_co_dept_multi e
															 where a.emp_seq = b.emp_seq
															   and b.dept_seq = c.dept_seq 
															   and b.dept_seq = d.dept_seq 
															   and d.dept_seq = e.dept_seq
                                                               and d.dept_seq = '707010015276') c 
  where a.emp_seq = b.사원번호
    and b.사원번호 = c.사원번호
	and a.emp_name = '장그래';
-- ------------------------------------------------------------------------------------------


    select a.emp_seq as '사원번호',
		   e.dept_name as '부서명',  
           b.main_dept_yn as '주 부서여부'
      from t_co_emp a, t_co_emp_dept b, t_co_emp_comp c, t_co_dept d, t_co_dept_multi e
	 where a.emp_seq = b.emp_seq
       and b.dept_seq = c.dept_seq 
	   and b.dept_seq = d.dept_seq 
	   and d.dept_seq = e.dept_seq;


		 select emp.emp_seq as 사원번호,
                emp.pic_file_id as 프로필,
                emp.gender_code as 성별,
                pmp.dp_name as 직급,
				pmd.dp_name as 직책,
                emp.email_addr as 이메일,
                emp.mobile_tel_num as 전화번호
		   from t_co_emp emp
LEFT OUTER JOIN t_co_comp_duty_position_multi pmp
			 ON emp.position_code = pmp.dp_seq
			AND pmp.lang_code ='kr'
			AND pmp.dp_type = 'POSITION'
LEFT OUTER JOIN t_co_comp_duty_position_multi pmd
			 ON emp.duty_code = pmd.dp_seq 
			AND pmd.dp_type = 'DUTY'      
		  where emp.emp_seq = '707010015286';
	
--   

    select * from t_co_emp;
    select * from t_co_emp_dept;     
    select * from t_co_emp_comp;
    select * from t_co_dept;
	select * from t_co_dept_multi;
    
--  
    select a.emp_seq as '사원번호',
		   e.dept_name as '부서명',  
           b.main_dept_yn as '주 부서여부'
      from t_co_emp a, t_co_emp_dept b, t_co_emp_comp c, t_co_dept d, t_co_dept_multi e
	 where a.emp_seq = b.emp_seq
       and b.dept_seq = c.dept_seq 
	   and b.dept_seq = d.dept_seq 
	   and d.dept_seq = e.dept_seq;
       


		 select emp.emp_seq,
                pmd.dp_name,
				pmp.dp_name
		   from t_co_emp emp
LEFT OUTER JOIN t_co_comp_duty_position_multi pmp
			 ON emp.position_code = pmp.dp_seq
			AND pmp.lang_code ='kr'
			AND pmp.dp_type = 'POSITION'
LEFT OUTER JOIN t_co_comp_duty_position_multi pmd
			 ON emp.duty_code = pmd.dp_seq 
			AND pmd.dp_type = 'DUTY'
		  where emp.emp_seq = '707010015286';



-- t_co_comp_duty_position_multi 이거좀 이상하긴함..
INSERT INTO `t_co_comp_duty_position_multi` (`dp_seq`,`lang_code`,`dp_type`, `group_seq`, `comp_seq`,  `dp_name`    ,`use_yn`, `create_seq` ,`create_date`		  ,`modify_seq`,`modify_date`)
									  VALUES('AA1001' ,'kr'		 ,'POSITION', 'demo'   , '707010015275','부사장' ,'Y'	 ,'707010015277','2019-04-20 11:00:13',NULL,NULL);

INSERT INTO `t_co_comp_duty_position_multi` (`dp_seq`,`lang_code`,`dp_type`, `group_seq`, `comp_seq`	,`dp_name`    ,`use_yn`, `create_seq` ,`create_date`		  ,`modify_seq`,`modify_date`)
									  VALUES('G1' ,'kr'			 ,'DUTY'   , 'demo'     , '707010015275','팀장' ,'Y'	 ,'707010015277','2019-04-20 11:00:13',NULL,NULL);



-- 샘플데이터 조직도 및 포탈공통 테이블 샘플데이터 

-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-- 그룹
-- t_co_group
INSERT INTO `t_co_group` (`group_seq`, `group_name`, `native_lang_code`, `multiple_login_yn`, `group_display_name`, `max_count`, `login_type`, `setup_version`, `mail_url`, `messenger_url`, `mobile_id`, `mobile_url`, `edms_url`, `sms_url`, `manual_url`, `sms_use_yn`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `mobile_gateway_url`, `bill36524_url`, `setup_version_seq`, `master_passwd`, `group_email_domain`)
VALUES
	('demo', 'quicksilver', NULL, NULL, 'test', NULL, 'B', '', 'http:-- bizboxamail.duzonnext.com:9091/mail2/', 'http:-- bizboxa.duzonnext.com', 'demo', 'http:-- localhost:8940/BizboxMobilePush/PushSend', 'http:-- bizboxa.duzonnext.com', NULL, 'http:-- manual.bizboxa.com', 'N', 'Y', NULL, NULL, NULL, '2019-03-06 14:26:27', 'http:-- 14.41.60.223:8940', 'http:-- 172.16.119.21:9012', '999999', 'pk2mmIOpycza94KY1MLBX8YabvLGqoIAS6Wa0H+X3mQ=', 'douzone.com');


-- t_co_groupping
INSERT INTO `t_co_groupping` (`group_seq`, `groupping_seq`, `groupping_name`, `groupping_name_en`, `groupping_name_jp`, `groupping_name_cn`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `groupping_order`, `groupping_etc`)
VALUES
	('demo', '10', '테스트 그룹핑', '', '', '', 'Y', '9911', '2018-12-27 14:01:20', NULL, NULL, 9999, '');


-- t_co_groupping_comp
INSERT INTO `t_co_groupping_comp` (`groupping_seq`, `comp_seq`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date`)
VALUES
	('10', '707010015275', 'Y', '3332', '2019-02-27 18:01:51', NULL, NULL);

-- t_co_groupping_comp_history

-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-- 회사
-- t_co_comp
INSERT INTO `t_co_comp` (`group_seq`, `comp_seq`, `comp_cd`, `parent_comp_seq`, `login_type`, `comp_regist_num`, `comp_num`, `standard_code`, `erp_use`, `tel_num`, `fax_num`, `homepg_addr`, `comp_mail_url`, `comp_domain`, `email_addr`, `email_domain`, `zip_code`, `sms_use`, `sms_id`, `sms_passwd`, `native_lang_code`, `order_num`, `use_yn`, `ea_type`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `comp_email_yn`, `erp_use_yn`, `sms_use_yn`)
VALUES
  ('demo', '707010015275', 'prado', '0', 'B', '', '', '', 'Y', '', '', '', NULL, 'bizboxa.duzonnext.com', NULL, '', '', 'N', '', '', 'kr', NULL, 'Y', 'eap', '707010011564', '2018-12-10 13:03:15', '707010011564', '2018-12-10 13:03:15', 'N', 'N', 'N');

-- t_co_comp_multi
INSERT INTO `t_co_comp_multi` (`comp_seq`, `lang_code`, `group_seq`, `comp_name`, `comp_display_name`, `owner_name`, `sender_name`, `biz_condition`, `item`, `addr`, `detail_addr`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `comp_nickname`)
VALUES
  ('707010015275', 'kr', 'demo', '프라도', NULL, '박준', '', '', '', '', '', 'Y', '707010011564', '2018-12-10 13:03:15', '707010011564', '2018-12-10 13:03:15', '');

-- t_co_comp_multi_history

-- t_co_comp_duty_position
INSERT INTO `t_co_comp_duty_position` (`dp_seq`,`group_seq`, `comp_seq`, `dp_type`, `use_yn`, `order_num`, `create_seq`, `create_date`, `modify_seq`, `modify_date`)
VALUES
  ('dp001', 'demo', '707010015275', 'POSITION', 'Y', NULL, '707010015277', '2019-04-19 10:00:13', NULL, NULL);

-- t_co_comp_duty_position_multi 이거좀 이상하긴함..
INSERT INTO `t_co_comp_duty_position_multi` (`dp_seq`,`lang_code`,`dp_type`, `group_seq`, `comp_seq`,  `dp_name`    ,`use_yn`, `create_seq` ,`create_date`		  ,`modify_seq`,`modify_date`)
									  VALUES('dp001' ,'kr'		 ,'POSITION', 'demo'   , '707010015275','프라도 직급1' ,'Y'	 ,'707010015277','2019-04-19 10:00:13',NULL,NULL);


-- t_co_comp_duty_position_multi_history

-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-- 사업장
-- t_co_biz
INSERT INTO `t_co_biz` (`biz_seq`, `biz_cd`, `group_seq`, `comp_seq`, `comp_regist_num`, `comp_num`, `tel_num`, `fax_num`, `homepg_addr`, `zip_code`, `display_yn`, `native_lang_code`, `order_num`, `use_yn`, `seal_file_id`, `create_seq`, `create_date`, `modify_seq`, `modify_date`)
VALUES
  ('707010015275', '707010015275', 'demo', '707010015275', '', '', '', '', '', '', 'N', 'kr', NULL, 'Y', NULL, '707010011564', '2018-12-10 13:03:15', '707010011564', '2018-12-10 13:03:15');

-- t_co_biz_history

-- t_co_biz_multi
INSERT INTO `t_co_biz_multi` (`biz_seq`, `lang_code`, `group_seq`, `comp_seq`, `biz_name`, `owner_name`, `biz_condition`, `sender_name`, `biz_nickname`, `item`, `addr`, `detail_addr`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date`)
VALUES
  ('707010015275', 'kr', 'demo', '707010015275', '프라도', '박준', '', '', NULL, '', '', '', 'Y', '707010011564', '2018-12-10 13:03:15', '707010011564', '2018-12-10 13:03:15');
-- t_co_biz_multi_history

-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-- 부서
-- t_co_dept
INSERT INTO `t_co_dept` (`dept_seq`, `dept_cd`, `group_seq`, `comp_seq`, `biz_seq`, `parent_dept_seq`, `tel_num`, `fax_num`, `homepg_addr`, `zip_code`, `susin_yn`, `vir_dept_yn`, `team_yn`, `native_lang_code`, `path`, `ptype`, `dept_level`, `order_num`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `dept_manager`, `display_yn`)
VALUES
  ('707010015276', 'prado_01', 'demo', '707010015275', '707010015275', '0', NULL, '', NULL, '', NULL, 'N', 'Y', 'kr', '707010015276', 0, 1, NULL, 'Y', '707010011564', '2018-12-10 13:06:55', '4498', '2019-02-20 12:54:31', NULL, 'Y');



-- t_co_dept_history

-- t_co_dept_multi
INSERT INTO `t_co_dept_multi` (`dept_seq`, `lang_code`, `group_seq`, `comp_seq`, `biz_seq`, `dept_name`, `dept_display_name`, `sender_name`, `addr`, `detail_addr`, `path_name`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `dept_nickname`)
VALUES
  ('707010015276', 'kr', 'demo', '707010015275', '707010015275', '회계연도기준2', NULL, NULL, '', '', '회계연도기준2', 'Y', '4498', '2019-02-20 12:54:31', '4498', '2019-02-20 12:54:31', '연차테스트팀');
-- t_co_dept_multi_history

-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-- 사원
-- t_co_emp
INSERT INTO `t_co_emp` (`emp_seq`, `group_seq`, `login_id`, `emp_num`, `erp_emp_num`, `email_addr`, `out_mail`, `out_domain`, `login_passwd`, `appr_passwd`, `passwd_date`, `passwd_input_fail_count`, `pay_passwd`, `passwd_status_code`, `mobile_use_yn`, `messenger_use_yn`, `check_work_yn`, `shift`, `job_code`, `status_code`, `main_comp_seq`, `main_comp_login_yn`, `duty_code`, `position_code`, `native_lang_code`, `license_check_yn`, `join_day`, `resign_day`, `gender_code`, `bday`, `lunar_yn`, `work_status`, `home_tel_num`, `mobile_tel_num`, `wedding_yn`, `wedding_day`, `private_yn`, `zip_code`, `pic_file_id`, `sign_file_id`, `use_yn`, `ls_role_id`, `create_seq`, `create_date`, `modify_seq`, `modify_date`, `spring_secu`, `spring_date`, `sign_type`)
VALUES
    ('707010015286', 'demo', 'prado05', NULL, '', 'prado05', '', '', 'wtG/X1HOAgX4p0uKurSohwH4kR8/iJeIPxJUka/HmJE=', '7EyIyn9pU08QwGEcHs0T58LN9z4bkV6f0M8nrBDaQ/o=', '2019-01-02 23:07:37', 0, '7EyIyn9pU08QwGEcHs0T58LN9z4bkV6f0M8nrBDaQ/o=', 'P', 'Y', 'Y', 'Y', NULL, '4', '4', '707010015275', 'Y', 'G1', 'AA1001', 'kr', '1', '2018-06-01', NULL, 'M', NULL, '', '999', '', '', 'N', NULL, 'Y', '', '', '', 'Y', NULL, '707010015277', '2018-12-12 01:29:39', '707010015286', '2019-01-02 23:07:37', 'a922d386897a4e2189f2d10b67fcf962', '2019-01-03 09:22:06', 'stamp_de_div');

-- t_co_emp_history

-- t_co_emp_multi
INSERT INTO `t_co_emp_multi` (`emp_seq`, `lang_code`, `group_seq`, `emp_name`, `addr`, `detail_addr`, `main_work`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date`)
VALUES
    ('707010015286', 'kr', 'demo', '장그래', '', '', '', 'Y', '707010015277', '2018-12-12 01:56:05', '707010015277', '2018-12-12 01:56:05');

-- t_co_emp_multi_history

-- t_co_emp_comp
INSERT INTO `t_co_emp_comp` (`emp_seq`, `group_seq`, `comp_seq`, `biz_seq`, `dept_seq`, `erp_emp_seq`, `erp_comp_seq`, `erp_biz_seq`, `erp_dept_seq`, `gerp_no_gemp`, `check_work_yn`, `shift`, `job_code`, `status_code`, `resign_day`, `work_status`, `use_yn`, `mail_del_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date`)
VALUES
    ('707010015286', 'demo', '707010015275', '707010015275', '707010015285', '', NULL, NULL, NULL, NULL, 'Y', NULL, '4', '4', NULL, '999', 'Y', 'N', '707010015277', '2018-12-12 01:29:39', '707010015277', '2018-12-12 01:56:05');

-- t_co_emp_comp_history

-- t_co_emp_dept
INSERT INTO `t_co_emp_dept` (`dept_seq`, `emp_seq`, `group_seq`, `comp_seq`, `biz_seq`, `main_dept_yn`, `duty_code`, `position_code`, `tel_num`, `fax_num`, `zip_code`, `orgchart_display_yn`, `messenger_display_yn`, `order_num`, `order_text`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date`)
VALUES 
    ('707010015285', '707010015286', 'demo', '707010015275', '707010015275', 'Y', 'G1', 'AA1001', '', '', '', 'Y', 'Y', 100, '0000000000|0000000006|0000000100|20180601|장그래', 'Y', '707010015277', '2018-12-12', '707010015277', '2018-12-12 01:29:39');

-- t_co_emp_dept_history

-- t_co_emp_dept_multi
INSERT INTO `t_co_emp_dept_multi` (`dept_seq`, `emp_seq`, `lang_code`, `group_seq`, `comp_seq`, `biz_seq`, `addr`, `detail_addr`, `use_yn`, `create_seq`, `create_date`, `modify_seq`)
VALUES
    ('707010015285', '707010015286', 'kr', 'demo', '707010015275', '707010015275', '', '', 'Y', '707010015277', '2018-12-12 01:29:39', '707010015277');

-- t_co_emp_dept_multi_history

-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





-- 쿼리문

select distinct a.emp_seq as empNum, a.emp_name as empName, a.dept_name as deptName, a.main_dept_yn as mainDeptYn,
			if(a.gender_code = 'M', '남', '여') as genderCode, (left(now(), 4)-left(a.bday, 4))+1 as bDay, 
		    a.dp_name as dutyCode, b.dp_name as positionCode
		from	
			(select a.emp_seq, b.emp_name, dept_name, main_dept_yn, gender_code, bday, e.dp_name, a.position_code, c.biz_seq, f.biz_name
			from t_co_emp a, t_co_emp_multi b, t_co_emp_dept c, t_co_dept_multi d, t_co_comp_duty_position_multi e, t_co_biz_multi f
			where a.emp_seq = b.emp_seq
			and b.emp_seq = c.emp_seq
			and c.dept_seq = d.dept_seq
			and c.duty_code = e.dp_seq
            and f.biz_seq = c.biz_seq
			and b.lang_code = 'kr'
			and d.lang_code = 'kr'
			and e.lang_code = 'kr'
			and b.emp_name = '김택주') a
		left outer join t_co_comp_duty_position_multi b
		on a.position_code = b.dp_seq
		and b.lang_code = 'kr';



select a.emp_seq as empNum, a.emp_name as empName, a.dept_name as deptName, a.main_dept_yn as mainDeptYn,
			if(a.gender_code = 'M', '남', '여') as genderCode, (left(now(), 4)-left(a.bday, 4))+1 as bDay, 
		    a.dp_name as dutyCode, b.dp_name as positionCode
		from	
			(select a.emp_seq, b.emp_name, d.dept_name, c.main_dept_yn, gender_code, bday, e.dp_name, a.position_code
			from t_co_emp a, t_co_emp_multi b, t_co_emp_dept c, t_co_dept_multi d, t_co_comp_duty_position_multi e
			where a.emp_seq = b.emp_seq
			and b.emp_seq = c.emp_seq
			and c.dept_seq = d.dept_seq
			and c.duty_code = e.dp_seq
			and b.lang_code = 'kr'
			and d.lang_code = 'kr'
			and e.lang_code = 'kr'
			and b.emp_name = '김택주') a
		left outer join t_co_comp_duty_position_multi b
		on a.position_code = b.dp_seq
		and b.lang_code = 'kr';
        
--
        
select a.emp_seq as empNum, a.emp_name as empName, a.dept_name as deptName, a.main_dept_yn as mainDeptYn,
			if(a.gender_code = 'M', '남', '여') as genderCode, (left(now(), 4)-left(a.bday, 4))+1 as bDay, 
		    a.dp_name as dutyCode, b.dp_name as positionCode
		from	
			(select a.emp_seq, b.emp_name, d.dept_name, c.main_dept_yn, gender_code, bday, e.dp_name, a.position_code, c.biz_seq
			from t_co_emp a, t_co_emp_multi b, t_co_emp_dept c, t_co_dept_multi d, t_co_comp_duty_position_multi e
			where a.emp_seq = b.emp_seq
			and b.emp_seq = c.emp_seq
			and c.dept_seq = d.dept_seq
			and c.duty_code = e.dp_seq
			and b.lang_code = 'kr'
			and d.lang_code = 'kr'
			and e.lang_code = 'kr'
			and c.biz_seq = '사업장1') a
		left outer join t_co_comp_duty_position_multi b
		on a.position_code = b.dp_seq
		and b.lang_code = 'kr';	
    
    
select * from t_co_dept_multi where lang_code ='kr';

select * from t_co_comp_multi ;
select * from t_co_biz ;
select * from t_co_biz_multi;



select * from t_co_dept where biz_seq='10000039';

	    select a.dept_seq as deptSeq, a.group_seq as groupSeq, a.comp_seq as compSeq,
	    	 a.biz_seq as bizSeq, a.parent_dept_seq as parentDeptSeq, b.dept_name as deptName, a.dept_level as deptLevel
		from t_co_dept a, t_co_dept_multi b
		where a.dept_seq = b.dept_seq
		and b.lang_code = 'kr'
		and a.use_yn = 'Y'
		and b.use_yn = 'Y'
		and parent_dept_seq = '10000039'
		order by a.dept_seq + 0;


select * from t_co_emp_dept where emp_seq='78160'; 

(select dept_seq from t_co_emp_dept where emp_seq='78160'); 

select parent_dept_seq from t_co_dept where dept_seq = (select dept_seq from t_co_emp_dept where emp_seq='20000'); 
select parent_dept_seq from t_co_dept where dept_seq = 101;
select parent_dept_seq from t_co_dept where dept_seq = 10000069;

select * from t_co_dept where dept_seq > 50000;

select dept_seq from t_co_emp_dept where emp_seq='20000';
select emp_name from t_co_emp_multi where emp_seq='20000';


--
  select a.emp_seq, b.emp_name, d.dept_name, c.main_dept_yn, gender_code, bday, e.dp_name, a.position_code, f.biz_name
	from t_co_emp a, t_co_emp_multi b, t_co_emp_dept c, t_co_dept_multi d, t_co_comp_duty_position_multi e, t_co_biz_multi f
   where a.emp_seq = b.emp_seq
	 and b.emp_seq = c.emp_seq
	 and c.dept_seq = d.dept_seq
	 and c.duty_code = e.dp_seq
     and f.biz_seq = c.biz_seq
	 and b.lang_code = 'kr'
	 and d.lang_code = 'kr'
	 and e.lang_code = 'kr'
	 and f.biz_name = '사업장1';
            
-- 
 		select a.emp_seq as empNum, a.emp_name as empName, a.dept_name as deptName, a.main_dept_yn as mainDeptYn,
			if(a.gender_code = 'M', '남', '여') as genderCode, (left(now(), 4)-left(a.bday, 4))+1 as bDay, 
		    a.dp_name as dutyCode, b.dp_name as positionCode
		from
			(select a.emp_seq, b.emp_name, dept_name, main_dept_yn, gender_code, bday, e.dp_name, a.position_code
			from t_co_emp a, t_co_emp_multi b, t_co_emp_dept c, t_co_dept_multi d, t_co_comp_duty_position_multi e
			where a.emp_seq = b.emp_seq
			and b.emp_seq = c.emp_seq
			and c.dept_seq = d.dept_seq
			and c.duty_code = e.dp_seq
			and b.lang_code = 'kr'
			and d.lang_code = 'kr'
			and e.lang_code = 'kr'
			and c.biz_seq = '10000001') a
		left outer join t_co_comp_duty_position_multi b
		on a.position_code = b.dp_seq
		and b.lang_code = 'kr';
            
            
     select * from t_co_dept;       
-- 

-- 
	select a.dept_seq as deptSeq, a.group_seq as groupSeq, a.comp_seq as compSeq,
		 a.biz_seq as bizSeq, a.parent_dept_seq as parentDeptSeq, b.dept_name as deptName, a.dept_level as deptLevel
	from t_co_dept a, t_co_dept_multi b
	where a.dept_seq = b.dept_seq
	and b.lang_code = 'kr'
	and a.use_yn = 'Y'
	and b.use_yn = 'Y'
	and parent_dept_seq = 100
	order by a.dept_seq + 0;
            
	select a.emp_seq as empNum, a.emp_name as empName, a.dept_name as deptName, a.main_dept_yn as mainDeptYn,
	if(a.gender_code = 'M', '남', '여') as genderCode, (left(now(), 4)-left(a.bday, 4))+1 as bDay, 
	a.dp_name as dutyCode, b.dp_name as positionCode
from
	(select a.emp_seq, b.emp_name, dept_name, main_dept_yn, gender_code, bday, e.dp_name, a.position_code
	from t_co_emp a, t_co_emp_multi b, t_co_emp_dept c, t_co_dept_multi d, t_co_comp_duty_position_multi e
	where a.emp_seq = b.emp_seq
	and b.emp_seq = c.emp_seq
	and c.dept_seq = d.dept_seq
	and c.duty_code = e.dp_seq
	and b.lang_code = 'kr'
	and d.lang_code = 'kr'
	and e.lang_code = 'kr'
	and c.dept_seq = 35) a
left outer join t_co_comp_duty_position_multi b
on a.position_code = b.dp_seq
and b.lang_code = 'kr' 
order by bDay desc;
            
-- 
  select c.emp_seq, d.emp_name
   from t_co_dept a, t_co_dept_multi b, t_co_emp_dept c, t_co_emp_multi d
  where a.dept_seq = b.dept_seq
    and a.dept_seq = c.dept_seq
    and a.dept_manager = c.emp_seq
    and c.emp_seq = d.emp_seq
    and b.lang_code = 'kr'
    and d.lang_code = 'kr'
    and c.dept_seq= 100;
    
 
-- 검색 
select distinct a.emp_seq as empNum, a.emp_name as empName, a.dept_name as deptName,
			if(a.gender_code = 'M', '남', '여') as genderCode, (left(now(), 4)-left(a.bday, 4))+1 as bDay, 
		    a.dp_name as dutyCode, b.dp_name as positionCode
		from	
			(select a.emp_seq, b.emp_name, dept_name, gender_code, bday, e.dp_name, a.position_code, f.biz_name
			   from t_co_emp a, t_co_emp_multi b, t_co_emp_dept c, t_co_dept_multi d, t_co_comp_duty_position_multi e, t_co_biz_multi f
			  where a.emp_seq = b.emp_seq
			    and b.emp_seq = c.emp_seq
			    and c.dept_seq = d.dept_seq
			    and c.duty_code = e.dp_seq
		        and f.biz_seq = c.biz_seq
		        and b.lang_code = 'kr'
				and d.lang_code = 'kr'
				and e.lang_code = 'kr'
				and b.emp_name like '%김택주%') a
		left outer join t_co_comp_duty_position_multi b
		on a.position_code = b.dp_seq
		and b.lang_code = 'kr';
            
            
select distinct a.emp_seq as empNum, a.emp_name as empName, a.dept_name as deptName,
			if(a.gender_code = 'M', '남', '여') as genderCode, (left(now(), 4)-left(a.bday, 4))+1 as bDay, 
		    a.dp_name as dutyCode, b.dp_name as positionCode
		from	
			(select a.emp_seq, b.emp_name, dept_name, gender_code, bday, e.dp_name, a.position_code, f.biz_name
			   from t_co_emp a, t_co_emp_multi b, t_co_emp_dept c, t_co_dept_multi d, t_co_comp_duty_position_multi e, t_co_biz_multi f
			  where a.emp_seq = b.emp_seq
			    and b.emp_seq = c.emp_seq
			    and c.dept_seq = d.dept_seq
			    and c.duty_code = e.dp_seq
		        and f.biz_seq = c.biz_seq
		        and b.lang_code = 'kr'
				and d.lang_code = 'kr'
				and e.lang_code = 'kr'
                and e.dp_type = 'DUTY'
				and e.dp_name like '%장%') a 
		left outer join t_co_comp_duty_position_multi b
		on a.position_code = b.dp_seq
		and b.lang_code = 'kr';            
        
--
        
select distinct a.emp_seq as empNum, a.emp_name as empName, a.dept_name as deptName,
	if(a.gender_code = 'M', '남', '여') as genderCode, (left(now(), 4)-left(a.bday, 4))+1 as bDay, 
	a.dp_name as dutyCode, b.dp_name as positionCode
from	
	(select a.emp_seq, b.emp_name, dept_name, gender_code, bday, e.dp_name, a.position_code, f.biz_name
	   from t_co_emp a, t_co_emp_multi b, t_co_emp_dept c, t_co_dept_multi d, t_co_comp_duty_position_multi e, t_co_biz_multi f
	  where a.emp_seq = b.emp_seq
		and b.emp_seq = c.emp_seq
		and c.dept_seq = d.dept_seq
		and c.duty_code = e.dp_seq
		and f.biz_seq = c.biz_seq
		and b.lang_code = 'kr'
		and d.lang_code = 'kr'
		and e.lang_code = 'kr') a 
left outer join t_co_comp_duty_position_multi b
on a.position_code = b.dp_seq
and b.lang_code = 'kr';


-- 검색말고 테이블뿌리기 개선
		select 				
			  emp.emp_seq as empSeq,
			  emp.dept_name as deptName,
			  pmp.dp_name as positionCode,
			  pmd.dp_name as dutyCode,
			  emp.emp_name as empName,
			  emp.login_id as loginId,
			  emp.home_tel_num as homeTelNum,
			  emp.mobile_tel_num as mobileTelNum,
			  emp.emp_seq
		from (select
					d.dept_name,
					b.position_code as positionDuty,
					b.duty_code as deptDuty,
					e.emp_name,
					a.login_id,
					a.home_tel_num,
					a.mobile_tel_num,
					a.emp_seq,
				    b.comp_seq,
                    b.biz_seq,
                    b.dept_seq
				  from t_co_emp a, t_co_emp_dept b, t_co_dept c, t_co_dept_multi d , t_co_emp_multi e 
				 where a.emp_seq = b.emp_seq
				   and b.dept_seq = c.dept_seq
				   and c.dept_seq = d.dept_seq 
				   and a.emp_seq = e.emp_seq
				   and e.lang_code ='kr'
				   and d.lang_code = 'kr') emp    
			LEFT OUTER JOIN t_co_comp_duty_position_multi pmp
				ON emp.positionDuty = pmp.dp_seq
				AND pmp.lang_code = 'kr'
				AND pmp.dp_type = 'POSITION'
			LEFT OUTER JOIN t_co_comp_duty_position_multi pmd
				ON emp.deptDuty = pmd.dp_seq
				AND pmd.lang_code = 'kr'
				AND pmd.dp_type = 'DUTY'
		where  emp.dept_seq = 10;
        
        
select * from t_co_comp_duty_position_multi;



select biz_seq as bizSeq from t_co_dept where dept_seq ='1224';
 

select dept_seq as deptSeq,biz_seq as bizSeq,comp_seq as compSeq from t_co_emp_dept where emp_seq=78164 and dept_seq = 681; 
-- 관리자페이지 부서연결 로그인아디 이름 
select distinct(a.login_id), c.emp_name
  from t_co_emp a, t_co_emp_dept b, t_co_emp_multi c, t_co_emp_comp d
 where a.emp_seq = b.emp_seq
   and a.emp_seq = c.emp_seq
   and c.emp_seq = d.emp_seq
   and b.comp_seq = 7
   and c.lang_code = 'kr'
   and d.work_status = '999'
   and (a.login_id = 'xortn' or c.emp_name like'%김택주%');        
        
-- 관리자페이지 직원클릭시 나타날거
	select
		  emp.comp_name as compName,
		  emp.dept_name as deptName,
		  emp.main_dept_yn as mainDeptYn,
		  pmp.dp_name as positionCode
	from (select
				f.comp_name,
				b.main_dept_yn,
				d.dept_name,
				b.position_code as positionDuty,
				b.duty_code as deptDuty,
				e.emp_name,
				a.login_id,
				a.home_tel_num,
				a.mobile_tel_num,
				a.emp_seq,
				b.dept_seq
			  from t_co_emp a, t_co_emp_dept b, t_co_dept c, t_co_dept_multi d , t_co_emp_multi e, t_co_comp_multi f
			 where a.emp_seq = b.emp_seq
			   and b.dept_seq = c.dept_seq
			   and c.dept_seq = d.dept_seq 
			   and a.emp_seq = e.emp_seq
			   and b.comp_seq = f.comp_seq
			   and f.lang_code='kr'
			   and e.lang_code ='kr'
			   and d.lang_code = 'kr'
               and b.comp_seq = 7) emp    
		LEFT OUTER JOIN t_co_comp_duty_position_multi pmp
			ON emp.positionDuty = pmp.dp_seq
			AND pmp.lang_code = 'kr'
			AND pmp.dp_type = 'POSITION'
		LEFT OUTER JOIN t_co_comp_duty_position_multi pmd
			ON emp.deptDuty = pmd.dp_seq
			AND pmd.lang_code = 'kr'
			AND pmd.dp_type = 'DUTY'
	where emp.login_id = 'frfmiixbdp75'  
	  and emp.emp_name ='김택주';  


select distinct(a.emp_seq)
  from t_co_emp a, t_co_emp_multi b, t_co_emp_dept c 
  where a.emp_seq = b.emp_seq
    and c.emp_seq = a.emp_seq
    and b.lang_code = 'kr'
    and a.login_id = 'frfmiixbdp75' 
    and b.emp_name = '김택주'
    and c.comp_seq = 7;


select * from t_co_comp_duty_position_multi where comp_seq = 1;

-- 
 	select
				  emp.comp_name as compName,
				  emp.dept_name as deptName,
				  emp.dept_seq as deptSeq,
		          emp.emp_seq as empSeq,
				  emp.main_dept_yn as mainDeptYn,
				  emp.positionCode,
				  emp.dutyCode,
				  pmp.dp_name as positionName,
		          pmd.dp_name as dutyName,
		          emp.tel_num as telNum,
		          emp.fax_num as faxNum,
		          emp.check_work_yn as checkWorkYn,
		          emp.work_status as workStatus
			from (select
						f.comp_name,
						b.main_dept_yn,
                        b.comp_seq,
						d.dept_name,
						b.position_code as positionCode,
						b.duty_code as dutyCode,
						e.emp_name,
						a.login_id,
						a.home_tel_num,
						a.mobile_tel_num,
						a.emp_seq,
						b.dept_seq,
		                c.tel_num,
		                c.fax_num,
		                g.check_work_yn,
		                g.work_status
					  from t_co_emp a, t_co_emp_dept b, t_co_dept c, t_co_dept_multi d , t_co_emp_multi e, t_co_comp_multi f, t_co_emp_comp g
					 where a.emp_seq = b.emp_seq
					   and b.dept_seq = c.dept_seq
					   and c.dept_seq = d.dept_seq 
					   and a.emp_seq = e.emp_seq
					   and b.comp_seq = f.comp_seq
		               and b.emp_seq = g.emp_seq
					   and f.lang_code='kr'
					   and e.lang_code ='kr'
					   and d.lang_code = 'kr'
					   and b.comp_seq = 1) emp    
				LEFT OUTER JOIN t_co_comp_duty_position_multi pmp
					ON emp.positionCode = pmp.dp_seq
					AND pmp.lang_code = 'kr'
					AND pmp.dp_type = 'POSITION'
				LEFT OUTER JOIN t_co_comp_duty_position_multi pmd
					ON emp.dutyCode = pmd.dp_seq
					AND pmd.lang_code = 'kr'
					AND pmd.dp_type = 'DUTY'
			where emp.login_id = 'akvzhwnivq225'  
			  and emp.emp_name ='김기용'; 
              
--

select * from t_co_comp_duty_position where comp_seq = 1;

select * from t_co_emp_dept where comp_seq = 2 and emp_seq = 29789;


-- 관리자페이지 직원클릭시 나타날거 상세
	select
		  emp.comp_name as compName,
		  emp.dept_name as deptName,
          emp.emp_seq as empSeq,
		  emp.main_dept_yn as mainDeptYn,
		  pmp.dp_name as positionCode,
          pmd.dp_name as dutyCode,
          emp.tel_num as telNum,
          emp.fax_num as faxNum,
          emp.check_work_yn as checkWorkYn,
          emp.work_status as workStatus
	from (select
				f.comp_name,
				b.main_dept_yn,
				d.dept_name,
				b.position_code as positionDuty,
				b.duty_code as deptDuty,
				e.emp_name,
				a.login_id,
				a.home_tel_num,
				a.mobile_tel_num,
				a.emp_seq,
				b.dept_seq,
                c.tel_num,
                c.fax_num,
                g.check_work_yn,
                g.work_status
			  from t_co_emp a, t_co_emp_dept b, t_co_dept c, t_co_dept_multi d , t_co_emp_multi e, t_co_comp_multi f, t_co_emp_comp g
			 where a.emp_seq = b.emp_seq
			   and b.dept_seq = c.dept_seq
			   and c.dept_seq = d.dept_seq 
			   and a.emp_seq = e.emp_seq
			   and b.comp_seq = f.comp_seq
               and b.emp_seq = g.emp_seq
			   and f.lang_code='kr'
			   and e.lang_code ='kr'
			   and d.lang_code = 'kr') emp    
		LEFT OUTER JOIN t_co_comp_duty_position_multi pmp
			ON emp.positionDuty = pmp.dp_seq
			AND pmp.lang_code = 'kr'
			AND pmp.dp_type = 'POSITION'
		LEFT OUTER JOIN t_co_comp_duty_position_multi pmd
			ON emp.deptDuty = pmd.dp_seq
			AND pmd.lang_code = 'kr'
			AND pmd.dp_type = 'DUTY'
	where emp.login_id = 'frfmiixbdp75'  
	  and emp.emp_name ='김택주'
	  and emp.dept_name ='부서01' ;  
      
-- 그회사에 맞는 직급직책다가져와

 select * from
	(select dp_seq as positionCode, dp_name as positionName
      from t_co_comp_duty_position_multi a
	 where lang_code='kr'
       and dp_type = 'position'
       and comp_seq =1)
       
	   (select dp_seq,dp_name
	  from t_co_comp_duty_position_multi a
	 where lang_code='kr'
	   and dp_type = 'duty'
	   and comp_seq =1) b ;
						  
      select dp_seq as positionCode, dp_name as positionName
      from t_co_comp_duty_position_multi a
	 where lang_code='kr'
       and dp_type = 'position'
       and comp_seq =1;
      
        
-- 검색 개선

		select
			  emp.emp_seq as empSeq,
              emp.dept_seq as deptSeq,
			  emp.dept_name as deptName,
			  pmp.dp_name as positionCode,
			  pmd.dp_name as dutyCode,
			  emp.emp_name as empName,
			  emp.login_id as loginId,
			  emp.home_tel_num as homeTelNum,
			  emp.mobile_tel_num as mobileTelNum,
			  emp.emp_seq 
		from (select
					d.dept_name,
					b.position_code as positionDuty,
					b.duty_code as deptDuty,
					e.emp_name,
					a.login_id,
					a.home_tel_num,
					a.mobile_tel_num,
					a.emp_seq,
                    b.dept_seq
				  from t_co_emp a, t_co_emp_dept b, t_co_dept c, t_co_dept_multi d , t_co_emp_multi e 
				 where a.emp_seq = b.emp_seq
				   and b.dept_seq = c.dept_seq
				   and c.dept_seq = d.dept_seq 
				   and a.emp_seq = e.emp_seq
				   and e.lang_code ='kr'
				   and d.lang_code = 'kr') emp    
			LEFT OUTER JOIN t_co_comp_duty_position_multi pmp
				ON emp.positionDuty = pmp.dp_seq
				AND pmp.lang_code = 'kr'
				AND pmp.dp_type = 'POSITION'
			LEFT OUTER JOIN t_co_comp_duty_position_multi pmd
				ON emp.deptDuty = pmd.dp_seq
				AND pmd.lang_code = 'kr'
				AND pmd.dp_type = 'DUTY'
		where	
        
		-- (emp.login_id like '%김택주%'  -- 사원검색 아이디 
		-- or emp.emp_name like '%김택주%');  -- 사원검색 이름 

		-- emp.dept_name like '%부서3%';  -- 부서검색 
	
		-- pmp.dp_name like '%차장%'; -- 직급건색
   
		-- pmd.dp_name like '%파트%'; -- 직책건색
   
		-- emp.home_tel_num like '%010%'; -- 전화검색
		--  emp.mobile_tel_num like '%7954%'; -- 모바일번호검색;
-- 전체검색 
  (emp.login_id like '%김택주%'  -- 사원검색 아이디 
  or emp.emp_name like '%김택주%'  -- 사원검색 이름 
  or emp.dept_name like '%김택주%'  -- 부서검색 
  or pmp.dp_name like '%김택주%' -- 직급건색
  or pmd.dp_name like '%김택주%' -- 직책건색
  or emp.home_tel_num like '%김택주%' -- 전화검색
  or emp.mobile_tel_num like '%김택주%'); -- 모바일번호검색;


select * from t_co_dept_multi where dept_seq=1251;
-- 페이징 
	select
		count(emp.emp_seq)
		from (select
					d.dept_name,
					b.position_code as positionDuty,
					b.duty_code as deptDuty,
					e.emp_name,
					a.login_id,
					a.home_tel_num,
					a.mobile_tel_num,
					a.emp_seq,
                    b.dept_seq
				  from t_co_emp a, t_co_emp_dept b, t_co_dept c, t_co_dept_multi d , t_co_emp_multi e 
				 where a.emp_seq = b.emp_seq
				   and b.dept_seq = c.dept_seq
				   and c.dept_seq = d.dept_seq 
				   and a.emp_seq = e.emp_seq
				   and e.lang_code ='kr'
				   and d.lang_code = 'kr') emp    
			LEFT OUTER JOIN t_co_comp_duty_position_multi pmp
				ON emp.positionDuty = pmp.dp_seq
				AND pmp.lang_code = 'kr'
				AND pmp.dp_type = 'POSITION'
			LEFT OUTER JOIN t_co_comp_duty_position_multi pmd
				ON emp.deptDuty = pmd.dp_seq
				AND pmd.lang_code = 'kr'
				AND pmd.dp_type = 'DUTY'
		where	
        
		-- (emp.login_id like '%김택주%'  -- 사원검색 아이디 
		-- or emp.emp_name like '%김택주%');  -- 사원검색 이름 

		-- emp.dept_name like '%부서3%';  -- 부서검색 
	
		-- pmp.dp_name like '%차장%'; -- 직급건색
   
		-- pmd.dp_name like '%파트%'; -- 직책건색
   
		-- emp.home_tel_num like '%010%'; -- 전화검색
		--  emp.mobile_tel_num like '%7954%'; -- 모바일번호검색;
-- 전체검색 
  (emp.login_id like '%파트장%'  -- 사원검색 아이디 
  or emp.emp_name like '%파트장%'  -- 사원검색 이름 
  or emp.dept_name like '%파트장%'  -- 부서검색 
  or pmp.dp_name like '%파트장%' -- 직급건색
  or pmd.dp_name like '%파트장%' -- 직책건색
  or emp.home_tel_num like '%파트장%' -- 전화검색
  or emp.mobile_tel_num like '%파트장%'); -- 모바일번호검색;




-- 
	SELECT 
				emp.emp_seq as empSeq,
				b.emp_name AS empName,
				(DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(emp.bday, '%Y')) + 1 AS age,
				if(emp.gender_code = 'M', '남', '여') AS genderCode,
		    (SELECT 
		            group_name
		        FROM
		            t_co_group
		        WHERE
		            group_seq = emp.group_seq) AS groupSeq,
		    (SELECT 
		            comp_name
		        FROM
		            t_co_comp_multi
		        WHERE
		            comp_seq = emp.main_comp_seq
		                AND lang_code ='kr') AS mainCompSeq,
		    (SELECT 
		            biz_name AS bizName
		        FROM
		            t_co_biz_multi
		        WHERE
		            biz_seq = (SELECT 
		                    biz_seq
		                FROM
		                    t_co_emp_dept
		                WHERE
		                    emp_seq = emp.emp_seq)
		                AND lang_code = 'kr') AS bizName,
		    emp.wedding_yn AS weddingYn,
		    b.main_work AS mainWork,
		    emp.join_day AS joinDay,
		    pmp.dp_name as positionCode,
		    pmd.dp_name as dutyCode,
		    date_format(emp.bday, '%m월 %d일') as bDay,
		    b.detail_addr as detailAddr,
		    emp.pic_file_id as picFileID,
		    emp.mobile_tel_num as mobileTelNum,
		    emp.email_addr as emailAddr
		    
		FROM
		    t_co_emp emp
		        LEFT OUTER JOIN
		    t_co_comp_duty_position_multi pmp ON emp.position_code = pmp.dp_seq
		        AND pmp.lang_code = 'kr'
		        AND pmp.dp_type = 'POSITION'
		        LEFT OUTER JOIN
		    t_co_comp_duty_position_multi pmd ON emp.duty_code = pmd.dp_seq
		        AND pmd.lang_code = 'kr'
		        AND pmd.dp_type = 'DUTY',
		    t_co_emp_multi b
		WHERE
		    emp.emp_seq = b.emp_seq
		    	and b.lang_code = 'kr'
		        AND emp.emp_seq = 78165;
				

-- 디테일 
		select 				
			  emp.pic_file_id as picFileID,
              emp.comp_name as compName,
			  emp.emp_name as empName,
			  emp.login_id as loginId, 
			  emp.bday,
              pmp.dp_name as positionCode,
			  pmd.dp_name as dutyCode,
              emp.dept_name as deptName,
              emp.mobile_tel_num as mobileTelNum,
			  emp.home_tel_num as homeTelNum,
              emp.fax_num as faxNum,
			  emp.comp_domain as compDomain,
              emp.email_addr as emailAddr,
              emp.main_work as mainWork
		from (select
					a.pic_file_id,
                    h.comp_name,
					d.dept_name,
					b.position_code as positionDuty,
					b.duty_code as deptDuty,
					e.emp_name,
					a.login_id,
                    a.bday,
					a.home_tel_num,
					a.mobile_tel_num,
					a.emp_seq,
                    b.fax_num,
                    a.email_addr,
                    f.comp_domain,
                    g.main_work,
				    b.comp_seq,
                    b.biz_seq,
                    b.dept_seq
				  from t_co_emp a, t_co_emp_dept b, t_co_dept c, t_co_dept_multi d , t_co_emp_multi e, t_co_comp f, t_co_emp_multi g, t_co_comp_multi h
				 where a.emp_seq = b.emp_seq
				   and b.dept_seq = c.dept_seq
				   and c.dept_seq = d.dept_seq 
				   and a.emp_seq = e.emp_seq
                   and b.comp_seq = f.comp_seq
                   and b.emp_seq = g.emp_seq
                   and b.comp_seq = h.comp_seq
                   and h.lang_code = 'kr'
				   and e.lang_code ='kr'
				   and d.lang_code = 'kr'
                   and g.lang_code ='kr')emp    
			LEFT OUTER JOIN t_co_comp_duty_position_multi pmp
				ON emp.positionDuty = pmp.dp_seq
				AND pmp.lang_code = 'kr'
				AND pmp.dp_type = 'POSITION'
			LEFT OUTER JOIN t_co_comp_duty_position_multi pmd
				ON emp.deptDuty = pmd.dp_seq
				AND pmd.lang_code = 'kr'
				AND pmd.dp_type = 'DUTY'
		  where emp.emp_seq= 78164
            and emp.dept_seq=681;



			
-- 부모찾기
 select a.parent_dept_seq as parentDeptSeq, (select dept_name
											  from t_co_dept_multi
											 where dept_seq = (select parent_dept_seq from t_co_dept where dept_seq = 681)
											   and lang_code = 'kr') as deptName,
														( select biz_name 
														    from t_co_biz_multi 
														   where biz_seq 
														     and lang_code ='kr'
														     and biz_seq = (select parent_dept_seq from t_co_dept where dept_seq = 681)) as bizName
																				 
  from t_co_dept a, t_co_dept_multi b
 where a.dept_seq = b.dept_seq 
   and a.dept_seq = 681
   and b.lang_code='kr';
   
   
--   
  select count(*) 
    from board a, user b 
   where a.user_no = b.no
    and (a.title like '%"+kwd+"%' or a.contents like '%"+kwd+"%' or b.name like '%"+kwd+"%');
			  
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
select dept_name
  from t_co_dept_multi
 where dept_seq = (select parent_dept_seq from t_co_dept where dept_seq = 681)
   and lang_code = 'kr';

select * 
  from t_co_biz_multi
 where biz_seq = 10000069 
   and lang_code ='kr';





select a.parent_dept_seq as parentDeptSeq, b.dept_name as deptName from t_co_dept a, t_co_dept_multi b
 where a.dept_seq = b.dept_seq
 and a.dept_seq = 681
 and b.lang_code='kr';

select * from t_co_dept where dept_seq = (select parent_dept_seq from t_co_dept where dept_seq = 681);

select b.biz_name 
  from t_co_biz a, t_co_biz_multi b
 where a.biz_seq = b.biz_seq 
   and b.lang_code ='kr'
   and a.biz_seq = (select parent_dept_seq from t_co_dept where dept_seq = 681);


select  a.login_id,
		a.home_tel_num,
		a.mobile_tel_num,
		a.emp_seq,
		a.bday,
        b.duty_code as deptDuty,
        b.position_code as positionDuty
      from t_co_emp a, t_co_emp_dept b 
	 where a.emp_seq = b.emp_seq;
     
     
select * from t_co_dept where comp_seq =7 and biz_seq = 10000069;
select * from t_co_emp;
select * from t_co_group;
select * from t_co_emp_dept where dept_seq = 681 limit 0, 100000;
select * from t_co_biz where comp_seq =7;
     
select * from t_co_comp_duty_position_multi where dp_seq like '%G%' and comp_seq = 7;
     
	
    
alter table t_co_emp add fulltext(`emp_seq`);
   
   
   
   
   
   
   
   
   
   
--
  select a.dept_seq as deptSeq, a.group_seq as groupSeq, a.comp_seq as compSeq, 
	    	 a.biz_seq as bizSeq, a.parent_dept_seq as parentDeptSeq, b.dept_name as deptName, a.dept_level as deptLevel, 
	    	 (select count(*) from t_co_dept c where parent_dept_seq = a.dept_seq) as childCount,
             (select count(emp_seq) from t_co_emp_dept where dept_seq = a.dept_seq) as deptEmpCount
		from t_co_dept a, t_co_dept_multi b
		where a.dept_seq = b.dept_seq
		and b.lang_code = 'kr'
		and a.use_yn = 'Y'
		and b.use_yn = 'Y'
		and parent_dept_seq = 100
		order by a.dept_seq + 0;
        
        
   select count(emp_seq) from t_co_emp_dept where dept_seq = 1991;


select count(*) from t_co_emp;
select count(*) from t_co_dept;
select count(*) from t_co_comp;
select count(*) from t_co_biz;

select * from quicksilver_douzone;
select * from quicksilver_douzone_en;
select * from config_max_id;




select * from t_co_emp_dept where emp_seq = 32475;
select * from t_co_dept where dept_seq = 4008;
select * from t_co_comp_duty_position_multi where comp_seq = 1 and dp_type='position' and lang_code ='kr';

select b.emp_name from t_co_emp a, t_co_emp_multi b where a.emp_seq = b.emp_seq and b.emp_name like '%김택%';

-- 겸직데이터 좀더
 INSERT INTO `t_co_emp_dept` (`dept_seq`, `emp_seq`, `group_seq`, `comp_seq`,  `biz_seq`, `main_dept_yn`, `duty_code`, `position_code`, `tel_num`, `fax_num`, `zip_code`, `orgchart_display_yn`, `messenger_display_yn`, `order_num`, `order_text`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date`)
VALUES ('681', '78164', 'demo', '7', '10000069', 'N', 'G55', 'AA73',																               Null, 		  Null,		  Null, 					'Y',					 'Y', 	 	 Null, Null, 'Y', '0101', '2019-05-09', '1010', '2019-05-09 12:58:39');
    -- 김택주 차장  본부장
    -- 		파트장 과장 

 INSERT INTO `t_co_emp_dept` (`dept_seq`, `emp_seq`, `group_seq`, `comp_seq`,  `biz_seq`, `main_dept_yn`, `duty_code`, `position_code`, `tel_num`, `fax_num`, `zip_code`, `orgchart_display_yn`, `messenger_display_yn`, `order_num`, `order_text`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date`)
VALUES ('3300', '32475', 'demo', '3', '10000023', 'N', 'G21', 'AA30',																               Null, 		  Null,		  Null, 					'Y',					 'Y', 	 	 Null, Null, 'Y', '0101', '2019-05-15', '1010', '2019-05-15 12:58:39');
    -- 김주영 주임 파트장
    -- 		대리 실장 -위에쿼리
    
 INSERT INTO `t_co_emp_dept` (`dept_seq`, `emp_seq`, `group_seq`, `comp_seq`,  `biz_seq`, `main_dept_yn`, `duty_code`, `position_code`, `tel_num`, `fax_num`, `zip_code`, `orgchart_display_yn`, `messenger_display_yn`, `order_num`, `order_text`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date`)
VALUES ('478', '57593', 'demo', '5', '10000048', 'N', 'G39', 'AA53',																               Null, 		  Null,		  Null, 					'Y',					 'Y', 	 	 Null, Null, 'Y', '0101', '2019-05-15', '1010', '2019-05-15 12:58:39');
	-- 남지훈 사원 파트장 
	-- 주임 파트장 위에
    
 INSERT INTO `t_co_emp_dept` (`dept_seq`, `emp_seq`, `group_seq`, `comp_seq`,  `biz_seq`, `main_dept_yn`, `duty_code`, `position_code`, `tel_num`, `fax_num`, `zip_code`, `orgchart_display_yn`, `messenger_display_yn`, `order_num`, `order_text`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date`)
VALUES ('3648', '36461', 'demo', '3', '10000027', 'N', 'G21', 'AA28',																               Null, 		  Null,		  Null, 					'Y',					 'Y', 	 	 Null, Null, 'Y', '0101', '2019-05-15', '1010', '2019-05-15 12:58:39');
     -- 최기석 부장 사업부장 
	 --  실장에 차장 위

 INSERT INTO `t_co_emp_dept` (`dept_seq`, `emp_seq`, `group_seq`, `comp_seq`,  `biz_seq`, `main_dept_yn`, `duty_code`, `position_code`, `tel_num`, `fax_num`, `zip_code`, `orgchart_display_yn`, `messenger_display_yn`, `order_num`, `order_text`, `use_yn`, `create_seq`, `create_date`, `modify_seq`, `modify_date`)
VALUES ('4008', '3003', 'demo', '4', '10000031', 'N', 'G30', 'AA42',																               Null, 		  Null,		  Null, 					'Y',					 'Y', 	 	 Null, Null, 'Y', '0101', now(), '1010', '2019-05-15 12:58:39');
	  -- 김세진 사원 파트장 
	 --       주임 팀장

select * from t_co_emp_dept where emp_seq = 14041;
select * from t_co_emp_dept_history;

-- 겸직히스토리 
 INSERT INTO `t_co_emp_dept_history` (`seq`,
									  `op_code`,
									  `reg_date`,
                                      `dept_seq`,
                                      `emp_seq`,
                                      `group_seq`,
                                      `comp_seq`,
                                      `biz_seq`,
                                      `main_dept_yn`,
                                      `duty_code`,
                                      `position_code`,
                                      `tel_num`,
                                      `fax_num`,
                                      `zip_code`,
                                      `orgchart_display_yn`,
                                      `messenger_display_yn`,
                                      `order_num`,
                                      `use_yn`,
                                      `create_seq`,
                                      `create_date`,
                                      `modify_seq`,
                                      `modify_date`)
VALUES (null, 
		'I',
        now(),
		#{deptSeq},
        #{empSeq},
        'demo',
        #{compSeq},
        #{bizSeq},		
        #{mainDeptYn}, 	
        #{dutyCode},		
        #{positionCode}, 		
        #{telNum},			
        #{fax_num}, 	 	
        Null,
        'Y',
        'Y',
        0, 
        'Y', 
        'admin',
        now(), 
        Null,
        Null);
        
     -- compSeq , empSeq ,      --  compSeq , bizSeq, mainDeptYn, dutyCode, positionCode 





-- UPDATE 테이블명 SET 컬럼1 = 수정값1 [, 컬럼2 = 수정값2 ...] [WHERE 조건];
select * from t_co_emp_dept;
-- 겸직 수정모드 
-- 1
update t_co_emp_dept 
set	duty_code = #{dutyCode},
	position_code = #{positionCode},
	main_dept_yn = #{mainDeptYn}
where emp_seq = #{empSeq}
  and dept_seq = #{deptSeq}

-- 2 
update t_co_emp_dept_history
set op_code = 'U',
    reg_date = now()
where emp_seq = #{empSeq}
  and dept_seq =#{deptSeq}

-- 3 위에인설트 
 


-- 삭제모드 
delete from t_co_emp_dept 
      where dept_seq = #{dept_seq}
        and emp_seq = #{emp_seq};
        
-- 삭제히스토리 수정
update t_co_emp_dept_history
set op_code = 'D',
    reg_date = now()
where emp_seq = #{empSeq}
  and dept_seq =#{deptSeq};


-- 



select * from t_co_emp_dept_history;







select * from t_co_emp_dept_history;
















-- -----------------------------------------------------------------------------------------------------------------------------------------

select * from t_co_emp_dept_history;

		select a.dept_seq as deptSeq, a.group_seq as groupSeq, a.comp_seq as compSeq,
	    	 a.biz_seq as bizSeq, a.parent_dept_seq as parentDeptSeq, a.dept_name as deptName, a.dept_level as deptLevel, 
	    	 a.childCount as childCount, a.deptEmpCount as deptEmpCount, c.dept_name as deptNameEn
		from (select a.dept_seq, a.group_seq, a.comp_seq,
		    	 a.biz_seq, a.parent_dept_seq, b.dept_name, a.dept_level, 
		    	 (select count(*) from t_co_dept c where parent_dept_seq = a.dept_seq) as childCount,
		    	 (select count(emp_seq) from t_co_emp_dept where dept_seq = a.dept_seq) as deptEmpCount
			from t_co_dept a, t_co_dept_multi b
			where a.dept_seq = b.dept_seq
			and b.lang_code = 'kr'
			and a.use_yn = 'Y'
			and b.use_yn = 'Y'
			and parent_dept_seq = 10) a
		left outer join t_co_dept_multi c
		on a.dept_seq = c.dept_seq
		and c.lang_code = 'en'
		order by a.dept_seq + 0;




select distinct(b.dept_seq) as dept_seq, (select count(*)
											from t_co_emp_dept a, t_co_dept b 
										   where a.dept_seq = b.dept_seq
											 and b.parent_dept_seq = b.dept_seq)  c
  from t_co_emp_dept a, t_co_dept b 
 where a.dept_seq = b.dept_seq
   and b.parent_dept_seq = 50;
									   
   select sum(                   
             (select count(*)
			    from t_co_emp_dept a, t_co_dept b
			   where a.dept_seq = b.dept_seq
				 and b.dept_seq = 100)
				+
			 (select count(*)
			    from t_co_emp_dept a, t_co_dept b ,(select distinct(b.dept_seq)
													  from t_co_emp_dept a, t_co_dept b 
													 where a.dept_seq = b.dept_seq
													   and b.parent_dept_seq = 100) c
				where a.dept_seq = b.dept_seq
				  and b.dept_seq = c.dept_seq)
                  
               
                   
		  );
                   
                   
                   
                   
                   
select count(*)
  from t_co_emp_dept a, t_co_dept b ,(select distinct(b.dept_seq)
										from t_co_emp_dept a, t_co_dept b 
									   where a.dept_seq = b.dept_seq
										 and b.parent_dept_seq = 1991) c
 where a.dept_seq = b.dept_seq
   and b.dept_seq = c.dept_seq;
   
select count(*)
  from t_co_emp_dept a, t_co_dept b
 where a.dept_seq = b.dept_seq
   and b.dept_seq = 100;
   
      
select * from quicksilver_douzone_en;







-- ------------------------저장 프로시저연습accessible
select * from t_co_biz;
select * from t_co_emp;

DELIMITER //
CREATE PROCEDURE call_t_co2(IN countryName VARCHAR(255))
BEGIN
select * from t_co_biz where group_seq = countryName;
END//

DELIMITER ;

call call_t_co2('demo2');



WITH RECURSIVE cte as
(
 select     dept_seq,
            parent_dept_seq
 from       t_co_dept
 where      parent_dept_seq = 100
 union all
 select     r.dept_seq,
            r.parent_dept_seq
 from       t_co_dept r
 inner join cte b 
 on r.parent_dept_seq = b.dept_Seq
)
 
select dept_seq,parent_dept_seq from cte;



-- 정석 					
		(select count(*)
		  from t_co_emp_dept e,
								( select  *
									from    (select dept_seq,parent_dept_seq
											 from t_co_dept
											 order by parent_dept_seq, dept_seq) products_sorted,
											(select @pv := '10' COLLATE utf8_unicode_ci) initialisation
									where   find_in_set(parent_dept_seq, @pv) > 0
									and     @pv := concat(@pv, ',', dept_seq)) f 
		 where e.dept_seq = f.dept_seq);
         
         
         
		(select count(emp_seq) from t_co_emp_dept where dept_seq = 10);
--

-- 안됨..
with recursive cte(dept_seq, parent_dept_seq) as
(
 select     dept_seq,
            parent_dept_seq
 from       t_co_dept
 where      parent = 10000001
 union all
 select     r.dept_seq,
            r.parent_dept_seq
 from       t_co_dept r
 inner join cte
         on r.parent_dept_seq = cte.dept_seq
)
select * from cte;
--

  select dept_seq, parent_dept_seq
	from    (select *
			 from t_co_dept
			 order by parent_dept_seq, dept_seq) products_sorted,
			(select @pv := '10' COLLATE utf8_unicode_ci) initialisation
	where   find_in_set(parent_dept_seq, @pv) > 0
	and     @pv := concat(@pv, ',', dept_seq); 					


--
DELIMITER //
CREATE PROCEDURE sum_dept_emp_count(IN p_dept_seq VARCHAR(255))
BEGIN
 select count(*)
	from (select * from t_co_dept
		  order by parent_dept_seq, dept_seq) products_sorted,
		 (select @pv := p_dept_seq COLLATE utf8_unicode_ci) initialisation
	where find_in_set(parent_dept_seq, @pv) > 0
	and   @pv := concat(@pv, ',', dept_seq);
END
//
DELIMITER ;


	select a.dept_seq as deptSeq, a.group_seq as groupSeq, a.comp_seq as compSeq,
	    	 a.biz_seq as bizSeq, a.parent_dept_seq as parentDeptSeq, a.dept_name as deptName, a.dept_level as deptLevel, 
	    	 a.childCount as childCount, c.dept_name as deptNameEn
		from (select a.dept_seq, a.group_seq, a.comp_seq,
		    	 a.biz_seq, a.parent_dept_seq, b.dept_name, a.dept_level, 
		    	 (select count(*) from t_co_dept c where parent_dept_seq = a.dept_seq) as childCount
			from t_co_dept a, t_co_dept_multi b
			where a.dept_seq = b.dept_seq
			and b.lang_code = 'kr'
			and a.use_yn = 'Y'
			and b.use_yn = 'Y'
			and parent_dept_seq = 10000001) a
		left outer join t_co_dept_multi c
		on a.dept_seq = c.dept_seq
		and c.lang_code = 'en'
		order by a.dept_seq + 0;
        
       -- + 
    
	
DELIMITER //
CREATE PROCEDURE dept_emp_count_sum(IN p_dept_seq VARCHAR(255))
BEGIN
	 SET @pv :=0;
     select sum(
				 (select count(distinct(e.emp_seq))
					  from t_co_emp_dept e,
											( select  dept_seq
												from    (select dept_seq,parent_dept_seq
														 from t_co_dept
														 order by parent_dept_seq, dept_seq) products_sorted,
														(select @pv := p_dept_seq COLLATE utf8_unicode_ci) initialisation
												where   find_in_set(parent_dept_seq, @pv) > 0
												and     @pv := concat(@pv, ',', dept_seq)) f 
					 where e.dept_seq = f.dept_seq)

					+
            
					(select count(emp_seq) from t_co_emp_dept where dept_seq = p_dept_seq) 
				);
END
//
DELIMITER ;
Call dept_emp_count_sum(1);
   

		  
select  dept_seq
from    (select dept_seq,parent_dept_seq
		 from t_co_dept
		 order by parent_dept_seq, dept_seq) products_sorted,
		(select @pv := '10' COLLATE utf8_unicode_ci) initialisation
where   find_in_set(parent_dept_seq, @pv) > 0
and     @pv := concat(@pv, ',', dept_seq);



-- ------------------------

	 select 
			count(*)
		from (select
					d.dept_name,
					b.position_code as positionDuty,
					b.duty_code as deptDuty,
					e.emp_name,
					a.login_id,
					a.home_tel_num,
					a.mobile_tel_num,
					a.emp_seq,
					b.comp_seq,
                    b.biz_seq,
                    b.dept_seq
				  from t_co_emp a, t_co_emp_dept b, t_co_dept c, t_co_dept_multi d , t_co_emp_multi e 
				 where a.emp_seq = b.emp_seq
				   and b.dept_seq = c.dept_seq
				   and c.dept_seq = d.dept_seq 
				   and a.emp_seq = e.emp_seq
				   and e.lang_code = 'kr'
				   and d.lang_code = 'kr') emp    
			LEFT OUTER JOIN t_co_comp_duty_position_multi pmp
				ON emp.positionDuty = pmp.dp_seq
				AND pmp.lang_code = 'kr'
				AND pmp.dp_type = 'POSITION'
			LEFT OUTER JOIN t_co_comp_duty_position_multi pmd
				ON emp.deptDuty = pmd.dp_seq
				AND pmd.lang_code = 'kr'
				AND pmd.dp_type = 'DUTY'
			LEFT OUTER JOIN t_co_emp_multi d
				on emp.emp_seq = d.emp_seq
				and d.lang_code = 'en'
			LEFT OUTER JOIN t_co_dept_multi f
				on emp.dept_seq = f.dept_seq
				and f.lang_code = 'en'
			where emp.dept_seq = 1
            
            union all 

	   select 
			  emp.emp_seq as empSeq,
			  emp.dept_seq as deptSeq,
			  pmp.dp_seq as positionCode,
			  pmd.dp_seq as dutyCode,
			  emp.emp_name as empName,
			  emp.login_id as loginId,
			  emp.home_tel_num as homeTelNum,
			  emp.mobile_tel_num as mobileTelNum,
			  d.emp_name as empNameEn, 
			  emp.comp_seq as compSeq,
			  emp.dept_name as deptName,
			  f.dept_name as deptNameEn,
			  pmp.dp_name as positionCodeName,
			  pmd.dp_name as dutyCodeName
		from (select
				count(*)
				  from t_co_emp a, t_co_emp_dept b, t_co_dept c, t_co_dept_multi d , t_co_emp_multi e 
				 where a.emp_seq = b.emp_seq
				   and b.dept_seq = c.dept_seq
				   and c.dept_seq = d.dept_seq 
				   and a.emp_seq = e.emp_seq
				   and e.lang_code = 'kr'
				   and d.lang_code = 'kr') emp    
			LEFT OUTER JOIN t_co_comp_duty_position_multi pmp
				ON emp.positionDuty = pmp.dp_seq
				AND pmp.lang_code = 'kr'
				AND pmp.dp_type = 'POSITION'
			LEFT OUTER JOIN t_co_comp_duty_position_multi pmd
				ON emp.deptDuty = pmd.dp_seq
				AND pmd.lang_code = 'kr'
				AND pmd.dp_type = 'DUTY'
			LEFT OUTER JOIN t_co_emp_multi d
				on emp.emp_seq = d.emp_seq
				and d.lang_code = 'en'
			LEFT OUTER JOIN t_co_dept_multi f
				on emp.dept_seq = f.dept_seq
				and f.lang_code = 'en'
			,(select  dept_seq 
				from (select dept_seq , parent_dept_seq
						from t_co_dept
					order by parent_dept_seq, dept_seq) products_sorted,
				     (select @pv := '1' COLLATE utf8_unicode_ci) initialisation
					   where find_in_set(parent_dept_seq, @pv) > 0
					  	 and @pv := concat(@pv, ',', dept_seq)) g
		where g.dept_seq = emp.dept_seq;
       
       
       
       select * from t_co_emp_dept where dept_seq = 1; 
       
       
       
       
       
       
       
       
       
       
       
       
       -- 
       select 
				  emp.emp_seq as empSeq,
				  emp.dept_seq as deptSeq,
				  pmp.dp_seq as positionCode,
				  pmd.dp_seq as dutyCode,
				  emp.emp_name as empName,
				  emp.login_id as loginId,
				  emp.home_tel_num as homeTelNum,
				  emp.mobile_tel_num as mobileTelNum,
				  d.emp_name as empNameEn, 
				  emp.comp_seq as compSeq,
				  emp.dept_name as deptName,
				  f.dept_name as deptNameEn,
				  pmp.dp_name as positionCodeName,
				  pmd.dp_name as dutyCodeName
			from (select
						d.dept_name,
						b.position_code as positionDuty,
						b.duty_code as deptDuty,
						e.emp_name,
						a.login_id,
						a.home_tel_num,
						a.mobile_tel_num,
						a.emp_seq,
						b.comp_seq,
	                    b.biz_seq,
	                    b.dept_seq
					  from t_co_emp a, t_co_emp_dept b, t_co_dept c, t_co_dept_multi d , t_co_emp_multi e 
					 where a.emp_seq = b.emp_seq
					   and b.dept_seq = c.dept_seq
					   and c.dept_seq = d.dept_seq 
					   and a.emp_seq = e.emp_seq
					   and e.lang_code = 'en'
					   and d.lang_code = 'en') emp    
				LEFT OUTER JOIN t_co_comp_duty_position_multi pmp
					ON emp.positionDuty = pmp.dp_seq
					AND pmp.lang_code = 'en'
					AND pmp.dp_type = 'POSITION'
				LEFT OUTER JOIN t_co_comp_duty_position_multi pmd
					ON emp.deptDuty = pmd.dp_seq
					AND pmd.lang_code = 'en'
					AND pmd.dp_type = 'DUTY'
				LEFT OUTER JOIN t_co_emp_multi d
					on emp.emp_seq = d.emp_seq
					and d.lang_code = 'en'
				LEFT OUTER JOIN t_co_dept_multi f
					on emp.dept_seq = f.dept_seq
					and f.lang_code = 'en'
				where emp.dept_seq = 101
				order by empName asc;
                
                
                
                
                
                
                
                
                
		 select 
			  emp.emp_seq as empSeq,
			  emp.dept_seq as deptSeq,
			  pmp.dp_seq as positionCode,
			  pmd.dp_seq as dutyCode,
			  emp.emp_name as empName,
			  emp.login_id as loginId,
			  emp.home_tel_num as homeTelNum,
			  emp.mobile_tel_num as mobileTelNum,
			  d.emp_name as empNameEn, 
			  emp.comp_seq as compSeq,
			  emp.dept_name as deptName,
			  f.dept_name as deptNameEn,
			  pmp.dp_name as positionCodeName,
			  pmd.dp_name as dutyCodeName
		from (select
					d.dept_name,
					b.position_code as positionDuty,
					b.duty_code as deptDuty,
					e.emp_name,
					a.login_id,
					a.home_tel_num,
					a.mobile_tel_num,
					a.emp_seq,
					b.comp_seq,
                    b.biz_seq,
                    b.dept_seq
				  from t_co_emp a, t_co_emp_dept b, t_co_dept c, t_co_dept_multi d , t_co_emp_multi e 
				 where a.emp_seq = b.emp_seq
				   and b.dept_seq = c.dept_seq
				   and c.dept_seq = d.dept_seq 
				   and a.emp_seq = e.emp_seq
				   and e.lang_code = 'kr'
				   and d.lang_code = 'kr') emp    
			LEFT OUTER JOIN t_co_comp_duty_position_multi pmp
				ON emp.positionDuty = pmp.dp_seq
				AND pmp.lang_code = 'en'
				AND pmp.dp_type = 'POSITION'
			LEFT OUTER JOIN t_co_comp_duty_position_multi pmd
				ON emp.deptDuty = pmd.dp_seq
				AND pmd.lang_code = 'en'
				AND pmd.dp_type = 'DUTY'
			LEFT OUTER JOIN t_co_emp_multi d
				on emp.emp_seq = d.emp_seq
				and d.lang_code = 'en'
			LEFT OUTER JOIN t_co_dept_multi f
				on emp.dept_seq = f.dept_seq
				and f.lang_code = 'en'
			where emp.dept_seq = 101
			order by empName asc;
        
        
        
        
select emp_name from t_co_emp_multi where emp_name like "김%" and lang_code = 'kr' order by emp_seq asc limit 0, 100; 
select emp_name from t_co_emp_multi where emp_name like "Gong%" and lang_code = 'en' order by emp_seq asc limit 0, 100; 
select emp_name from t_co_emp_multi order by emp_seq asc; 
-- 성 : 28개 2800개, 영어 : 28개 총 56개
-- 근데 걍 다넣음 용량얼마안됨


select distinct(dept_name) from t_co_dept_multi order by dept_seq asc;  -- 부서이름

select distinct(dp_name) from t_co_comp_duty_position_multi; -- 직책,직급
 
select distinct(mobile_tel_num) from t_co_emp; -- 전번

select distinct(login_id) from t_co_emp; -- 로그인아이디


select path_name from t_co_dept_multi order by dept_seq asc;  -- 부서이름

select * from t_co_dept_multi where path_name = '부서01';  -- 부서이름


select dept_name from t_co_dept_multi limit 0 ,100000;





SELECT 
		/*+ RULE */ 
	    empSeq,
	    positionCode,
	    dutyCode,
	    deptName,
	    empName,
	    loginId,
	    homeTelNum,
	    mobileTelNum,
	    deptSeq, 
		empNameEn,
		deptNameEn
		from
        quicksilver_douzone
		WHERE	
		`query` = '"*김*";
		limit=100050;mode=boolean;maxmatches=100050;';
	


select * from t_co_biz where comp_Seq =1;
select * from t_co_comp;

select * from t_co_emp_dept where comp_seq = 1;

select * from t_co_biz_multi where comp_Seq =1;


select c.comp_name as compName, count(b.comp_seq) as compEmpCount
	  from t_co_emp_dept a, t_co_comp b, t_co_comp_multi c
	 where a.comp_seq = b.comp_seq 	
	   and b.comp_seq = c.comp_seq
	   and c.lang_code = 'kr'
	 group by b.comp_seq;
     
     
select c.comp_name as compName, count(a.comp_seq) as compEmpCount
	  from t_co_emp_dept a right join t_co_comp b 
        on a.comp_seq = b.comp_seq
		, t_co_comp_multi c
        where b.comp_seq = c.comp_seq 
          and c.lang_code ='kr'
	 group by b.comp_seq;
        
 select b.biz_name as bizName, count(distinct(d.emp_seq)) as bizEmpCount
		from t_co_biz a, t_co_biz_multi b, t_co_comp c,t_co_emp_dept d
	   where a.biz_seq= b.biz_seq 
		 and a.comp_seq = c.comp_seq
		 and a.biz_seq = d.biz_seq
		 and b.lang_code = 'kr'
		 and a.comp_seq = 1
	group by a.biz_seq;
     
     
     
select b.biz_name as bizName, count(distinct(c.emp_seq)) as bizEmpCount
	from t_co_biz a left join t_co_emp_dept c
      on a.biz_seq = c.biz_seq , t_co_biz_multi b
	where a.biz_seq= b.biz_seq 
	 and b.lang_code = 'kr'
	 and a.comp_seq = 1
	group by a.biz_seq;
    
-- ------------------------------------------

select a.gender_code as genderCode, count(a.gender_code) as genderCount 
  from t_co_emp a, t_co_emp_dept b 
where a.emp_seq = b.emp_seq 
  group by a.gender_code;
 
 
  select a.gender_code as genderCode, count(a.gender_code) as genderCount 
    from t_co_emp a, t_co_emp_dept b
   where a.emp_seq = b.emp_seq
     and b.comp_seq = 1
group by gender_code;    

select count(*) from t_co_emp_dept where comp_seq = 1;
    
select * from t_co_comp;






	select a.comp_seq as compSeq, if(a.use_yn = 'Y', '사용', '미사용') as useYn, a.owner_name as ownerName, a.comp_regist_num as compRegistNum,
			a.comp_num as compNum, a.standard_code as standardCode, a.comp_cd as compCd, a.order_num as orderNum,
			a.biz_condition as bizCondition, a.item, a.tel_num as telNum, a.fax_num as faxNum, a.zip_code as zipCode,
		    a.addr, a.detail_addr as detailAddr, a.homepg_addr as homepgAddr, (case(a.native_lang_code)when'kr' then '한국어' else '영어' end) as nativeLangCode, 
		    a.comp_domain as compDomain, b.comp_name as compName, c.comp_name as compNameEn
		from
			(select a.comp_seq, a.use_yn, b.owner_name, a.comp_regist_num, a.comp_num, a.standard_code,
					a.comp_cd, a.order_num, b.biz_condition, b.item, a.tel_num, a.fax_num, a.zip_code,
			        b.addr, b.detail_addr, a.homepg_addr, a.native_lang_code, a.comp_domain
			from t_co_comp a, t_co_comp_multi b
			where a.comp_seq = b.comp_seq
			and b.lang_code = 'kr'
			and a.comp_seq = 1) a
		left outer join t_co_comp_multi b
		on a.comp_seq = b.comp_seq
		and b.lang_code = 'kr'
		left outer join t_co_comp_multi c
		on a.comp_seq = c.comp_seq
		and c.lang_code = 'en';
        
        
        
        
        
        
        
        
        
        
        
        
        -- ----------------------------------------
        
        
        
        
        
        select 
			  emp.emp_seq as empSeq,
			  emp.dept_seq as deptSeq,
			  pmp.dp_seq as positionCode,
			  pmd.dp_seq as dutyCode,
			  emp.emp_name as empName,
			  emp.login_id as loginId,
			  emp.home_tel_num as homeTelNum,
			  emp.mobile_tel_num as mobileTelNum,
			  d.emp_name as empNameEn, 
			  emp.comp_seq as compSeq,
			  emp.dept_name as deptName,
			  f.dept_name as deptNameEn,
			  pmp.dp_name as positionCodeName,
			  pmd.dp_name as dutyCodeName
		from (select
					d.dept_name,
					b.position_code as positionDuty,
					b.duty_code as deptDuty,
					e.emp_name,
					a.login_id,
					a.home_tel_num,
					a.mobile_tel_num,
					a.emp_seq,
					b.comp_seq,
                    b.biz_seq,
                    b.dept_seq
				  from t_co_emp2 a, t_co_emp_dept b, t_co_dept c, t_co_dept_multi d , t_co_emp_multi e 
				 where a.emp_seq = b.emp_seq
				   and b.dept_seq = c.dept_seq
				   and c.dept_seq = d.dept_seq 
				   and a.emp_seq = e.emp_seq
				   and e.lang_code = 'kr'
				   and d.lang_code = 'kr') emp    
			LEFT OUTER JOIN t_co_comp_duty_position_multi pmp
				ON emp.positionDuty = pmp.dp_seq
				AND pmp.lang_code = 'kr'
				AND pmp.dp_type = 'POSITION'
			LEFT OUTER JOIN t_co_comp_duty_position_multi pmd
				ON emp.deptDuty = pmd.dp_seq
				AND pmd.lang_code = 'kr'
				AND pmd.dp_type = 'DUTY'
			LEFT OUTER JOIN t_co_emp_multi d
				on emp.emp_seq = d.emp_seq
				and d.lang_code = 'en'
			LEFT OUTER JOIN t_co_dept_multi f
				on emp.dept_seq = f.dept_seq
				and f.lang_code = 'en'
			where	
				emp.dept_seq = 5445;
        
        
        
        
        