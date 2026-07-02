use test;

-- 1번
create view v1
as 
select empno, empname, title, dno from employee where dno = 3;

select * from v1;

-- 2번
alter view v1
as
select empno, empname, dno, salary from employee where dno = 3;

-- 3번
create view v2
as 
select empname, (salary * 1.1) '인상된 봉급' from EMPLOYEE;
select * from v2;

-- 4번
create view v3
as 
select e.empname, e.title, d.deptname, e.salary 
from employee e, DEPARTMENT d
where d.deptno = e.dno and e.dno = 2;
select * from v3;

-- 5번                                            -- 이거 나온다 
create view v4
as 
select d.deptname, avg(e.salary) as '급여 평균'
from employee e, DEPARTMENT d
where d.deptno = e.dno 
group by d.deptname;
select * from v4; 

-- 6번                                             -- 이거 나온다 ㅋㅋ  / 부서명 검색해라 해서... select title from v5; 요런 맹키로
create view v5
as 
select deptname
from DEPARTMENT
where deptno not in ( 
	select dno from EMPLOYEE
);
select * from v5;

-- 7번
create view v6
as 
select e.empname, d.deptname, e.salary
from employee e, DEPARTMENT d
where d.deptno = e.dno 
order by e.dno, e.salary desc;
select * from v6;

-- 8번
create view v7
as 
select d.deptname, sum(e.salary) as '봉급 합계', avg(e.salary) as '봉급 평균'
from employee e, DEPARTMENT d
where d.deptno = e.dno 
group by d.deptname
having avg(e.salary) >= 3000000;
select * from v7;

-- 9번                                             -- 직송상사의 이름과 직급도 보여라 문제 나옴
drop view v8;
create view v8(사원이름, 직속상사이름, 직급상사직급)
as
select e1.empname, e2.empname, e2.title
from EMPLOYEE e1, EMPLOYEE e2 
where e1.manager = e2.empno;

select 사원이름, 직속상사이름 from v8 where 사원이름 = '김상원';

-- 10번                                                           -- 시험
drop view v9;
create view v9(부서명, 사원명)
as 
select d.deptname, e.empname
from DEPARTMENT d
left outer join employee e on e.dno = d.deptno;

select * from v9 where 사원명 is null;

-- 11번                                                         -- 낸다 이거 
set @num = 0;
select (@num := @num+1) as '번호', e1.empname, d.deptname, e1.salary 
from employee e1, DEPARTMENT d
where d.deptno = e1.dno and 
e1.salary > 
(select avg(e2.salary) from employee e2 where e1.dno = e2.dno group by e2.dno );

-- 12번                                                       -- 낸다 이거
select lpad(right(e.empname, 2), 3, '*') as '이름', e.title, d.deptname
from employee e, DEPARTMENT d
where e.dno = d.deptno and title = (select title from employee where empname = '김상원');

-- 13번
create index idx_1 on department(deptname);

-- 14번
drop index idx_1 on department;