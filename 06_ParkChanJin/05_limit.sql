/* SELECT 해석 순서

   5 : SELECT
   1 : FROM
   2 : WHERE
   3 : GROUP BY
   4 : HAVING
   6 : ORDER BY
   7 : LIMIT
*/
/* 05_LIMIT
   - SELECT 조회 결과 집합(RESULT SET) 에서
   원하는 행의 갯수를 제한하여 반환
*/
SELECT
    *
FROM
    tbl_menu
ORDER BY
    menu_price;

-- 가장 저렴한 메뉴 TOP4 조회 (TOP-N 분석)
SELECT
    *
FROM
    tbl_menu
ORDER BY
    menu_price
LIMIT 0, 4;
-- LIMIT [OFFSET], ROW_COUNT
-- OFFSET : 시작할 행의 번호 (생략 가능)
-- ROW_COUNT : 행의 개수 (어디서부터 몇 행)


-- 가장 비싼 메뉴 TOP5 조회 (TOP-N 분석)
SELECT
    *
FROM
    tbl_menu
ORDER BY
    menu_price DESC
-- LIMIT 5;
LIMIT 0, 5;
-- OFFSET 생략 : 1행




-- 중간에 원하는 행만 조회
SELECT
    menu_code,
    menu_name,
    menu_price
FROM
    tbl_menu
ORDER BY
    menu_price DESC, menu_name ASC
LIMIT 5, 8;

