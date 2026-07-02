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

