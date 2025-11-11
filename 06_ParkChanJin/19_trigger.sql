/*  19_TRIGGER
        - INSERT, UPDATE, DELETE 발생 시
          지정된 동작을 자동으로 수행하는 객체
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

-- tbl_order 테이블에 insert
INSERT INTO tbl_order
VALUES (NULL,
        DATE_FORMAT(CURRENT_DATE, '%Y%m%d'),
        DATE_FORMAT(CURRENT_TIME, '%H%i%s'),
        0
   );

SELECT * FROM tbl_order;

-- tbl_order_menu 에 INSERT -> TRIGGER 동작
INSERT INTO tbl_order_menu
VALUES (2, 16, 2);

-- TRIGGER 가 동작했을까?
SELECT * FROM tbl_order;

INSERT INTO tbl_order_menu
VALUES (2,4, 5);

-- TRIGGER 가 동작했을까?
SELECT * FROM tbl_order;
SELECT * FROM tbl_order_menu;
