-- 데이터타입은 찾아보셈 

-- char , varchar : varchar는 줄이고늘리고함 , 
-- char는 정해진길이임 빠르고 대신 잡아놓으니 낭비가있겠지
-- BLOB = 큰이미지나,음악 ..바이트 저장 
-- text = 게시글 내용 같은거 저장할때

-- create
create table member(
	no int unsigned not null,
    email varchar(50) not null,
    password varchar(20) not null,
    name varchar(20),
    department_name varchar(20) not null default 'none',
    
	primary key(no)
);

-- ALTER---------------------------------------------------------
alter table member add column juminbunho char(13) not null;             -- 만들기
alter table member drop column juminbunho;			       			    -- 날리기 
alter table member add column juminbunho char(13) not null first;	    -- 맨앞으로 필드지정;
alter table member add column juminbunho char(13) not null after name;  -- name뒤로

alter table member change no no int unsigned not null auto_increment;					 -- 이름 도메인바꾸기 
alter table member change department_name dept_name varchar(20) not null default 'none'; -- 이름 바꾸기 

alter table member rename user;
-- -------------------------------------------

desc member;
desc user;
drop table member;
drop table user;
drop table dept;

-- foreign key constraint(제약조건:데이터의 생성, 삭제, 수정에 제약을 준다)
create table dept(	
	no int unsigned not null auto_increment,
    name varchar(50) not null,
 
	primary key(no)
);

create table user(
	no int unsigned not null auto_increment,
	email varchar(50) not null,
    password varchar(64) not null,
    name varchar(20),
	juminbunho char(13) not null,
    join_date datetime not null,
    dept_no int unsigned, 
    
	primary key(no),
    foreign key(dept_no) references dept(no)
    -- on delete restrict -- set null, cascade 
    -- on delete set null     
       on delete cascade 
);

desc dept;
desc user;
select * from dept;
select * from user;

insert into dept(name) values('개발팀');

insert into user values(null, 'a@a.com', password('1234'),'둘리', '', now(), 1);


 -- on delete restrict 
delete from dept where no = 1; -- 그냥 못지우지 왜냐 1번참조하고있으니깐 on delete restrict 
delete from user where no = 1; -- 얘를 지우고나서 지워야함

-- on delete set null 
delete from dept where no = 1;  -- 얘를 지우면 밑에 null처리가된다. 그필드만
delete from user where no = 1;  -- 위에거 실행시 null처리됨

-- on delete cascade 
delete from dept where no = 1; -- 애를 지우면 참조하는것들도 다같이 지워짐 폭포처럼~ cascade 
delete from user where no = 1; -- 위에거 실행시 이것도지워짐

