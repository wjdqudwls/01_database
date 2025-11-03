-- 01_select : 특정 테이블의 원하는 데이터(행)을 조회하는 구문

-- tbl_menu 테이블의 모든 메뉴 이름(menu_name) 조회
SELECT
   menu_name
FROM
	tbl_menu;

-- 모든 메뉴의 menu_code, menu_name, menu_price 조회

SELECT
    menu_code,
    menu_name,
    menu_price
FROM
    tbl_menu;

-- tbl_menu 테이블 모든 열 데이터 조회
SELECT
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
FROM
    tbl_menu;

-- *(asterisk) == 모든
SELECT
    *
FROM
    tbl_menu;

-- FROM 절 없이 SELECT 단독 사용
-- == 선택할 테이블이 없다!
-- == 어떠한 테이블도 조회하려는 데이터를 가지고 있지 않다
-- == 없으니까 새로 만듬
SELECT 7 + 3;
SELECT 7 - 3;
SELECT 7 * 3;
SELECT 7 / 3;
SELECT 7 % 3; -- 나머지 (Modulo, mod)

SELECT 7 + 3, 7 - 3; -- 여러 컬럼(Column) 조회도 가능

-- 내장 함수 이용
SELECT NOW(); -- 실행되는 현재 시간
SELECT CONCAT('홍','길동'); -- ()안 문자열을 합쳐서 결과 출력

-- 컬럼 별칭 사용
SELECT NOW() AS 현재시간;
SELECT CONCAT('홍','길동') AS 이름; -- ()안 문자열을 합쳐서 결과 출력

SELECT CONCAT('홍',' ', '길동') AS 'Full Name'; -- ()안 문자열을 합쳐서 결과 출력, 띄어쓰기도 문자열

-- menudb 데이터 베이스 내 모든 테이블 조회 해보기
SELECT * FROM tbl_category;
SELECT * FROM tbl_menu;
SELECT * FROM tbl_order;
SELECT * FROM tbl_order_menu;
SELECT * FROM tbl_payment;
SELECT * FROM tbl_payment_order;
