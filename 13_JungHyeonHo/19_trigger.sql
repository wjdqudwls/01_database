/* 19_TRIGGER
   - INSER, UPDATE, DELETE 발생 시
   지정된 동작을 자동으로 수행하는 객체
 */

DELIMITER //
CREATE OR REPLACE TRIGGER after_order_menu_insert
    AFTER INSERT -- INSERT 후에 트리거 발동, INSERT에 값이 있다면 덮어씌움
    ON tbl_order_menu -- tbl_order_menu 테이블에 대해서 발동
    FOR EACH ROW -- 각 행에 대하여
BEGIN -- tbl_order_menu 테이블에 INSERT 시에 아래 내용 수행
    UPDATE tbl_order
    SET total_order_price = total_order_price + NEW.order_amount * (SELECT menu_price
                                                                    FROM tbl_menu
                                                                    WHERE tbl_menu.menu_code = NEW.menu_code)
    WHERE order_code = NEW.order_code;
end //
DELIMITER ;

-- tbl_order 테이블에 insert
INSERT INTO tbl_order
VALUES (NULL, date_format(current_date, '%Y%m%d'),
        date_format(current_time, '%H%i%s'), 0);

select *
from tbl_order;


-- tbl_order_menu에 INSERT -> TRIGGER 동작 확인
INSERT INTO tbl_order_menu
VALUES (1, 3, 2);
SELECT *
FROM tbl_order;
SELECT *
FROM tbl_order_menu;