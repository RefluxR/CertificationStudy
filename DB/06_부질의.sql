-- 부질의(subquery)
-- 하나의 SQL 문 안에 다른 SQL 문이 중첩된nested 질의를 말함.
-- 다른 테이블에서 가져온 데이터로 현재 테이블에 있는 정보를 찾거나 가공할 때 사용함.
-- 보통 데이터가 대량일 때 데이터를 모두 합쳐서 연산하는 조인보다 필요한 데이터만 찾아서 
-- 공급해주는 부속질의가 성능이 더 좋음.
-- 주 질의(main query, 외부질의)와 부속질의(sub query, 내부질의)로 구성됨. 


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