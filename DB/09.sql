-- abs: 절대값
-- round: 반올림 round(필드값, -2) , round(필드값, 2)
-- replace (필드값, 찾을 값, 바꿀 값)
-- char_length, length
-- left, right, substr
-- ifnull(필드명, 바꿀값)
-- 번호 주기 set @Num = 0;
------------------------------------------------
-- sysdate( ) : 현재 날짜 시간
select sysdate();

-- date_format( ) : 날짜 데이터 형식화                                        -- m : 숫자  M : 영어  
select orderdate, 
date_format(orderdate, '%y/%m/%d  %M  %h:%s')        
from orders;

-- adddate(날짜, interval 10 day, month, year) : 날짜 기간 차이
select orderdate, adddate(orderdate, interval 10 month) as '10달 후'      
from orders;

-- lpad() / rpad                                                       ------------------- 시험    
select lpad(5, 10, '*');
select rpad(5, 10, '*');

-- 전화번호 가운데까지만 표시하고 뒤에는 * 표시
select rpad(left(phone, 9), 13, '*' ) from customer;

-- 8.내장함수를 사용하여 주문 테이블의 고객명별 산 책의 평균을 구하되 백단위에서 잘라 주세요               -------------- round는 반올림, truncate는 그냥 자르기
select name, avg(saleprice) 평균, truncate(avg(saleprice), -2) 자르기    
from orders o, customer c where o.custid = c.custid 
group by c.name;       

