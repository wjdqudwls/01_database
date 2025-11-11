/* 19_TRIGGER
   - INSERT, UPDATE, DELETE 밯생 시
   지정 된 동작을 자동으로 수행하는 객체
*/
DELIMITER //

CREATE OR REPLACE TRIGGER after_order_menu_insert
    AFTER INSERT
    ON tbl_order_menu
    FOR EACH ROW
    BEGIN
        UPDATE tbl_order
        SET total_order_price -- 통합금액
        = total_order_price
              +NEW.order_amount -- NEW == INSERT에 사용 된 값
          * (SELECT menu_price
             FROM tbl_menu
             WHERE menu_code = NEW.menu_code)
        WHERE order_code = NEW.order_code;
    end;

DELIMITER ;

-- tbl_order 테이블에 INSERT
INSERT INTO tbl_order
VALUES (NULL,
       DATE_FORMAT(CURRENT_DATE, '%Y%m%d'),
        DATE_FORMAT(CURRENT_TIME, '%H%i%s'),
        0);
SELECT * FROM tbl_order;

-- tbl_order_menu에 INSERT -> TRIGGER 동작 확인
INSERT INTO tbl_order_menu
VALUES (1,16,2);

-- 트리거가 동작 했을까?
SELECT * FROM tbl_order;

INSERT INTO tbl_order_menu
VALUES (1,3,2);

SELECT * FROM tbl_order;
SELECT * FROM tbl_order_menu;
