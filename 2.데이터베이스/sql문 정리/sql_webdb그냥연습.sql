-- *web db --

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

-- load data txt파일 데이터 테이블에넣기
load data local infile "c:\\pet.txt" into table pet;
select * from pet;

-- select 
select * from pet; 														-- 모든데이터 보기
select * from pet where name = 'Bowser';								-- 바우저의 모든데이터보기
select * from pet where birth >= '1998-01-01'; 							-- 1998년 1월1일이후 태어난놈 데이터 
select * from pet where species = 'dog' and gender ='f';				-- 여자인놈 
select * from pet where species = 'snake' or species = 'bird';			-- 뱀,새놈
select name, birth from pet;											-- 이름,생일만
select name, birth from pet order by birth; 							-- asc정렬 
select name, gender,birth from pet order by gender asc, birth asc; 		-- 젠더로정렬후 생일로 정렬

-- null 다루기 
select * from pet where gender is null;   								-- is null 이렇게써야됨 
select * from pet where gender is not null;   							-- is not null 이렇게써야됨 

-- 패턴매칭 like 같은
select * from pet where name like 'b%';									-- 이름이 b로 시작하는놈
select * from pet where name like 'b____';								-- 이름이 b로 시작5글자 
select * from pet where name like '%fy';								-- 이름이 fy로끝나는모
select * from pet where name like '%w%';								-- 이름에 w에들어간거 
select * from pet where name like '_____';								-- 이름에 5자인놈
select * from pet where length(name) = 5;								-- 이름에 5자인놈

-- 집계함수
select count(*) as "총 애완동물 수" from pet; 								-- 전체 카운트
select name,count(*) as "총 애완동물 수" from pet; 	-- 말이안되는쿼리 
select owner as "주인",count(*) as "애완동물 수" from pet group by owner;	-- 각주인별 애완동물 수 
--
select owner as "주인",count(*) as "애완동물 수" 
	from pet
    group by owner having count(*) > 1;									-- 각주인별 애완동물 수 2이상인거
--
select owner as "주인",count(*) as "애완동물 수"
	from pet 
	where death is null or death = '0000-00-00'
    group by owner having count(*) > 1;									-- 각주인별 살아있는 애완동물 수 2이상인거
--
    
    
-- guestbook -------------------------------- model 1 실습-------------------------------
-- table emaillist test
desc emaillist;

-- insert
insert 
  into emaillist
values(null, '둘', '리', 'dooly@gmail.com');

insert 
  into emaillist 
values(null, '마', '이콜', 'michol@gmail.com');
 
-- select
select no,first_name, last_name, email
  from emaillist
order by no desc;

-- -----------------------------------------
-- guest book 

select no , name, password,message, reg_date
       from guestbook;

select now();

insert into guestbook
      values(null,'김세준',password('1234'),'안녕 세준아!', now());
 
delete from guestbook where no=8 and password = password('1234');

ALTER TABLE guestbook AUTO_INCREMENT=1;

delete from guestbook; 

SET SQL_SAFE_UPDATES =0;

-- ---------------------------------------------------------------------------------------------

select * from user;
