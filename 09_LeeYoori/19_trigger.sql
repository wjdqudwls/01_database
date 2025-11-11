/*
    19_trigger
    - insert, update, delete 발생 시 지정된 동작을 자동으로 수행하는 dbms 객체

*/
DELIMITER //

CREATE OR REPLACE TRIGGER after_order_menu_insert
    AFTER INSERT
    ON tbl_order_menu
    FOR EACH ROW
BEGIN
    UPDATE tbl_order
    SET total_order_price = total_order_price + NEW.order_amount * (SELECT menu_price FROM tbl_menu WHERE menu_code = NEW.menu_code)
    WHERE order_code = NEW.order_code;
END//

DELIMITER ;

-- Tbl_order 테이블에 insert
insert into tbl_order
values(null,
       date_format(current_date, '%Y%m%d')
      , time_format(current_time, '%H%i%s')
        ,0
      );

select * from tbl_order;

-- tbl_order_menu에 insert > trigger 동작 확인
insert into tbl_order_menu
values(1, 16, 2);

insert into tbl_order_menu
values(1, 3, 1);

-- 트리거가 동작했을까?
select * from tbl_order;
select * from tbl_order_menu;