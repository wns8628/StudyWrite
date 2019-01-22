select name,owner, birth from pet;
select * from pet;

insert into pet values('마음이2', '둘리', 'dog', 'f', '2018-11-11', null);

delete from pet where name = '마음이2';

update pet set owner = '마이콜', gender ='m' where name= '마으미';


desc book;
desc author;

insert 
  into author
values (null,'맹자','');
 
 
 select no, name, bio from autohr;
 
 
 -- ---------------------
 select * from book;
 select * from author;
 
 
 insert into book values(null, '뉴문', '대여가능', 2);
 delete from book where title = '뉴문';
 
  select a.title, a.status, b.name
    from book a, author b
   where a.no2 = b.no  
order by a.no asc;


select title from book where no = 1;
update book set status = '대여중' where no= 1;
  