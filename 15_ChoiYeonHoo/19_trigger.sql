/*
    19_TRIGGER
    - 데이터베이스 테이블에서 발생하는 특정 이벤트가 발생했을 때, 자동으로 실행되는 데이터베이스 객체
        : INSERT, DELETE, UPDATE
    - 주 사용 목적은 데이터의 무결성을 유지하고, 복잡한 비즈니스 로직을 처리하기 위함.
    - 트리거를 남용할 시, 성능 문제나 복잡성 증가와 같은 부정적인 영향을 줄 수 있음.

    Trigger 종류
    - Before : 이벤트가 발생하기 전에 실행, 데이터 유효성 검사나 변형에 주로 사용
    - After : 이벤트가 발생 한 후에 실행, 데이터 로깅, 알림 전송 등의 작업
*/

/*
    [작성법]
    DELIMITER //

    CREATE OR REPLACE TRIGGER [트리거명]
        BEFORE|AFTER [이벤트 타입]
        ON [테이블명]
        FOR EACH ROW
    BEGIN

    END//

    DELIMITER ;
*/

DELIMITER //

CREATE OR REPLACE TRIGGER after_order_menu_insert
    AFTER INSERT
    ON tbl_order_menu
    FOR EACH ROW
    -- tbl_order_menu에 insert 된 후에 after_order_menu_insert가 실행 될거다.


    BEGIN
        UPDATE tbl_order
        SET total_order_price -- 통합 금액
            = total_order_price -- 기존 금액 +
                    -- NEW는 위 AFTER INSERT 에 사용 된 값
                  + NEW.order_amount * (SELECT menu_price
                                        FROM tbl_menu
                                        WHERE menu_code = NEW.menu_code)
        WHERE order_code = NEW.order_code;

    END //

DELIMITER ;

-- 주문 tbl_order 테이블에 INSERT
INSERT INTO tbl_order
VALUES(null,
       DATE_FORMAT(CURRENT_DATE,'%Y%m%d'),
       DATE_FORMAT(CURRENT_TIME,'%H%i%s'),
       0);

SELECT * FROM tbl_order;

-- 주문 1번에 대해서 tbl_order_menu에 데이터 넣음
-- tbl_order_menu에 INSERT -> TRIGGER 동작 확인

INSERT INTO tbl_order_menu
VALUES (1,16,2);

SELECT * FROM tbl_order; -- Trigger가 동작해서 total_order_price가 증가함

INSERT INTO tbl_order_menu
VALUES (1,3,1);

SELECT * FROM tbl_order; -- Trigger가 동작해서 누적해서 증가함

-- 나중에 상관 서브커리랑 이런식으로 trigger 사용하는것에 대해 속도 때문에 고민하게됨
-- 상관서브커리가 속도가 굉장히 느림
-- Trigger는 이력 남길때 좋음, 단 다른곳에서 직접적으로 업데이트 할때(ex. spring에서 insert와 update를 동시에)
-- 어디서 하는건지 확인하기 좀 어려움. 특히 TRIGGER를 명시 안해놓어나 너무 많은 경우
-- 나중에 설계 할 때, 트리거를 쓸지말지 우선 정해두기도 함