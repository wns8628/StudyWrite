
-- 루트에서하세요~ 

-- db생성
create database bookmall;

-- 유저생성 
create user 'bookmall'@'localhost' identified by 'bookmall'; 

-- 권한주기
grant all privileges on bookmall.* to 'bookmall'@'localhost'; 


drop database bookmall;

-- db생성
create database jblog;
-- 유저생성 
create user 'jblog'@'localhost' identified by 'jblog'; 
-- 권한주기
grant all privileges on jblog.* to 'jblog'@'localhost'; 

grant all privileges on *.* to 'webdb'@'%' identified by 'webdb';


-- ----

create user 'quicksilver'@'%' identified by 'root12'; 
grant all privileges on quicksilver.* to 'quicksilver'@'%'; 
grant all privileges on *.* to 'quicksilver'@'%' identified by 'root12';
