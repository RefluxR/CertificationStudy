show databases;

use madang;

show tables;
desc book;
-- 고객 번호가 3번인 고객의 id와 이름과 주소를 검색 

select custid, name, address
from customer
where custid = 3;

-- 출판사가 이상미디어 중 가격이 20000원 이상인 책의 이름과 출판사명 가격을 검색

select bookname, publisher, price
from book
where publisher = "이상미디어" and price >= 20000;
-----------------------------------------------------------------
-- 책을 주문한 날짜가 7월 4일부터 7월 7일까지의 도서를 검색해라
select *
from orders
where orderdate between '2014-07-04' and '2014-07-07';

-----------------------------------------------------------------
-- 고객의 번호가 1번 또는 3번인 고객번호 이름 전화번호를 검색
select custid, name, phone
from customer
where custid in (1, 3);
-- 1번 빼고 3번 빼고 다 가져오기
select custid, name, phone
from customer
where custid not in (1, 3);

---------------------------------------------------------------
select * from customer where phone is null;
-- 고객테이블에서 박씨 성을 가진 고객의 이름
select name, address
from customer 
where name like "박%";
-- 고객테이블에서 대전에 사는 고객의 이름과 주소를 검색
select name, address
from customer
where address like "%대전%";
-- 출판사가 굿스포츠 이면서 축구에 관련된 책의
-- 이름과 출판사명 가격 검색
select bookname, publisher, price
from book
where publisher = '굿스포츠' and bookname like "%축구%"; 

-------------------------------------------------
-- 도서 테이블에서 출판사 명 검색 (중복된거 없이!!)
select distinct publisher
from book;

-- 주문테이블에서 한번이라도 책을 구매한 고객의 번호를 검색
select distinct custid
from orders;

--------------------------------------------------- 
-- 도서테이블에서 가격이 싼 순으로
select * from book
order by price asc;

-- 도서책이 같은 출판사인 경우 책 가격이 비싼순으로 책 이름 도서가격 검색
select bookname, publisher, price
from book
order by publisher desc, price desc;

-- 주문테이블에 고객들이 구입한 책의가격이 비싼순으로 고객의 번호 책을 구입한금액을 검색
select custid, saleprice
from orders
order by custid, saleprice desc;

----------------------------------------------------------
-- group by
-- 주문테이블에서 팔린 책의 전체평균과 총점을 출력

select avg(saleprice) as "총평균", sum(saleprice) as "합계"
from orders;

-- 고객테이블의 고객의 몇 명인지와 전화번호가 있는 고객의 갯수를 세보기
select count(*) as "고객의 수", count(phone) as "연락 가능한 고객 수" 
from customer;


-- 주문테이블에서 고객번호별로 책을 구매한 합계와 평균을 출력
select custid as "고객번호", sum(saleprice) as "구매 합계", avg(saleprice) as "구매 평균" 
from orders
group by custid;

-- 30000원 이상 결제한 사람만 출력
select custid as "고객번호", sum(saleprice) as "구매 합계", avg(saleprice) as "구매 평균" 
from orders
group by custid
having sum(saleprice) >= 30000;

-- group by 앞에 where 있어도 가능하긴 함 ㅋㅋ ---------------------------------------------------------------
select custid as "고객번호", sum(saleprice) as "구매 합계", avg(saleprice) as "구매 평균" 
from orders
where custid in (1,3)
group by custid;

-- 도서테이블에서 출판사별로 책가격이 가장 비싼 책의 가격을 검색해 보세요 
-- 단 책 가격이 20000원 이상인 책만
select publisher, max(price) as "가격"
from book
where price >= 20000
group by publisher;

select publisher, max(price) as "가격"
from book
group by publisher
having max(price) >= 20000;

-- 주문테이블에서 책 번호 별로 판매금액의 합계를 검색하되 판매금액의 합계가 10000원 이상인
-- 책의 판매 금액의 합계를 구해라

select bookid, sum(saleprice) as "판매금액 합계"
from orders
group by bookid
having sum(saleprice) >= 10000;

-- 도서테이블의 도서의 갯수를 검색
select count(bookname)
from book;

---------------------------------------------------------------------------------------------------------
-- 도서테이블의 출판사의 갯수를 검색해라 ---------------- 요놈 좀 신박함
select count(distinct publisher) as "중복 없는 출판사 갯수"
from book;

-- 고객테이블에서 전화번호가 없는 고객의 개수를 검색
select count(*) as "전화번호 없어"
from customer
where phone is null;

-- 도서테이블에서 야구에 관련된 책의 갯수 출력
select count(*) as "기아 화이팅"
from book
where bookname like "%야구%";

select * from orders;
-- 책 가격이 8000원 이상인 책을 구매한 고객에 대해 고객별 도서의 총수량을 검색하되 
-- 책을 두 번 이상 구매한 고객의 번호와, 구매한 책의 갯수, 총 가격
select custid, count(*) as "구매갯수", sum(saleprice) as "총가격"
from orders
where saleprice >= 8000
group by custid
having count(*) >= 2;

---------------------------------------------------------------------------------------------------------------
-- join

-- 어떤 고객이 어떤 책을 얼마에 구입했는지 검색
-- 고객이름, 책이름, 구입한도서가격검색
select c.name, b.bookname, o.saleprice
from orders o, customer c, book b
where o.custid = c.custid and b.bookid = o.bookid;

-- 박씨 성을 가진 고객만 추출
select c.name, b.bookname, o.saleprice
from orders o, customer c, book b
where o.custid = c.custid and b.bookid = o.bookid
and name like "박%";

-- 고객명별 책을 구매한 책가격의 합계와 평균을 출력 ( 단 구매한 책의 가격이 30000원 이상)
select c.name, sum(o.saleprice) as 합계 , avg(o.saleprice) as 평균
from orders o, customer c, book b
where o.custid = c.custid and b.bookid = o.bookid
group by c.name
having 합계 >= 30000;
-- sum(o.saleprice)

-- 고객이 주문한 도서의 판매가격을 검색하되 각 고객별로 비싼책 먼저 출력
-- 고객명 산 책의 가격을 검색

select c.name, o.saleprice
from orders o
join customer c on c.custid = o.custid
join book b on b.bookid = o.bookid
order by c.name desc, o.saleprice desc;

-- 서울에 거주하는 고객이 주만한 고객의 이름과 주소 구입한 책가격을 검색
select c.name, c.address, o.saleprice
from orders o
join customer c on c.custid = o.custid
join book b on b.bookid = o.bookid
where c.address like "%서울%";



