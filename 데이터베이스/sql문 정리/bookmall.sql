desc book;
desc cart;
desc category;
desc customer;
desc order_book;
desc request;


select * from book;
select * from cart;
select * from category;
select * from customer;
select no,book_no from order_book;
select * from request;


insert into customer values(null, 'KimSeJun', '010-4250-7675', 'wns8628@naver.com', '부산해운대구 우2동 동부올림픽 타운 113-1303', '123456');
insert into customer values(null, 'HongGildong', '010-7777-5555', 'Gildong@naver.com', '서울 강남 강남아파트 110-301', '7777');

insert into category values(null, '액션');
insert into book values(null, '나루토', 3000, 1);
insert into cart values(null, 1, 2, 10);
insert into order_book values(null, 1);
insert into request values(null, 2);


-- 
insert into book values(null, '원피스', 5000, 1);

-- 1. 회원리스트 -2명 

select a.title, b.name, a.price
 from book a, category b
where b.no = a.category_no;
-- 2. 카테고리 리스트 – 3개
-- 3. 상품리스트 – 3개


-- 4. 카트 리스트 
select a.title, b.count, a.price, c.name
  from book a, cart b, customer c
 where a.no = b.book_no
   and c.no = b.customer_no;

-- 5. 주문 리스트 – 1개
select a.no as "주문번호", b.name , b.email, c.총주문가격, b.shipping
  from request a, customer b , (select c.no, sum(b.count * a.price) as "총주문가격"
								  from book a, cart b, customer c
								 where a.no = b.book_no
								   and c.no = b.customer_no
							  group by c.no) c
where a.customer_no = b.no
  and b.no = c.no;                              
 
-- 6. 주문 도서 리스트 
select a.no ,a.title, b.총판매권수  
  from book a, (select a.no, sum(b.count) as 총판매권수
				  from book a, cart b, customer c, request d
				 where a.no = b.book_no
				   and c.no = b.customer_no
				   and c.no= d.customer_no
			  group by a.no) b
where a.no = b.no;

SET SQL_SAFE_UPDATES =0;


delete from order_book;
delete from request;
delete from cart;
delete from book;
delete from customer;
delete from category;

ALTER TABLE category AUTO_INCREMENT=1;
ALTER TABLE book AUTO_INCREMENT=1;
ALTER TABLE customer AUTO_INCREMENT=1;
ALTER TABLE cart AUTO_INCREMENT=1;
ALTER TABLE request AUTO_INCREMENT=1;
ALTER TABLE order_book AUTO_INCREMENT=1;
 
 



select * from book;
select * from cart;
select * from category;
select * from customer;
select no,book_no from order_book;
select * from request;

SELECT 
    c.title, a.합계, b.합계, d.name
FROM
    (SELECT 
        a.no, SUM(b.count) '합계'
    FROM
        book a, cart b, customer c
    WHERE
        a.no = b.book_no
	AND 
		b.customer_no = c.no
    GROUP BY a.no) a,
    (SELECT 
        a.no, SUM((a.price * b.count)) '합계'
    FROM
        book a, cart b, customer c
    WHERE
        a.no = b.book_no
            AND b.customer_no = c.no
    GROUP BY a.no) b,
    book c,
    customer d,
    cart e
WHERE
    a.no = b.no AND b.no = c.no
        AND c.no = e.book_no
        AND d.no = e.customer_no;



