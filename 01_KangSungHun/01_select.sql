-- 01_SELECT : 특정 테이블의 원하는 데이터(행)을 조회하는 구문


-- tbl_menu 테이블의 모든 메뉴 이름 조회(menu_name) 조회
/*범위 주석 (컨트롤 + 쉬프트 + / )*/
/*2*/
SELECT
    menu_name
/*1 첫번째로 해석! */
  from
    tbl_menu;

-- 모든 메뉴의 menu_code, menu_name, menu_price 조회
SELECT
    menu_code, menu_name, menu_price
FROM
    tbl_menu;


-- tbl_menu 테이블 모든 열 조회
SELECT
    menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
FROM
    tbl_menu;

-- 또 다른 방법으론 * <- 넣으면 된다. * == 모든

SELECT
    *
FROM
    tbl_menu;

select 7 + 3;
SELECT 7 * 3;
SELECT 7 - 3;œ
SELECT 7 / 3;
SELECT 7 % 3;

SELECT 7 + 3, 7 - 3; -- 여러 컬럼 조회도 가능

-- 내장 함수 이용
SELECT NOW();
SELECT CONCAT('홍','길동'); -- () 내 문자열을 합쳐서 결과 출력

-- 컬럼 별칭 사용
SELECT NOW() AS 현재시간;
SELECT CONCAT('홍','길동') AS 이름;
SELECT CONCAT('홍','길동') AS 'full name';
SELECT CONCAT('홍',' ','길동') AS 'full name'; -- 띄어쓰기도 문자열

-- menudb 데이터베이스 내 모든 테이블 조회해보기

SELECT * FROM tbl_category;

