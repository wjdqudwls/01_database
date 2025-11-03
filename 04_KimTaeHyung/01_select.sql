-- 01. SELECT : 특정 테이블의 원하는 데이터(행)을 조회하는 구문

-- tbl_menu 테이블의 모든 메뉴 이름(menu_name) 조회

/*범위 주석 (단축기 ctrl + shift + /) */
/*2*/
SELECT
    menu_name
/*1*/
FROM
    tbl_menu;

-- 모든 메뉴의 menu_code, menu_name, menu_price 조회

SELECT
    menu_code,
    menu_name,
    menu_price
FROM
    tbl_menu;

-- tbl_menu 테이블 모든 열 조회

SELECT
    menu_code,
    menu_name,
    category_code,
    orderable_status
FROM
    tbl_menu;

-- *(asterrisk) == 모든
SELECT
    *
FROM
    tbl_menu;

-- FROM 없이 단독 SELECT 사용
-- == 선택할 테이블이 없다! == 어떠한 테이블도 조회하려는 데이터를 가지고 있지 않다!

SELECT 7+3;
SELECT 7*3;
SELECT 7/3;
SELECT 7-3;
SELECT 7%3; -- 나머지 구하기

SELECT 7+3, 7-3; -- 여러 컬럼(Column, 열, 세로줄) 조회도 가능

-- 내장 함수 이용
SELECT NOW();
SELECT CONCAT('홈', '길동'); -- () 내 문자열을 합쳐서 결과 출력

-- 컬럼 별칭 사용
SELECT NOW() AS 현재시간;
SELECT CONCAT('홍', '길동') AS 이름;

SELECT CONCAT('홍', '길동') AS 'full name';

-- menudb 데이터베이스 내 모든 테이블 조회해보기
SELECT
    *
FROM
    tbl_category;

SELECT * FROM tbl_menu;
SELECT * FROM tbl_order;
SELECT * FROM tbl_order_menu;
SELECT * FROM tbl_payment;

