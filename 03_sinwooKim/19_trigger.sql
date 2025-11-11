/*
TRIGGER
    - INSERT, UPDATE, DELETE 발생시 지정된 동작을 자동으로 수행하는 DBMS '객체'
*/

DELIMITER //

CREATE OR REPLACE TRIGGER after_order_menu_insert
    AFTER INSERT
    ON tbl_order_menu
    FOR EACH ROW
BEGIN
    UPDATE tbl_order
    SET total_order_price
            = total_order_price
            + NEW.order_amount
                  * (SELECT menu_price
                     FROM tbl_menu
                     WHERE menu_code = NEW.menu_code)
    WHERE order_code = NEW.order_code;
end //
DELIMITER ;

-- tbl_order 테이블에 INSERT
INSERT INTO tbl_order
VALUES (null,
        DATE_FORMAT(CURRENT_DATE,'%y%m%d'),
        DATE_FORMAT(CURRENT_DATE,'%h%i%s'),
        0);

SELECT * FROM tbl_order;

-- tbl_order_menu에 INSERT -> TRIGGER 동작 확인
INSERT INTO tbl_order_menu
VALUES (1,1,3);