-- 트리거 
create database examtri;
use examtri;

create table triaaa(
	id int primary key,
    name char(2) not null
);
create table tribbb(
	id_1 int primary key,
    name_1 char(2) not null
);
show tables;

-- 삽입 트리거 정의 / triaaa가 삽입 시 tribbb에도 삽입

-- delimiter 써서 ; 중첩 방지
DELIMITER  //  
create trigger tri_in
after insert on triaaa for each row
begin
	insert into tribbb values(new.id, new.name);
end;
// 
DELIMITER ;

insert into triaaa values(1, '상연');
insert into triaaa values(2, '철수');
insert into triaaa values(3, '길동');
select * from triaaa;
select * from tribbb;

-- 변경 트리거 정의
DELIMITER  //  
create trigger tri_up
after update on triaaa for each row
begin
	update tribbb set name_1 = new.name 
    where id_1 = new.id;
end;
// DELIMITER ;

update triaaa set name = '은호' where id =1;
select * from triaaa;
select * from tribbb;

SHOW TRIGGERS;
 
-- 삭제 트리거 정의
DELIMITER  //  
create trigger tri_de
after delete on triaaa for each row
begin
	delete from tribbb where id_1 = old.id;
end;
// DELIMITER ;

delete from triaaa where id = 1;
select * from triaaa;
select * from tribbb;

-- 복사 copy

create table triccc
as
select * from triaaa;