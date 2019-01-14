SET SQL_SAFE_UPDATES =0;

-- 테이블 생성
create table pet(
	name varchar(20),
    owner varchar(20),
    species varchar(20),
    gender char(1),
    birth date,
    death date
);

-- 구조보기 
desc pet;  

-- 데이터삽입
insert into pet values('마으미', '대혁', 'dog' , 'f', '2018-10-10', null);
insert into pet values('마미', '대혁', 'dog' , 'f', '2018-10-10', null);
insert into pet values('으미', '대혁', 'dog' , 'f', '2018-10-10', null); 

-- 삭제
delete from pet where name = '마으미';
-- 데이터 전체삭제
truncate pet;
-- 보기 
select * from pet;

---------------------------------------------------------------------------

create table employees(
	no INT(11) NOT NULL auto_increment,
	birth_date date,
	first_name varchar(14),
    last_name  varchar(16),
    gender char(1),
    hir_date date,
    PRIMARY KEY(no)
);

select * from employees;

insert into employees(birth_date,first_name,last_name,gender,hir_date) values('1993-08-10','김','세준','M',null);
insert into employees(birth_date,first_name,last_name,gender,hir_date) values('1993-08-11','홍','길동','M',null);
insert into employees(birth_date,first_name,last_name,gender,hir_date) values('1993-08-12','김','택주','M',null);
insert into employees(birth_date,first_name,last_name,gender,hir_date) values('1993-08-13','최','기석','F',null);
insert into employees(birth_date,first_name,last_name,gender,hir_date) values('1993-08-14','김','상욱','F',null);

truncate employees;

-- 오름차순 , 별칭 
select last_name as "이름", gender as "성별", birth_date as "입사일" from employees ORDER BY birth_date asc ; 

-- 남직원수 여직원수
select count(if(gender="M", gender, null)) as "남직원" , count(if(gender="F", gender, null)) as "여직원" from employees;


