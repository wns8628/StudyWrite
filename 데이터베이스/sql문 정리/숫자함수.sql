-- 절대값
select abs(10), abs(-10);

-- 나머지
select mod(234,10), 254 % 10;

-- x보다 크지 않은 가장 큰정수 
select floor(1.23), floor(-1.23);

-- x보다 작지않은 가장작은 정수
select ceil(3.14), ceiling(3.14),
	   ceil(-3.14), ceiling(-3.14);

-- 반올림
select round(-1.23), round(-1.56), round(1.56);
select round(1.298, 1), round(1.298, 0); 

-- x의 y제곱승 반환
select pow(2,2), power(2,-2);

-- 음수= -1 , 0이면0 , 양수 = 1 
select sign(-10), sign(0), sign(100);

-- 가장큰 값 반환
select greatest(5,4,3,2,1),
	   greatest(3.14, 4.26, 5.8),
	   greatest("ABCD","ABCF","ABCG");
       
-- 가장 작은
select least(5,4,3,2,1);
		
