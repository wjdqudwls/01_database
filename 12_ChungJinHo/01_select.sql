select  a.menu_code
      , a.menu_name
      , a.menu_price
  from  tbl_menu AS a
 order  by
        a.menu_code;

select 7+3
  from dual;

SELECT NOW() AS 현재시간;
SELECT CONCAT('홍',' ','길동') 'full name';

-- menudb 내 모든 테이블 조회하기
select * from menudb.tbl_category;
select * from menudb.tbl_menu;
select * from menudb.tbl_order;
select * from menudb.tbl_order_menu;
select * from menudb.tbl_payment;
select * from menudb.tbl_payment_order;