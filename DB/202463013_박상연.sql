-- 202463013 박상연
create database examtri;
use examtri;

create table goods(
	pronum char(4) not null primary key,
    proname varchar(20) not null,
    price int check(price > 0),
    stock int default(0)
);
create table ordering(
	num int not null primary key auto_increment,
    pronum char(4),
    orderdate date not null,
    account int check(account > 0),
    orderprice int check(orderprice > 0),
    foreign key (pronum) references goods(pronum)
);

INSERT INTO goods ( pronum, proname, price ) VALUES ('AAAA', '새우깡', 1500);
INSERT INTO goods ( pronum, proname, price ) VALUES ('BBBB', '초코파이', 1200);
INSERT INTO goods ( pronum, proname, price ) VALUES ('CCCC', '짱구', 1500);

-- (1) 
delimiter // 
create trigger tr1
after insert on ordering for each row
begin
	update goods set stock = stock + new.account 
    where pronum = new.pronum;
end ;
// delimiter ;

-- (2)
delimiter // 
create trigger tr2
after update on ordering for each row
begin
	update goods set stock = stock - (old.account - new.account) 
    where pronum = new.pronum;
end ;
// delimiter ;

-- (3)
delimiter // 
create trigger tr3
after delete on ordering for each row
begin
	update goods set stock = stock - old.account
    where pronum = old.pronum;
end ;
// delimiter ;

-- (4)
create table sales(
	num int not null primary key auto_increment,
    pronum char(4),
    account int,
	foreign key (pronum) references goods(pronum)
);

-- (5)
delimiter // 
create trigger tr4
after insert on sales for each row
begin
	update goods set stock = stock - new.account
    where pronum = new.pronum;
end ;
// delimiter ;


-- 테스트 ==================================================== 테스트
select * from goods;
select * from ordering;
select * from sales;

insert into ordering(pronum, orderdate, account, orderprice) values('AAAA', '2023-11-21', 10, 1000);
insert into ordering(pronum, orderdate, account, orderprice) values('BBBB', '2023-11-21', 15, 1000);
insert into ordering(pronum, orderdate, account, orderprice) values('CCCC', '2023-11-21', 10, 1000);
insert into ordering(pronum, orderdate, account, orderprice) values('AAAA', '2023-11-21', 10, 1000);

update ordering set account = 5 where pronum = 'AAAA' and num = 1;

delete from ordering where num = 4;

insert into sales (pronum,account) values ('AAAA',1);

-- 프로시저 만들기

create table 전화번호(
	id int primary key,
    name char(10) NOT NULL,
	phone char(14)
);

-- insert procedure 생성 ---------------------------------------------------------------

delimiter //
create procedure test1(
	in inid int,
    in inname char(10),
    in inphone char(14) )
begin
	insert into 전화번호(id, name, phone) values(inid, inname, inphone);
end;
// delimiter ;

call test1(1, '상연','01093156070');
call test1(2, '시험','01096172070');
call test1(3, '응애','01093722830');

select * from 전화번호;

-- update procedure 생성  ---------------------------------------------------------------
delimiter //
create procedure test2(
	in inid int,
    in inname char(10),
    in inphone char(14))
begin
	update 전화번호 
    set name = inname, phone = inphone
    where id = inid;
end;
// delimiter ;

call test2(2, '대학', '33344445555');

select * from 전화번호;

-- delete procedure 생성  ---------------------------------------------------------------
delimiter //
create procedure test3(
	in inid int)
begin
	delete from 전화번호  
    where id = inid;
end;
// delimiter ;

call test3(3);

select * from 전화번호;

-- 검색 프로시저 ---------------------------------------------------------------------------
delimiter //
create procedure p_select( in inid int)
begin
	select * from 전화번호 where id = inid;
end;	
// delimiter ;

call p_select(1);

-- ------------------------------ call 함수 호출 시 id가 있으면 변경, id가 없으면

delimiter //
create procedure p_up_in(
	in inid int,
    in inname char(10), 
    in inphone char(14))
begin

	declare num int;
    select count(*) into num from 전화번호 where  id = inid;
    
    if (num = 0) 
		then 
			insert into 전화번호 values(inid, inname, inphone);
		else
			update 전화번호 set id = inid, name = inname, phone = inphone where id = inid;
        
	end if;
end;
// delimiter ;

call p_up_in(3, '한국', '02333');
call p_up_in(4, '일본', '02333');
call p_up_in(4, '미국', '02333');

select * from 전화번호;  
--  -------------------------
--  -------------------------
--  -------------------------
--  -------------------------
--  -------------------------
--  -------------------------
--  -------------------------
-- 확인 실습

-- 1. 삽입프로시저 (입고(ordering )테이블에 상품을 삽입하는 프로시저 정의)
-- 함수호출 해서 상품등록되면  상품(goods) 재고수량 변경

drop procedure p1;
delimiter //
create procedure p1 (
    in inpronum char(4),
    in inorderdate date,
    in inaccount int,
    in inorderprice int)
begin
	insert into ordering(pronum, orderdate, account, orderprice) values(inpronum, inorderdate, inaccount, inorderprice);
end;
// delimiter ;

call p1('AAAA', '2023-11-21', 10, 1000);
select * from ordering;

-- 2. 변경프로시저 정의(입고 테이블에 입고번호가 같은  입고수량변경시 변경되는 프로시저 정의)
delimiter //
create procedure p2 (
	in innum int,
    in inaccount int)
begin
	update ordering set account = inaccount where num = innum;
end;
// delimiter ;

call p2(5, 6);
select * from ordering;

-- 3. 삽입/변경 프로시저 정의 (상품 테이블의 상품코드가 다르면 삽입 상품코드가 같으면 변경하는 프로시저정의)
drop procedure p3;

delimiter //
create procedure p3 (
	in inpronum char(4) ,
    in inproname varchar(20),
    in inprice int)
begin
	declare num int;
    
    select count(*) into num from goods where pronum = inpronum;
	
    if (num = 0)
    then
		insert into goods ( pronum, proname, price ) values(inpronum, inproname, inprice);
    else
		update goods set pronum = inpronum, proname = inproname, price = inprice where pronum = inpronum;
    end if;
end;
// delimiter ;

call p3('AAAA', '공부', 1500);
call p3('DDDD', '대학', 1500);

select * from goods;

