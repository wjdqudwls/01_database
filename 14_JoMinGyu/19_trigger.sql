
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

select * from tbl_order;

