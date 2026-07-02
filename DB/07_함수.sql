use madang;

-- abs(-17) abs(17)
select abs(-17), abs(17);

-- round(123.567, 1) 소수점 1자리까지 출력 
-- round(124567, -2)
select round(123.567, 1), round(1234567, -2);

-- 주문테이블에서 고객번호 별로 책을 구매한 평균 출력 (단 소수점은 뒤에 한자리까지 출력)
select custid, round(avg(saleprice),1)
from orders
group by custid;

-- left(필드명, 몇개) right(필드명, 몇개), substr(필드명, 몇번째부터, 몇개)                          == left, right, substr
select left(name, 1), substr(name, 2, 1), right(name, 2)
from customer;


-- 고객의 성씨별로 그 성씨의 갯수를 출력 (박씨 : 3, 김씨 : 2 ) -------------------------------- 개 어렵네 ##
select left(name, 1) as '성', count(name) as '갯수'
from customer 
group by left(name, 1);

-- char_length(name) : 문자수 length(name) : 바이트수                                                         == char_length
select bookname, char_length(bookname),  length(bookname)
from book;

-- sysdate() , adddate(기준날짜, interval 10 day)                                          
select sysdate();                                                                               -- sysdate() 

-- 주문일자로 부터 10일 후 날짜를 출력
select orderdate, adddate(orderdate, interval 10 day)                                              -- adddate() ##
from orders;

-- null 인 데이터를 문자열로 출력 ifnull(필드명, '채울문자열')                                              -- ifnull()
select name, phone, ifnull(phone, '연락처 없음') from customer;

-- set @num = 0;                                                                                              -- set 시험에 나옴!!! 
set @num = 0;
select (@num := @num +1) '번호', name, phone from customer;


