-- 부질의(subquery)
-- 하나의 SQL 문 안에 다른 SQL 문이 중첩된nested 질의를 말함.
-- 다른 테이블에서 가져온 데이터로 현재 테이블에 있는 정보를 찾거나 가공할 때 사용함.
-- 보통 데이터가 대량일 때 데이터를 모두 합쳐서 연산하는 조인보다 필요한 데이터만 찾아서 
-- 공급해주는 부속질의가 성능이 더 좋음.
-- 주 질의(main query, 외부질의)와 부속질의(sub query, 내부질의)로 구성됨. 
use madang;

select * from book;
select * from customer;
select * from orders;

-- 가장 비싼 도서와 가장 싼 도서의 이름을 검색
select bookname, price 
from book
where price = (select max(price) from book) or price = (select min(price) from book);
-- 또는
SELECT bookname, price
FROM book
WHERE price in (
    (SELECT MAX(price) FROM book),
    (SELECT MIN(price) FROM book)
);

-- 도서 테이블에서 책 가격의 평균보다 높은 책의 이름과 가격 검색
select bookname, price
from book
where price >= (select avg(price) from book);

-- 출판사가 대한미디어 이거나 굿스포츠와 같은 출판사인 책의 이름 책 가격을 검색

select bookname, price
from book
where publisher in ('대한미디어', '굿스포츠');

----------------------------------------------------------------- 
-- 주문 테이블에서 책을 단 한번이라도 주문한 고객의 이름을 검색 (조인 X)

select name
from customer
where custid in (
	select distinct custid from orders
);

-- 주문 안 한 사람 검색

select name
from customer
where custid not in (
	select distinct custid from orders
);

-- 책번호가 1번 또는 3번인 책과 동일한 출판사인 -------------------------------------------------------
-- 책의 이름 출판사 이름을 검색

select bookname, publisher
from book
where publisher in (
(select publisher from book where bookid in (1,3))
);

select bookname, publisher
from book
where publisher in (
(select publisher from book where bookid = 1),
(select publisher from book where bookid = 3)
);

-- 책을 한번도 구매하지 않은 고객의 이름과 전화번호를 검색 ------------------ no in 의 중요성

select name, phone
from customer
where custid not in (select custid from orders);

---------------------------------------------------------------------------
-- all 모두 some(any) 
-- 3번 고객이 주만한 도서의 최고금액보다 더 비싼 도서를 구입한 주문테이블의 주문번호와 금액 검색
select orderid, saleprice
from orders
where saleprice > all (
select saleprice from orders where custid = 3
);

-- exist 데이터의 존재 유무를 확인하는 연산자
-- exist 연산자로 대한민국에 거주하는 고객에 판매한 도서의 총 판매액을 검색 ----- 조인 이용
select * from customer;

select sum(o.saleprice)
from orders o, customer c
where  o.custid = c.custid and 
c.address like "%대한민국%"; 

-------------------------------------------- exist 이용
select sum(o.saleprice)
from orders o
where exists(
	select * from customer c
    where o.custid = c.custid and
    address like "%대한민국%"
);

-- 출판사별로 출판사의 평균도서 가격보다 비싼 도서의 이름 검색 ----------------------------------------------------------------------------------------------------#####
select bookname, price
from book b1
where b1.price > (
select avg(price) from book b2 where b1.publisher = b2.publisher
);

------------------------------------------------------------------------------------ null값 채우기
-- 모든 고객을 출력하고 한번도 책을 구매하지 않은 고객은 null로 채우는 쿼리문 작성 --- outer join

---------------------------------------------------------------------------------------------------------------
-- 합집합 (union)
-- 영국에 거주하는 고객의 이름과 도서를 구매한 적이 없는 고객의 이름을 검색

select name from customer where address like '%영국%'
union
select name from customer where custid not in (select custid from orders);


--------------------------------------------------------------------- 트랜젝션

-- insert into 테이블명 (필드명1, 필드명2) values(값1, 값2)
start transaction;

insert into book(bookid, bookname, price, publisher) values (11, '데이터베이스', 30000, '경기출판사');

select * from book;

-- update 테이블명 set 바꿀값1, 바꿀값2, where {반드시 기본키값으로 바꾸기}
-- 도서번호가 3번인 도서를 도서이름은 "축구현실"으로 바꾸기, 도서가격을 25000원으로 바꾸기
update book
set bookname = "축구현실", price = 25000
where bookid = 3;  -- (select bookid from hook where bookname = '축구의 이해');

-- delete from 테이블 where 조건  {반드시 기본키값으로 바꾸기}
delete from book where bookid = 11;

rollback;

