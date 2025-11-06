/*
    해석 순서
    5 :SELECT
    1 :FROM
    2 :WHERE
    3 :GROUP BY
    4 :HAVING
    6: ORDER BY
    7: LIMIT


    5. LIMIT
    : SELECT 조회 결과 집합(RESULT SET)에서
    원하는 행의 갯수를 제한하여 반환
*/
SELECT
    *
FROM tbl_menu
ORDER BY
    menu_price;

-- 가장 저렴한 메뉴 TOP4 조회 ( TOP -N 분석 )
SELECT
    *
FROM tbl_menu
ORDER BY
    menu_price
-- LIMIT [OFFSET, ] ROW_COUNT;
-- OFFSET: 건너 뛸 행의 번호 [0 ...]
-- ROW_COUNT : 보여줄 행의 갯수
LIMIT 0,4;

-- 가장 비싼 메뉴 5개

SELECT
    *
FROM tbl_menu
ORDER BY
    menu_price DESC
-- LIMIT [OFFSET, ] ROW_COUNT;
-- OFFSET: 건너 뛸 행의 번호 [0 ...]
-- ROW_COUNT : 보여줄 행의 갯수
LIMIT 5;

-- 중간에 원하는 행만 조회
SELECT
    *
FROM tbl_menu
ORDER BY
    menu_price DESC, menu_name ASC
LIMIT 5, 8;