/* 19 TRIGGER
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

-- 주문 테이블 INSERT
INSERT
  INTO tbl_order
(
  order_code
, order_date
, order_time
, total_order_price
)
VALUES
(
  NULL
, DATE_FORMAT(CURRENT_DATE, '%Y%m%d')
, DATE_FORMAT(CURRENT_TIME, '%H%i%s')
, 0
);

-- 주문 메뉴 테이블 INSERT 1
INSERT
  INTO tbl_order_menu
(
  order_code
, menu_code
, order_amount
)
VALUES
(
  1
, 3
, 2
);

-- 주문 메뉴 테이블 INSERT 2
INSERT
  INTO tbl_order_menu
(
  order_code
, menu_code
, order_amount
)
VALUES
(
  1
, 6
, 3
);

SELECT * FROM tbl_order;
SELECT * FROM tbl_order_menu;

-- 다시 되돌려 테스트 해보고자 할 경우
-- 1) rollback하기
ROLLBACK;

-- 2) 기존 데이터 지우기
DELETE FROM tbl_order WHERE 1 = 1;
DELETE FROM tbl_order_menu WHERE 1 = 1;

-- 이후 AUTO_INCREMENT도 다시 초기화 해 준다.
ALTER TABLE tbl_order AUTO_INCREMENT = 1;

INSERT
  INTO tbl_order_menu
(
  order_code
, menu_code
, order_amount
)
VALUES

(
  1
, 3
, 6
);