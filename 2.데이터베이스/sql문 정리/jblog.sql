select * from user;
select * from blog;
select * from post;
select * from category;

desc blog;
-- 회원가입
insert into user values(null, 123,123,123,now());
-- 회원가입시 블로그생성
insert into blog values(1,'123님의 블로그입니다.','/assets/images/default.jpg');
-- 로그인
select no,name from user where id=123 and password=123;

-- 블로그가져오기
select no from user where name = 123;
select user_no,title,logo from blog where user_no = 1;



-- 카테고리 insert
insert into category values(null, '자바','자바에대한것들',now(),1);
insert into category values(null, '데이터베이스','데이터베이스에대한것들',now(),1);
insert into category values(null, '스프링','스프링에대한것들',now(),1);
insert into category values(null, '자바스크립트','자바스크립트에 에대한것들',now(),1);

select no,name,description,reg_date, user_no from category where user_no = 1;

-- post insert
insert into post values(null, '1번 자바글입니다','1번 자바글내용입니다.',now(),1);
insert into post values(null, '2번 자바글입니다','2번 자바글내용입니다.',now(),1);
insert into post values(null, '3번 자바글입니다','3번 자바글내용입니다.',now(),1);
insert into post values(null, '1번 디비글입니다','1번 디비글내용입니다.',now(),2);
insert into post values(null, '1번 디비글입니다','2번 디비글내용입니다.',now(),2);
insert into post values(null, '1번 디비글입니다','3번 디비글내용입니다.',now(),2);

select a.no, a.title, a.content, a.reg_date, a.category_no
  from post a, category b 
 where a.category_no = b.no
   and a.category_no = 1
   and b.user_no = 1
   and a.no=1; 
   
   
select a.no, a.title, a.content, a.reg_date, a.category_no
  from post a, category b 
 where a.category_no = b.no
   and a.category_no = 1
   and b.user_no = 1;
