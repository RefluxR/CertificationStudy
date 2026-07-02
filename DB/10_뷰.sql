use madang;

-- 뷰 : 원본 테이블에서 원하는 필드를 가져와 또 다른 가상의 테이블 생성
-- 규칙 : 원본 삽입 -> 뷰 삽입 ,   뷰 삽입 -> 원본 삽입
-- 원본 변경 뷰 변경 // 뷰 변경 원본 변경
-- 원본 삭제 뷰 삭제 // 뷰 삭제 원본 삭제


-- book 테이블에서 축구라는 문구가 포함된 책 번호 책이름 가격을 가져오는 뷰 정의
create view v1
as select bookid, bookname, price from book where bookname like "%축구%";

select * from v1;

-- 원본 삽입 시 뷰 삽입 -
insert into book values(11, '박지성은 축구', '경기출판사', 25000);
select * from v1;

-- 뷰 삽입 시 원본 삽입
insert into v1 values(12, '여자 축구', 15000);
select * from book;  -- 원본 테이블도 수정이 된다.

-- 원본 변경시 뷰도 같이 변경됨
-- 책 번호 12인 책의 가격 10000원으로 변경
update book set price = 10000 where bookid = 12;
select * from v1;
-- 책 번호가 11인 v1 테이블의 책 제목을 박지성은 축구, 가격은 20000으로 변경
update v1 set price = 20000, bookname = '박지성은 축구' where bookid = 11;
select * from book;

-- 원본 삭제시 뷰 삭제
delete from book
where bookid = 11;
select * from v1;

-- 뷰 삭제 시 원본 삭제
delete from v1 where bookid = 12;
select * from book;

-- 뷰 변경                                                    -----
-- v1 뷰의 모든 필드를 가져오는 책가격이 20000원인 뷰로 변경
alter view v1
as 
select * from book where price >= 20000;
-- with check option;

select * from v1;

-- v1 테이블에 책번호가 20, 책 이름 '스포츠의 역사', 출판사 '경기출판사', 가격 15000
insert into v1 values(20, '수영의 추억', '경기출판사', 15000);
select * from v1;
select * from book;                                          -- 뷰에는 생성이 안됨(price >= 20000) 그러나 원본 테이블에는 생성됨

alter view v1 as select * from book where price >= 20000
with check option;                                           -- 만약 with check option을 주게 되면 - 조건(price >= 20000) 에 걸려서 저장 안됨

-- 어떤 고객이 어떤 책을 얼마에 구매하는지 (이름 도서명 구입가격)검색하는 뷰 정의
create view v2
as select c.name, b.bookname, o.saleprice
from orders o, book b, customer c
where o.bookid = b.bookid and c.custid = o.custid;

select * from v2;

insert into orders values(11, 5, 3, 15000, sysdate());

-- 고객 (이름)별 도서를 구매한 판매금액의 합계와 평균을 출력하는 뷰 정의      
create view v3(이름, 총계, 평균)                                  -- as도 가능하지만 해당 방법으로 컬럼명 지정 가능
as select c.name, sum(saleprice), avg(saleprice) from orders o, book b, customer c
where o.bookid = b.bookid and c.custid = o.custid
group by o.custid;

select * from v3 where 이름 = '박지성';


-- 조건에 만족하지 않는 뷰는 삽입 변경을 제한하는 명령어 with check option 사용
-- 뷰 제약
-- 1. 기본키나 not null 속성의 필드를 정의하지 않은 뷰는 삽입 X
-- 2. 조인된 뷰는 뷰를 삽입 변경 삭제 X
-- 3. 계산된 뷰는 변경할 수 없음
-- 조인된 뷰나 계산된 뷰는 삽입, 변경, 삭제 용으로 보안을 유지하며 간편하게 검색을 수행
-- 검색 시 속도를 인덱스를 활용하여 빠르게 검색 수정 삭제

-- create index 인덱스 이름 on 테이블(필드)
create index ix_book
on book(bookname);

-- 인덱스 삭제
-- drop index 이름 on 테이블명
drop index ix_book on book;


