
-- 루트에서하세요~ 

-- db생성
create database bookmall;

-- 유저생성 
create user 'bookmall'@'localhost' identified by 'bookmall'; 

-- 권한주기
grant all privileges on bookmall.* to 'bookmall'@'localhost'; 


drop database bookmall;

-- db생성
create database webdb;

-- 유저생성 
create user 'webdb'@'localhost' identified by 'webdb'; 

-- 권한주기
grant all privileges on webdb.* to 'webdb'@'localhost'; 


drop database webdb;